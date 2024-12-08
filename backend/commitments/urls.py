# users/urls.py
from django.urls import path
from . import views

urlpatterns = [
    path('<str:id>', views.get_one, name='questions_view')
]
