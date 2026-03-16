from django.db import models

from apps.buildings.models import Apartment
from apps.core.models import BaseModel
from apps.residents.models import Resident


class MaintenanceRequest(BaseModel):
    class Category(models.TextChoices):
        ELECTRIC = "ELECTRIC", "Điện"
        PLUMBING = "PLUMBING", "Nước / Ống dẫn"
        HVAC = "HVAC", "Điều hòa / Thông gió"
        ELEVATOR = "ELEVATOR", "Thang máy"
        SECURITY = "SECURITY", "An ninh / Khóa cửa"
        PAINTING = "PAINTING", "Sơn tường"
        FLOOR = "FLOOR", "Sàn nhà"
        OTHER = "OTHER", "Khác"

    class Priority(models.TextChoices):
        LOW = "LOW", "Thấp"
        MEDIUM = "MEDIUM", "Trung bình"
        HIGH = "HIGH", "Cao"
        URGENT = "URGENT", "Khẩn cấp"

    class Status(models.TextChoices):
        PENDING = "PENDING", "Chờ xử lý"
        ASSIGNED = "ASSIGNED", "Đã phân công"
        IN_PROCESS = "IN_PROCESS", "Đang xử lý"
        RESOLVED = "RESOLVED", "Đã giải quyết"
        CLOSED = "CLOSED", "Đã đóng"
        REJECTED = "REJECTED", "Từ chối"

    resident = models.ForeignKey(
        Resident,
        on_delete=models.CASCADE,
        related_name="maintenance_requests",
        null=True,
        blank=True,
    )
    apartment = models.ForeignKey(Apartment, on_delete=models.CASCADE, related_name="maintenance_requests")
    category = models.CharField(max_length=20, choices=Category.choices)
    title = models.CharField(max_length=300, verbose_name="Tiêu đề")
    description = models.TextField(verbose_name="Mô tả chi tiết")
    priority = models.CharField(max_length=10, choices=Priority.choices, default=Priority.MEDIUM)
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.PENDING)
    image = models.ImageField(upload_to="maintenance/%Y/%m/", blank=True, null=True)
    assigned_to = models.ForeignKey(
        "accounts.User",
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_maintenance",
    )
    assigned_at = models.DateTimeField(null=True, blank=True)
    resolved_at = models.DateTimeField(null=True, blank=True)
    resolution_note = models.TextField(blank=True, null=True)
    estimated_cost = models.DecimalField(max_digits=12, decimal_places=0, null=True, blank=True)
    actual_cost = models.DecimalField(max_digits=12, decimal_places=0, null=True, blank=True)

    class Meta:
        db_table = "maintenance_request"
        verbose_name = "Yêu cầu bảo trì"
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.title} - {self.apartment}"

