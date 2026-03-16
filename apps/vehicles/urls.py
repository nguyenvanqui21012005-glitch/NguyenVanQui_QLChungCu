from django.urls import path

from . import views


urlpatterns = [
    path("vehicles/", views.vehicle_list, name="vehicle_list"),
    path("vehicles/create/", views.vehicle_create, name="vehicle_create"),
    path("vehicles/<int:pk>/edit/", views.vehicle_edit, name="vehicle_edit"),
    path("vehicles/<int:pk>/delete/", views.vehicle_delete, name="vehicle_delete"),
    path("parking-slots/", views.parking_slot_list, name="parking_slot_list"),
    path("parking-slots/create/", views.parking_slot_create, name="parking_slot_create"),
    path("parking-slots/<int:pk>/assign/", views.parking_slot_assign, name="parking_slot_assign"),
]

