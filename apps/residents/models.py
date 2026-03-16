from django.db import models
from django.utils import timezone

from apps.buildings.models import Apartment
from apps.core.models import BaseModel


class Resident(BaseModel):
    class Gender(models.TextChoices):
        MALE = "M", "Nam"
        FEMALE = "F", "Nữ"
        OTHER = "O", "Khác"

    full_name = models.CharField(max_length=200, verbose_name="Họ và tên")
    id_number = models.CharField(max_length=20, unique=True, verbose_name="Số CCCD/CMND")
    phone = models.CharField(max_length=15, verbose_name="Số điện thoại")
    email = models.EmailField(blank=True, null=True)
    date_of_birth = models.DateField(null=True, blank=True)
    gender = models.CharField(max_length=1, choices=Gender.choices, blank=True, null=True)
    hometown = models.CharField(max_length=200, blank=True, null=True, verbose_name="Quê quán")
    permanent_address = models.TextField(blank=True, null=True, verbose_name="Địa chỉ thường trú")
    avatar = models.ImageField(upload_to="residents/%Y/%m/", blank=True, null=True)
    emergency_contact_name = models.CharField(
        max_length=200, blank=True, null=True, verbose_name="Người liên hệ khẩn cấp"
    )
    emergency_contact_phone = models.CharField(max_length=15, blank=True, null=True)
    note = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "residents_resident"
        verbose_name = "Cư dân"
        ordering = ["full_name"]

    def __str__(self):
        return self.full_name

    @property
    def active_contract(self):
        return (
            self.contracts.filter(status=Contract.Status.ACTIVE, deleted_at__isnull=True)
            .select_related("apartment")
            .first()
        )

    @property
    def current_apartment(self):
        contract = self.active_contract
        return contract.apartment if contract else None


class Contract(BaseModel):
    class Status(models.TextChoices):
        ACTIVE = "ACTIVE", "Đang hiệu lực"
        EXPIRED = "EXPIRED", "Đã hết hạn"
        CANCELLED = "CANCELLED", "Đã hủy"
        PENDING = "PENDING", "Chờ duyệt"

    resident = models.ForeignKey(Resident, on_delete=models.CASCADE, related_name="contracts")
    apartment = models.ForeignKey(Apartment, on_delete=models.CASCADE, related_name="contracts")
    start_date = models.DateField(verbose_name="Ngày bắt đầu")
    end_date = models.DateField(verbose_name="Ngày kết thúc")
    rent_amount = models.DecimalField(max_digits=12, decimal_places=0, verbose_name="Tiền thuê (VNĐ/tháng)")
    deposit = models.DecimalField(max_digits=12, decimal_places=0, default=0, verbose_name="Tiền đặt cọc")
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING)
    contract_file = models.FileField(upload_to="contracts/%Y/%m/", blank=True, null=True, verbose_name="File hợp đồng")
    created_by = models.ForeignKey(
        "accounts.User", on_delete=models.SET_NULL, null=True, related_name="created_contracts"
    )
    note = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "residents_contract"
        verbose_name = "Hợp đồng"
        ordering = ["-start_date"]

    def __str__(self):
        return f"HĐ {self.resident.full_name} - {self.apartment}"

    def activate(self):
        self.status = self.Status.ACTIVE
        self.save(update_fields=["status"])
        self.apartment.status = Apartment.Status.OCCUPIED
        self.apartment.save(update_fields=["status"])

    def cancel(self):
        self.status = self.Status.CANCELLED
        self.save(update_fields=["status"])
        self._maybe_release_apartment()

    def expire(self):
        self.status = self.Status.EXPIRED
        self.save(update_fields=["status"])
        self._maybe_release_apartment()

    def terminate(self):
        self.cancel()

    def _maybe_release_apartment(self):
        other_active = (
            Contract.objects.filter(apartment=self.apartment, status=Contract.Status.ACTIVE)
            .exclude(pk=self.pk)
            .exists()
        )
        if not other_active:
            self.apartment.status = Apartment.Status.AVAILABLE
            self.apartment.save(update_fields=["status"])

    @property
    def is_expired_by_date(self):
        return self.end_date < timezone.localdate()

