from django.urls import path

from . import views


urlpatterns = [
    path("reports/finance/", views.report_finance, name="report_finance"),
    path("reports/debt/", views.report_debt, name="report_debt"),
    path("reports/occupancy/", views.report_occupancy, name="report_occupancy"),
    path("reports/maintenance/", views.report_maintenance, name="report_maintenance"),
    path("reports/export/", views.report_export, name="report_export"),
]

