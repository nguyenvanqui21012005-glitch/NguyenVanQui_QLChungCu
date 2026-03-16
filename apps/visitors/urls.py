from django.urls import path

from . import views


urlpatterns = [
    path("visitors/", views.visitor_list, name="visitor_list"),
    path("visitors/create/", views.visitor_create, name="visitor_create"),
    path("visitors/<int:pk>/checkout/", views.visitor_checkout, name="visitor_checkout"),
    path("visitors/today/", views.visitor_today, name="visitor_today"),
]

