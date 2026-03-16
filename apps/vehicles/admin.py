from django.contrib import admin

from .models import ParkingSlot, Vehicle


@admin.register(ParkingSlot)
class ParkingSlotAdmin(admin.ModelAdmin):
    list_display = ("slot_number", "slot_type", "status", "monthly_fee")
    list_filter = ("slot_type", "status")
    search_fields = ("slot_number",)


@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ("license_plate", "vehicle_type", "resident", "apartment", "parking_slot")
    list_filter = ("vehicle_type",)
    search_fields = ("license_plate", "resident__full_name")

