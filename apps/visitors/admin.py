from django.contrib import admin

from .models import Visitor


@admin.register(Visitor)
class VisitorAdmin(admin.ModelAdmin):
    list_display = ("full_name", "visit_apartment", "check_in", "check_out", "registered_by")
    search_fields = ("full_name", "id_number", "phone")

