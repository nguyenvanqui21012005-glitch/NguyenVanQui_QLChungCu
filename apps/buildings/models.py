from django.db import models

from apps.accounts.models import User
from apps.core.models import BaseModel


class Building(BaseModel):
    name = models.CharField(max_length=200, verbose_name="Tên tòa nhà")
    address = models.TextField(verbose_name="Địa chỉ")
    total_floors = models.PositiveIntegerField(default=1)
    description = models.TextField(blank=True, null=True)
    image = models.ImageField(upload_to="buildings/%Y/%m/", blank=True, null=True)
    built_year = models.PositiveIntegerField(null=True, blank=True)
    manager = models.ForeignKey(
        User,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="managed_buildings",
        verbose_name="Quản lý",
    )
    phone = models.CharField(max_length=15, blank=True, null=True)
    email = models.EmailField(blank=True, null=True)

    class Meta:
        db_table = "buildings_building"
        verbose_name = "Tòa nhà"
        ordering = ["name"]

    def __str__(self):
        return self.name

    @property
    def total_apartments(self):
        return (
            self.floors.filter(deleted_at__isnull=True)
            .aggregate(total=models.Count("apartments"))
            .get("total", 0)
        )

    @property
    def occupied_apartments(self):
        return Apartment.objects.filter(floor__building=self, status=Apartment.Status.OCCUPIED).count()


class Floor(BaseModel):
    building = models.ForeignKey(Building, on_delete=models.CASCADE, related_name="floors")
    floor_number = models.PositiveIntegerField(verbose_name="Số tầng")
    name = models.CharField(max_length=50, blank=True, null=True)

    class Meta:
        db_table = "buildings_floor"
        verbose_name = "Tầng"
        unique_together = ("building", "floor_number")
        ordering = ["floor_number"]

    def __str__(self):
        return f"{self.building.name} - Tầng {self.floor_number}"


class Apartment(BaseModel):
    class Status(models.TextChoices):
        AVAILABLE = "AVAILABLE", "Còn trống"
        OCCUPIED = "OCCUPIED", "Đang ở"
        MAINTENANCE = "MAINTENANCE", "Đang bảo trì"
        RESERVED = "RESERVED", "Đã đặt cọc"

    class Direction(models.TextChoices):
        NORTH = "N", "Bắc"
        SOUTH = "S", "Nam"
        EAST = "E", "Đông"
        WEST = "W", "Tây"
        NORTHEAST = "NE", "Đông Bắc"
        NORTHWEST = "NW", "Tây Bắc"
        SOUTHEAST = "SE", "Đông Nam"
        SOUTHWEST = "SW", "Tây Nam"

    floor = models.ForeignKey(Floor, on_delete=models.CASCADE, related_name="apartments")
    apartment_number = models.CharField(max_length=20, verbose_name="Số căn hộ")
    area = models.DecimalField(max_digits=8, decimal_places=2, verbose_name="Diện tích (m²)")
    bedroom_count = models.PositiveSmallIntegerField(default=1)
    bathroom_count = models.PositiveSmallIntegerField(default=1)
    status = models.CharField(max_length=20, choices=Status.choices, default=Status.AVAILABLE)
    rent_price = models.DecimalField(max_digits=12, decimal_places=0, verbose_name="Giá thuê (VNĐ/tháng)")
    direction = models.CharField(max_length=2, choices=Direction.choices, blank=True, null=True)
    image = models.ImageField(upload_to="apartments/%Y/%m/", blank=True, null=True)
    description = models.TextField(blank=True, null=True)
    balcony = models.BooleanField(default=False)
    furniture_included = models.BooleanField(default=False, verbose_name="Có nội thất")

    class Meta:
        db_table = "buildings_apartment"
        verbose_name = "Căn hộ"
        unique_together = ("floor", "apartment_number")
        ordering = ["floor__floor_number", "apartment_number"]

    def __str__(self):
        return f"{self.floor.building.name} - {self.apartment_number}"

    @property
    def building(self):
        return self.floor.building

    @property
    def current_contract(self):
        from apps.residents.models import Contract

        return (
            self.contracts.filter(status=Contract.Status.ACTIVE, deleted_at__isnull=True)
            .select_related("resident")
            .first()
        )

    @property
    def current_resident(self):
        contract = self.current_contract
        return contract.resident if contract else None

