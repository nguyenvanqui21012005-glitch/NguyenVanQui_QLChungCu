from django.urls import path

from . import views


urlpatterns = [
    path("maintenance/", views.maintenance_list, name="maintenance_list"),
    path("maintenance/create/", views.maintenance_create, name="maintenance_create"),
    path("maintenance/<int:pk>/", views.maintenance_detail, name="maintenance_detail"),
    path("maintenance/<int:pk>/assign/", views.maintenance_assign, name="maintenance_assign"),
    path("maintenance/<int:pk>/close/", views.maintenance_close, name="maintenance_close"),
    path("maintenance/stats/", views.maintenance_stats, name="maintenance_stats"),
    path("maintenance/my-tasks/", views.maintenance_my_tasks, name="maintenance_my_tasks"),
    path("maintenance/<int:pk>/update-status/", views.maintenance_update_status, name="maintenance_update_status"),
]

