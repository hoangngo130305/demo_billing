from django.db import models


class PaymentStatus(models.TextChoices):
	PENDING = 'PENDING', 'Pending'
	SUCCESS = 'SUCCESS', 'Success'
	FAILED = 'FAILED', 'Failed'
	CANCELLED = 'CANCELLED', 'Cancelled'


class PaymentMethod(models.TextChoices):
	QR = 'QR', 'QR'
	VNPAY = 'VNPAY', 'VNPay'
	CASH = 'CASH', 'Cash'


class LogType(models.TextChoices):
	WEBHOOK = 'WEBHOOK', 'Webhook'
	MANUAL = 'MANUAL', 'Manual'
	SYSTEM = 'SYSTEM', 'System'


class WalletHistoryType(models.TextChoices):
	TOP_UP = 'TOP_UP', 'Top up'
	SPEND = 'SPEND', 'Spend'
	REFUND = 'REFUND', 'Refund'
	ADJUSTMENT = 'ADJUSTMENT', 'Adjustment'


class RefundStatus(models.TextChoices):
	PENDING = 'PENDING', 'Pending'
	APPROVED = 'APPROVED', 'Approved'
	REJECTED = 'REJECTED', 'Rejected'
	COMPLETED = 'COMPLETED', 'Completed'


class Transaction(models.Model):
	order_code = models.BigIntegerField(unique=True)
	user_id = models.CharField(max_length=100, blank=True, null=True)
	amount = models.PositiveBigIntegerField()
	status = models.CharField(max_length=20, choices=PaymentStatus.choices, default=PaymentStatus.PENDING)
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		db_table = 'transactions'
		ordering = ['-created_at']

	def __str__(self):
		return f'{self.order_code} - {self.status}'


class Payment(models.Model):
	order_code = models.BigIntegerField(unique=True)
	user_id = models.CharField(max_length=100)
	amount = models.PositiveBigIntegerField()
	currency = models.CharField(max_length=3, default='VND')
	method = models.CharField(max_length=10, choices=PaymentMethod.choices, default=PaymentMethod.QR)
	status = models.CharField(max_length=20, choices=PaymentStatus.choices, default=PaymentStatus.PENDING)
	transaction_code = models.CharField(max_length=100, blank=True, null=True)
	payment_url = models.URLField(max_length=1000, blank=True, null=True)
	qr_code = models.TextField(blank=True, null=True)
	description = models.CharField(max_length=255, blank=True, null=True)
	paid_at = models.DateTimeField(blank=True, null=True)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	class Meta:
		db_table = 'payments'
		ordering = ['-created_at']

	def __str__(self):
		return f'{self.order_code} - {self.amount} {self.currency}'


class PaymentLog(models.Model):
	payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, null=True, blank=True, related_name='logs')
	order_code = models.BigIntegerField(blank=True, null=True)
	type = models.CharField(max_length=20, choices=LogType.choices, default=LogType.WEBHOOK)
	raw_data = models.JSONField(blank=True, null=True)
	status_code = models.CharField(max_length=20, blank=True, null=True)
	ip_address = models.GenericIPAddressField(blank=True, null=True)
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		db_table = 'payment_logs'
		ordering = ['-created_at']


class WalletBalance(models.Model):
	user_id = models.CharField(max_length=100, unique=True)
	balance = models.BigIntegerField(default=0)
	total_top_up = models.BigIntegerField(default=0)
	total_spent = models.BigIntegerField(default=0)
	last_updated = models.DateTimeField(auto_now=True)

	class Meta:
		db_table = 'wallet_balances'

	def __str__(self):
		return f'{self.user_id} - {self.balance} VND'


class WalletHistory(models.Model):
	user_id = models.CharField(max_length=100)
	order_code = models.BigIntegerField(blank=True, null=True)
	type = models.CharField(max_length=20, choices=WalletHistoryType.choices)
	amount = models.BigIntegerField()
	balance_before = models.BigIntegerField(blank=True, null=True)
	balance_after = models.BigIntegerField(blank=True, null=True)
	note = models.CharField(max_length=255, blank=True, null=True)
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		db_table = 'wallet_history'
		ordering = ['-created_at']


class Refund(models.Model):
	payment = models.ForeignKey(Payment, on_delete=models.CASCADE, related_name='refunds')
	user_id = models.CharField(max_length=100)
	amount = models.PositiveBigIntegerField()
	reason = models.TextField(blank=True, null=True)
	status = models.CharField(max_length=20, choices=RefundStatus.choices, default=RefundStatus.PENDING)
	processed_by = models.CharField(max_length=100, blank=True, null=True)
	processed_at = models.DateTimeField(blank=True, null=True)
	created_at = models.DateTimeField(auto_now_add=True)

	class Meta:
		db_table = 'refunds'
		ordering = ['-created_at']
