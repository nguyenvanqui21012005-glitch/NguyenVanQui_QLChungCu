from django.urls import path

from . import views


urlpatterns = [
    path("residents/", views.resident_list, name="resident_list"),
    path("residents/create/", views.resident_create, name="resident_create"),
    path("residents/<int:pk>/edit/", views.resident_edit, name="resident_edit"),
    path("residents/<int:pk>/delete/", views.resident_delete, name="resident_delete"),
    path("residents/<int:pk>/contracts/", views.resident_contracts, name="resident_contracts"),
    path("contracts/", views.contract_list, name="contract_list"),
    path("contracts/create/", views.contract_create, name="contract_create"),
    path("contracts/<int:pk>/activate/", views.contract_activate, name="contract_activate"),
    path("contracts/<int:pk>/terminate/", views.contract_terminate, name="contract_terminate"),
]

