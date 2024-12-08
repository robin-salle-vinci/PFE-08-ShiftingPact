# users/urls.py
from django.urls import path
from . import views

urlpatterns = [
    #path('', views.create_esg, name='create_esg_view')
    path('state/<str:uuid_module_esg>', views.change_state_esg, name='change_state_esg_view')
]
