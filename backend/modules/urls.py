from django.urls import path

from modules import views

urlpatterns = [
    path('',views.read_modules, name='read_modules'),
    path('', views.create_esg_views, name='create_esg_views'),
    path('state/<str:uuid_module_esg>/', views.change_state_esg, name='change_state_esg_view')
]