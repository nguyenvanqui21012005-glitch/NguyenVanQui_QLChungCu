from django.urls import path

from . import views


urlpatterns = [
    path("login/", views.login_view, name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("dashboard/", views.dashboard_view, name="dashboard"),
    path("profile/", views.profile_view, name="profile"),
    path("profile/edit/", views.profile_edit_view, name="profile_edit"),
    path("profile/change-password/", views.change_password_view, name="change_password"),
    path("profile/avatar/", views.update_avatar_view, name="update_avatar"),
    path("staff/", views.staff_list_view, name="staff_list"),
    path("staff/create/", views.staff_create_view, name="staff_create"),
    path("staff/<int:pk>/edit/", views.staff_edit_view, name="staff_edit"),
    path("staff/<int:pk>/toggle-active/", views.staff_toggle_active, name="staff_toggle_active"),
    path("staff/<int:pk>/reset-password/", views.staff_reset_password, name="staff_reset_password"),
    path("staff/<int:pk>/delete/", views.staff_delete_view, name="staff_delete"),
]

