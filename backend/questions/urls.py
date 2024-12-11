# users/urls.py
from django.urls import path

from . import views

urlpatterns = [
    path('', views.get_all_questions_views, name='questions_view'),
    path("only/", views.get_all_only_questions_views, name="get_all_only_questions")
]
