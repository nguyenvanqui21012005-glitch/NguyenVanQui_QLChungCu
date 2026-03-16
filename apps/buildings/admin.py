from django.contrib import admin

from .models import Apartment, Building, Floor


@admin.register(Building)
class BuildingAdmin(admin.ModelAdmin):
    list_display = ("name", "address", "total_floors")
    search_fields = ("name", "address")


@admin.register(Floor)
class FloorAdmin(admin.ModelAdmin):
    list_display = ("building", "floor_number", "name")
    list_filter = ("building",)


@admin.register(Apartment)
class ApartmentAdmin(admin.ModelAdmin):
    list_display = ("apartment_number", "floor", "area", "status", "rent_price")
    list_filter = ("status", "floor__building")
    search_fields = ("apartment_number", "floor__building__name")

