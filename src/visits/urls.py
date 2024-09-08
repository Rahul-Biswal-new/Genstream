from django.urls import path
from . import views

urlpatterns = [
    path('', views.visit_home, name='visit_home'),
]