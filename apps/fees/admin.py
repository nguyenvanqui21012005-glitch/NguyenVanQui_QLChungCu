from django.contrib import admin

from .models import FeeType, Invoice, Payment


@admin.register(FeeType)
class FeeTypeAdmin(admin.ModelAdmin):
    list_display = ("name", "unit", "unit_price", "is_mandatory")
    list_filter = ("unit", "is_mandatory")
    search_fields = ("name",)


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ("fee_type", "apartment", "resident", "month", "year", "amount", "status")
    list_filter = ("status", "fee_type", "month", "year")
    search_fields = ("resident__full_name", "apartment__apartment_number")


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ("invoice", "amount_paid", "paid_at", "method", "received_by")
    list_filter = ("method",)

