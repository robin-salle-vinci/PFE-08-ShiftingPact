from django.urls import path

from modules import views

urlpatterns = [
    path('',views.read_modules, name='read_modules'),
]