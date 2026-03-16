from django.db import models
from django.utils import timezone

from apps.buildings.models import Apartment
from apps.core.models import BaseModel
from apps.residents.models import Resident


class FeeType(BaseModel):
    class Unit(models.TextChoices):
        MONTH = "MONTH", "Tháng"
        M2 = "M2", "m²"
        VEHICLE = "VEHICLE", "Xe"
        KWH = "KWH", "kWh"
        M3 = "M3", "m³"
        USAGE = "USAGE", "Lần dùng"
        FIXED = "FIXED", "Cố định"

    name = models.CharField(max_length=200, verbose_name="Tên loại phí")
    description = models.TextField(blank=True, null=True)
    unit = models.CharField(max_length=10, choices=Unit.choices, default=Unit.MONTH)
    unit_price = models.DecimalField(max_digits=12, decimal_places=0, verbose_name="Đơn giá (VNĐ)")
    is_mandatory = models.BooleanField(default=True, verbose_name="Bắt buộc")
    apply_to_all = models.BooleanField(default=True, verbose_name="Áp dụng tất cả căn hộ")

    class Meta:
        db_table = "fees_feetype"
        verbose_name = "Loại phí"
        ordering = ["name"]

    def __str__(self):
        return self.name


class Invoice(BaseModel):
    class Status(models.TextChoices):
        PENDING = "PENDING", "Chờ thanh toán"
        PAID = "PAID", "Đã thanh toán"
        OVERDUE = "OVERDUE", "Quá hạn"
        CANCELLED = "CANCELLED", "Đã hủy"
        PARTIAL = "PARTIAL", "Thanh toán một phần"

    fee_type = models.ForeignKey(FeeType, on_delete=models.PROTECT, related_name="invoices")
    apartment = models.ForeignKey(Apartment, on_delete=models.CASCADE, related_name="invoices")
    resident = models.ForeignKey(Resident, on_delete=models.CASCADE, related_name="invoices")
    month = models.PositiveSmallIntegerField(verbose_name="Tháng")
    year = models.PositiveSmallIntegerField(verbose_name="Năm")
    amount = models.DecimalField(max_digits=12, decimal_places=0, verbose_name="Số tiền")
    due_date = models.DateField(verbose_name="Hạn thanh toán")
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING)
    note = models.TextField(blank=True, null=True)
    created_by = models.ForeignKey(
        "accounts.User", on_delete=models.SET_NULL, null=True, related_name="created_invoices"
    )

    class Meta:
        db_table = "fees_invoice"
        verbose_name = "Hóa đơn"
        unique_together = ("fee_type", "apartment", "month", "year")
        ordering = ["-year", "-month", "-created_at"]

    def __str__(self):
        return f"{self.fee_type.name} - {self.apartment} - {self.month}/{self.year}"

    @property
    def total_paid(self):
        return self.payments.aggregate(total=models.Sum("amount_paid"))["total"] or 0

    @property
    def remaining(self):
        value = self.amount - self.total_paid
        return value if value > 0 else 0

    def update_status(self):
        if self.status == self.Status.CANCELLED:
            return
        paid = self.total_paid
        today = timezone.localdate()
        if paid >= self.amount:
            status = self.Status.PAID
        elif today > self.due_date:
            status = self.Status.OVERDUE
        elif paid > 0:
            status = self.Status.PARTIAL
        else:
            status = self.Status.PENDING
        if status != self.status:
            self.status = status
            self.save(update_fields=["status"])


class Payment(models.Model):
    class Method(models.TextChoices):
        CASH = "CASH", "Tiền mặt"
        TRANSFER = "TRANSFER", "Chuyển khoản"
        MOMO = "MOMO", "MoMo"
        VNPAY = "VNPAY", "VNPay"
        OTHER = "OTHER", "Khác"

    invoice = models.ForeignKey(Invoice, on_delete=models.PROTECT, related_name="payments")
    amount_paid = models.DecimalField(max_digits=12, decimal_places=0, verbose_name="Số tiền đã trả")
    paid_at = models.DateTimeField(verbose_name="Thời gian thanh toán")
    method = models.CharField(max_length=10, choices=Method.choices, default=Method.CASH)
    transaction_id = models.CharField(max_length=100, blank=True, null=True, verbose_name="Mã giao dịch")
    received_by = models.ForeignKey(
        "accounts.User", on_delete=models.SET_NULL, null=True, related_name="received_payments"
    )
    note = models.TextField(blank=True, null=True)
    receipt_image = models.ImageField(upload_to="receipts/%Y/%m/", blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table = "fees_payment"
        verbose_name = "Thanh toán"
        ordering = ["-paid_at"]

    def save(self, *args, **kwargs):
        super().save(*args, **kwargs)
        if not self.transaction_id:
            tx = f"GD-{self.pk:03d}"
            Payment.objects.filter(pk=self.pk, transaction_id__isnull=True).update(transaction_id=tx)
            Payment.objects.filter(pk=self.pk, transaction_id="").update(transaction_id=tx)
            self.transaction_id = tx
        self.invoice.update_status()
