from django.urls import include, path
from rest_framework.routers import DefaultRouter

from .views import (
    PaymentLogViewSet,
    PaymentViewSet,
    RefundViewSet,
    TransactionViewSet,
    WalletBalanceViewSet,
    WalletHistoryViewSet,
    check_payment_status,
    create_payment,
    payos_webhook,
)

router = DefaultRouter()
router.register('transactions', TransactionViewSet, basename='transaction')
router.register('payments', PaymentViewSet, basename='payment')
router.register('payment-logs', PaymentLogViewSet, basename='payment-log')
router.register('wallet-balances', WalletBalanceViewSet, basename='wallet-balance')
router.register('wallet-history', WalletHistoryViewSet, basename='wallet-history')
router.register('refunds', RefundViewSet, basename='refund')

urlpatterns = [
    # PayOS business endpoints
    path('create-payment', create_payment, name='create-payment'),
    path('check-payment-status/<int:order_code>', check_payment_status, name='check-payment-status'),
    path('webhook/payos', payos_webhook, name='payos-webhook'),
    # CRUD / DRF browsable API
    path('', include(router.urls)),
]
