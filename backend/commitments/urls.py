# users/urls.py
from django.urls import path

from . import views

urlpatterns = [
    path('<str:id_commitment>', views.get_one, name='get_one'),
    path('module/<str:id_module_esg>', views.get_one_by_module_id, name='get_one_by_module_id'),
    path('client/', views.get_all_for_client, name='get_all_for_client'),
]
