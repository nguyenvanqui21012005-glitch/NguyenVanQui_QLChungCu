from django.urls import path

from . import views


urlpatterns = [
    path("fee-types/", views.fee_type_list, name="fee_type_list"),
    path("fee-types/create/", views.fee_type_create, name="fee_type_create"),
    path("fee-types/<int:pk>/edit/", views.fee_type_edit, name="fee_type_edit"),
    path("invoices/", views.invoice_list, name="invoice_list"),
    path("invoices/create/", views.invoice_create, name="invoice_create"),
    path("invoices/bulk-create/", views.invoice_bulk_create, name="invoice_bulk_create"),
    path("invoices/<int:pk>/", views.invoice_detail, name="invoice_detail"),
    path("invoices/<int:pk>/cancel/", views.invoice_cancel, name="invoice_cancel"),
    path("invoices/<int:pk>/pay/", views.invoice_pay, name="invoice_pay"),
    path("payments/", views.payment_list, name="payment_list"),
]

