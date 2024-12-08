from django.urls import path

from modules import views

urlpatterns = [
    path('',views.read_modules, name='read_modules'),
    path('', views.create_esg_views, name='create_esg_views')
]