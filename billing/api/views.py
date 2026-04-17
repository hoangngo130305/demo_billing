import time

from django.conf import settings
from django.db import transaction as db_transaction
from django.utils import timezone
from payos import PayOS, WebhookError
from payos.types import CreatePaymentLinkRequest
from django.views.decorators.csrf import csrf_exempt
from rest_framework import status, viewsets
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.permissions import AllowAny
from rest_framework.response import Response

from .models import (
	Payment,
	PaymentLog,
	PaymentStatus,
	Refund,
	Transaction,
	WalletBalance,
	WalletHistory,
	WalletHistoryType,
)
from .serializers import (
	PaymentLogSerializer,
	PaymentSerializer,
	RefundSerializer,
	TransactionSerializer,
	WalletBalanceSerializer,
	WalletHistorySerializer,
)

# ---------------------------------------------------------------------------
# Lazy PayOS client — instantiated once, after settings are loaded
# ---------------------------------------------------------------------------

_payos_client = None


def _pick(payload, *keys, default=None):
	"""Read value from object or dict payload across multiple key styles."""
	for key in keys:
		if isinstance(payload, dict) and key in payload:
			return payload.get(key)
		if hasattr(payload, key):
			return getattr(payload, key)
	return default


def get_payos():
	global _payos_client
	if _payos_client is None:
		_payos_client = PayOS(
			client_id=settings.PAYOS_CLIENT_ID,
			api_key=settings.PAYOS_API_KEY,
			checksum_key=settings.PAYOS_CHECKSUM_KEY,
		)
	return _payos_client


def mark_payment_success(order_code, amount=None, source='SYSTEM'):
	"""Finalize payment once (idempotent): transaction/payment status + wallet + history."""
	with db_transaction.atomic():
		txn = Transaction.objects.select_for_update().filter(order_code=order_code).first()
		if txn is None:
			return {'ok': False, 'reason': 'transaction_not_found'}

		# Prevent duplicate wallet credit if webhook/check endpoint runs many times.
		if txn.status == PaymentStatus.SUCCESS:
			return {'ok': True, 'reason': 'already_success', 'amount': int(txn.amount)}

		payment_obj = Payment.objects.select_for_update().filter(order_code=order_code).first()
		final_amount = int(amount if amount is not None else txn.amount)

		txn.status = PaymentStatus.SUCCESS
		txn.save(update_fields=['status'])

		if payment_obj:
			payment_obj.status = PaymentStatus.SUCCESS
			payment_obj.paid_at = timezone.now()
			payment_obj.save(update_fields=['status', 'paid_at', 'updated_at'])

		user_id = (payment_obj.user_id if payment_obj else txn.user_id) or 'demo_user'
		wallet, _ = WalletBalance.objects.select_for_update().get_or_create(
			user_id=user_id,
			defaults={'balance': 0, 'total_top_up': 0, 'total_spent': 0},
		)
		balance_before = wallet.balance
		wallet.balance += final_amount
		wallet.total_top_up += final_amount
		wallet.save(update_fields=['balance', 'total_top_up', 'last_updated'])

		WalletHistory.objects.create(
			user_id=user_id,
			order_code=order_code,
			type=WalletHistoryType.TOP_UP,
			amount=final_amount,
			balance_before=balance_before,
			balance_after=wallet.balance,
			note=f'Nạp tiền PayOS ({source}) - OrderCode {order_code}',
		)

		if source != 'WEBHOOK':
			PaymentLog.objects.create(
				payment=payment_obj,
				order_code=order_code,
				type='SYSTEM',
				raw_data={
					'event': 'MARK_SUCCESS',
					'source': source,
					'amount': final_amount,
				},
				status_code='SUCCESS',
			)

		return {
			'ok': True,
			'reason': 'updated',
			'amount': final_amount,
			'user_id': user_id,
		}


# ---------------------------------------------------------------------------
# Business API endpoints
# ---------------------------------------------------------------------------

@csrf_exempt
@api_view(['POST'])
@authentication_classes([])
@permission_classes([AllowAny])
def create_payment(request):
	"""Tạo payment link PayOS, lưu Transaction + Payment vào MySQL."""
	data = request.data or {}
	try:
		amount = int(data.get('amount', 0))
	except (TypeError, ValueError):
		return Response({'error': 'Số tiền không hợp lệ'}, status=status.HTTP_400_BAD_REQUEST)

	if amount < 10000:
		return Response({'error': 'Số tiền tối thiểu là 10.000 VND'}, status=status.HTTP_400_BAD_REQUEST)

	user_id = data.get('user_id', 'demo_user') or 'demo_user'
	order_code = int(time.time() * 1000)

	payment_req = CreatePaymentLinkRequest(
		order_code=order_code,
		amount=amount,
		description='NAPVISEMS',
		return_url=settings.PAYOS_RETURN_URL,
		cancel_url=settings.PAYOS_CANCEL_URL,
	)

	try:
		link = get_payos().payment_requests.create(payment_req)
	except Exception as exc:
		print('Lỗi tạo PayOS payment:', exc)
		return Response({'error': str(exc)}, status=status.HTTP_502_BAD_GATEWAY)

	with db_transaction.atomic():
		Transaction.objects.create(
			order_code=order_code,
			user_id=user_id,
			amount=amount,
			status=PaymentStatus.PENDING,
		)
		payment = Payment.objects.create(
			order_code=order_code,
			user_id=user_id,
			amount=amount,
			status=PaymentStatus.PENDING,
			payment_url=link.checkout_url,
			qr_code=link.qr_code,
			description='NAPVISEMS',
		)
		PaymentLog.objects.create(
			payment=payment,
			order_code=order_code,
			type='SYSTEM',
			raw_data={'event': 'CREATE_PAYMENT', 'amount': amount},
			status_code='PENDING',
		)

	return Response({
		'qrCode': link.qr_code,
		'checkoutUrl': link.checkout_url,
		'orderCode': order_code,
	})


