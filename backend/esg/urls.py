# users/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.create_esg_views, name='create_esg_views')
]
