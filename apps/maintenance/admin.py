from django.contrib import admin

from .models import MaintenanceRequest


@admin.register(MaintenanceRequest)
class MaintenanceRequestAdmin(admin.ModelAdmin):
    list_display = ("title", "apartment", "priority", "status", "assigned_to", "created_at")
    list_filter = ("priority", "status")
    search_fields = ("title", "apartment__apartment_number")

