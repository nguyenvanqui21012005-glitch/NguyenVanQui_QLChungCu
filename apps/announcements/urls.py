from django.urls import path

from . import views


urlpatterns = [
    path("announcements/", views.announcement_list, name="announcement_list"),
    path("announcements/create/", views.announcement_create, name="announcement_create"),
    path("announcements/<int:pk>/", views.announcement_detail, name="announcement_detail"),
    path("announcements/<int:pk>/edit/", views.announcement_edit, name="announcement_edit"),
    path("announcements/<int:pk>/delete/", views.announcement_delete, name="announcement_delete"),
    path("announcements/<int:pk>/pin/", views.announcement_pin, name="announcement_pin"),
]

