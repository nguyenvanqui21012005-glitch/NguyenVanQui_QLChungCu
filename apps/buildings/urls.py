from django.urls import path

from . import views


urlpatterns = [
    path("buildings/", views.building_list, name="building_list"),
    path("buildings/create/", views.building_create, name="building_create"),
    path("buildings/<int:pk>/", views.building_detail, name="building_detail"),
    path("buildings/<int:pk>/edit/", views.building_edit, name="building_edit"),
    path("buildings/<int:pk>/delete/", views.building_delete, name="building_delete"),
    path("buildings/<int:pk>/floors/", views.floor_manage, name="floor_manage"),
    path("apartments/", views.apartment_list, name="apartment_list"),
    path("apartments/create/", views.apartment_create, name="apartment_create"),
    path("apartments/<int:pk>/edit/", views.apartment_edit, name="apartment_edit"),
    path("apartments/<int:pk>/delete/", views.apartment_delete, name="apartment_delete"),
    path("apartments/<int:pk>/status/", views.apartment_status, name="apartment_status"),
]

