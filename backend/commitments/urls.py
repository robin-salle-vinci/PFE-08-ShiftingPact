# users/urls.py
from os import name
from unittest.mock import patch
from django.urls import path
from . import views

urlpatterns = [
    path('all/<str:id_client>', views.get_all_client, name='get_all_client'),
    path('<str:id_commitment>', views.get_one, name='get_one')
]
