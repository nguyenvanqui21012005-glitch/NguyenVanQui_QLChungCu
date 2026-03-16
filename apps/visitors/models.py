from django.db import models

from apps.accounts.models import User
from apps.buildings.models import Apartment
from apps.residents.models import Resident


class Visitor(models.Model):
    full_name = models.CharField(max_length=200, verbose_name="Họ tên khách")
    id_number = models.CharField(max_length=20, blank=True, null=True, verbose_name="Số CCCD")
    phone = models.CharField(max_length=15, blank=True, null=True)
    visit_apartment = models.ForeignKey(Apartment, on_delete=models.CASCADE, related_name="visitors")
    resident = models.ForeignKey(
        Resident, on_delete=models.SET_NULL, null=True, blank=True, related_name="visitors"
    )
    purpose = models.CharField(max_length=300, verbose_name="Mục đích thăm")
    check_in = models.DateTimeField(auto_now_add=True)
    check_out = models.DateTimeField(null=True, blank=True)
    registered_by = models.ForeignKey(
        User, on_delete=models.SET_NULL, null=True, related_name="registered_visitors"
    )
    note = models.TextField(blank=True, null=True)

    class Meta:
        db_table = "visitors_visitor"
        verbose_name = "Khách thăm"
        ordering = ["-check_in"]

    def __str__(self):
        return f"{self.full_name} → {self.visit_apartment}"

