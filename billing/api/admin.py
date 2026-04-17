from django.contrib import admin
from django.db import models

from .models import Payment, PaymentLog, Refund, Transaction, WalletBalance, WalletHistory


class AutoModelAdmin(admin.ModelAdmin):
	"""ModelAdmin with auto-generated list_display/search/list_filter for quick back-office setup."""

	list_per_page = 25

	def get_list_display(self, request):
		fields = [field.name for field in self.model._meta.fields]
		preferred = ["id", "order_code", "user_id", "amount", "status", "created_at", "updated_at"]
		ordered = [name for name in preferred if name in fields]
		for field_name in fields:
			if field_name not in ordered:
				ordered.append(field_name)
			if len(ordered) >= 8:
				break
		return tuple(ordered)

	def get_search_fields(self, request):
		search_fields = []
		for field in self.model._meta.fields:
			if isinstance(field, (models.CharField, models.TextField, models.EmailField)):
				search_fields.append(field.name)
		return tuple(search_fields[:6])

	def get_list_filter(self, request):
		filters = []
		for field in self.model._meta.fields:
			if isinstance(field, (models.BooleanField, models.DateField, models.DateTimeField)):
				filters.append(field.name)
			if getattr(field, "choices", None):
				filters.append(field.name)
		# Keep ordering and remove duplicates
		deduped = []
		for item in filters:
			if item not in deduped:
				deduped.append(item)
		return tuple(deduped[:6])


@admin.register(Transaction)
class TransactionAdmin(AutoModelAdmin):
	pass


@admin.register(Payment)
class PaymentAdmin(AutoModelAdmin):
	pass


@admin.register(PaymentLog)
class PaymentLogAdmin(AutoModelAdmin):
	pass


@admin.register(WalletBalance)
class WalletBalanceAdmin(AutoModelAdmin):
	pass


@admin.register(WalletHistory)
class WalletHistoryAdmin(AutoModelAdmin):
	pass


@admin.register(Refund)
class RefundAdmin(AutoModelAdmin):
	pass
