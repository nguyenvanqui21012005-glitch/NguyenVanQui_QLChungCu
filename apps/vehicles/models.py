from django.db import models

from apps.buildings.models import Apartment
from apps.core.models import BaseModel
from apps.residents.models import Resident


class ParkingSlot(BaseModel):
    class SlotType(models.TextChoices):
        CAR = "CAR", "Ô tô"
        MOTORBIKE = "MOTORBIKE", "Xe máy"
        BICYCLE = "BICYCLE", "Xe đạp"

    class Status(models.TextChoices):
        AVAILABLE = "AVAILABLE", "Còn trống"
        OCCUPIED = "OCCUPIED", "Đang dùng"

    slot_number = models.CharField(max_length=20, unique=True)
    slot_type = models.CharField(max_length=15, choices=SlotType.choices)
    floor = models.CharField(max_length=20, blank=True, null=True, verbose_name="Tầng hầm/bãi")
    status = models.CharField(max_length=10, choices=Status.choices, default=Status.AVAILABLE)
    monthly_fee = models.DecimalField(max_digits=10, decimal_places=0, default=0)
    note = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "vehicles_parkingslot"
        verbose_name = "Chỗ đậu xe"
        ordering = ["slot_number"]

    def __str__(self):
        return f"Chỗ {self.slot_number} ({self.get_slot_type_display()})"


class Vehicle(BaseModel):
    class VehicleType(models.TextChoices):
        CAR = "CAR", "Ô tô"
        MOTORBIKE = "MOTORBIKE", "Xe máy"
        BICYCLE = "BICYCLE", "Xe đạp"
        OTHER = "OTHER", "Khác"

    resident = models.ForeignKey(Resident, on_delete=models.CASCADE, related_name="vehicles")
    apartment = models.ForeignKey(Apartment, on_delete=models.CASCADE, related_name="vehicles")
    vehicle_type = models.CharField(max_length=15, choices=VehicleType.choices)
    license_plate = models.CharField(max_length=20, verbose_name="Biển số xe", unique=True)
    brand = models.CharField(max_length=100, blank=True, null=True, verbose_name="Hãng xe")
    model = models.CharField(max_length=100, blank=True, null=True, verbose_name="Mẫu xe")
    color = models.CharField(max_length=50, blank=True, null=True, verbose_name="Màu sắc")
    parking_slot = models.ForeignKey(
        ParkingSlot,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="vehicles",
    )
    card_number = models.CharField(max_length=50, blank=True, null=True, verbose_name="Số thẻ xe")
    registered_date = models.DateField(auto_now_add=True)
    image = models.ImageField(upload_to="vehicles/%Y/%m/", blank=True, null=True)
    note = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "vehicles_vehicle"
        verbose_name = "Phương tiện"
        ordering = ["license_plate"]

    def __str__(self):
        return f"{self.license_plate} - {self.resident.full_name}"

    def delete(self, using=None, keep_parents=False):
        slot = self.parking_slot
        super().delete(using=using, keep_parents=keep_parents)
        if slot:
            slot.status = ParkingSlot.Status.AVAILABLE
            slot.save(update_fields=["status"])