@api_view(['GET'])
@authentication_classes([])
@permission_classes([AllowAny])
def check_payment_status(request, order_code):
	"""Trả về trạng thái giao dịch để frontend polling."""
	try:
		txn = Transaction.objects.get(order_code=order_code)
	except Transaction.DoesNotExist:
		return Response({'error': 'Không tìm thấy giao dịch'}, status=status.HTTP_404_NOT_FOUND)

	# Fallback sync: if webhook is delayed/missed, sync status directly from PayOS.
	if txn.status != PaymentStatus.SUCCESS:
		try:
			payos_payment = get_payos().payment_requests.get(order_code)
			payos_status = _pick(payos_payment, 'status', default='')
			payos_amount = _pick(payos_payment, 'amount_paid', 'amount', default=txn.amount)

			if str(payos_status).upper() == 'PAID':
				mark_result = mark_payment_success(order_code=order_code, amount=payos_amount, source='POLL_SYNC')
				print(f"[POLL_SYNC] order={order_code} result={mark_result}")
				txn.refresh_from_db(fields=['status'])
		except Exception as exc:
			print(f"[POLL_SYNC] Cannot sync order {order_code} from PayOS: {exc}")

	return Response({
		'orderCode': order_code,
		'status': txn.status,
		'amount': txn.amount,
		'message': 'Thanh toán thành công' if txn.status == PaymentStatus.SUCCESS else 'Đang chờ thanh toán...',
	})


@csrf_exempt
@api_view(['POST'])
@authentication_classes([])
@permission_classes([AllowAny])
def payos_webhook(request):
	"""Nhận webhook từ PayOS, xác thực chữ ký, cập nhật DB và cộng ví."""
	raw_body = request.body
	ip = request.META.get('REMOTE_ADDR', '')

	print('\n=== PAYOS WEBHOOK ĐƯỢC GỌI ===')
	print('Time:', timezone.now().strftime('%Y-%m-%d %H:%M:%S'))

	try:
		webhook_data = get_payos().webhooks.verify(raw_body)
	except WebhookError as exc:
		print('❌ Signature không hợp lệ:', exc)
		# PayOS yêu cầu luôn trả 200 dù lỗi
		return Response({'message': 'OK'})
	except Exception as exc:
		print('❌ Lỗi xác thực webhook:', exc)
		return Response({'message': 'OK'})

	wh_data = webhook_data.data if hasattr(webhook_data, 'data') else webhook_data
	code = _pick(wh_data, 'code', 'status')
	order_code = _pick(wh_data, 'order_code', 'orderCode')
	amount = _pick(wh_data, 'amount')

	try:
		order_code = int(order_code)
	except (TypeError, ValueError):
		order_code = None

	try:
		amount = int(amount)
	except (TypeError, ValueError):
		amount = 0

	code_str = str(code).zfill(2) if code is not None else ''

	print(f'Code: {code_str} | OrderCode: {order_code} | Amount: {amount}')

	# Ghi log webhook vào DB
	try:
		payment_obj = Payment.objects.filter(order_code=order_code).first()
		PaymentLog.objects.create(
			payment=payment_obj,
			order_code=order_code,
			type='WEBHOOK',
			raw_data=dict(code=code_str, order_code=order_code, amount=amount),
			status_code=code_str,
			ip_address=ip if ip else None,
		)
	except Exception as log_exc:
		print('Lỗi ghi PaymentLog:', log_exc)

	if code_str == '00' and order_code is not None and amount > 0:
		try:
			result = mark_payment_success(order_code=order_code, amount=amount, source='WEBHOOK')
			print(f"🎉 WEBHOOK DONE — order={order_code} result={result}")
		except Exception as exc:
			import traceback
			print('❌ Lỗi xử lý webhook thành công:', exc)
			traceback.print_exc()
	else:
		print(f'⚠️  Bỏ qua webhook (code={code_str}, order_code={order_code}, amount={amount})')

	return Response({'message': 'OK'})


# ---------------------------------------------------------------------------
# CRUD ViewSets (Django Admin / DRF browsable API)
# ---------------------------------------------------------------------------

class TransactionViewSet(viewsets.ModelViewSet):
	queryset = Transaction.objects.all()
	serializer_class = TransactionSerializer


class PaymentViewSet(viewsets.ModelViewSet):
	queryset = Payment.objects.all()
	serializer_class = PaymentSerializer


class PaymentLogViewSet(viewsets.ModelViewSet):
	queryset = PaymentLog.objects.all()
	serializer_class = PaymentLogSerializer


class WalletBalanceViewSet(viewsets.ModelViewSet):
	queryset = WalletBalance.objects.all()
	serializer_class = WalletBalanceSerializer


class WalletHistoryViewSet(viewsets.ModelViewSet):
	queryset = WalletHistory.objects.all()
	serializer_class = WalletHistorySerializer


class RefundViewSet(viewsets.ModelViewSet):
	queryset = Refund.objects.all()
	serializer_class = RefundSerializer
