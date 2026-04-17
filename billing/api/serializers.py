from rest_framework import serializers

from .models import Payment, PaymentLog, Refund, Transaction, WalletBalance, WalletHistory


class TransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = Transaction
        fields = '__all__'


class PaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = '__all__'


class PaymentLogSerializer(serializers.ModelSerializer):
    class Meta:
        model = PaymentLog
        fields = '__all__'


class WalletBalanceSerializer(serializers.ModelSerializer):
    class Meta:
        model = WalletBalance
        fields = '__all__'


class WalletHistorySerializer(serializers.ModelSerializer):
    class Meta:
        model = WalletHistory
        fields = '__all__'


class RefundSerializer(serializers.ModelSerializer):
    class Meta:
        model = Refund
        fields = '__all__'
