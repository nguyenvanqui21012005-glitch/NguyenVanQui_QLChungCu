from django.contrib import admin

from .models import Contract, Resident


@admin.register(Resident)
class ResidentAdmin(admin.ModelAdmin):
    list_display = ("full_name", "id_number", "phone")
    search_fields = ("full_name", "id_number", "phone")


@admin.register(Contract)
class ContractAdmin(admin.ModelAdmin):
    list_display = ("resident", "apartment", "start_date", "end_date", "status")
    list_filter = ("status",)
    search_fields = ("resident__full_name", "apartment__apartment_number")

