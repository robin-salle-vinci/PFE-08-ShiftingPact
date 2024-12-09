from django.urls import path

from modules import views

urlpatterns = [
    # Get all ESG modules
    path('',views.read_modules, name='read_modules'),

    # Get one ESG module for 
    path('esg/<str:uuid_module_esg>', views.read_module_by_esg_id, name='read_module_by_esg_id'),
    path('client/<str:uuid_client>', views.read_module_by_client_id, name='read_module_by_client_id'),

    # Create ESG module
    path('create/<str:uuid_client>', views.create_esg_views, name='create_esg_views'),

    # Update ESG module
    path('state/<str:uuid_module_esg>', views.change_state_esg, name='change_state_esg_view'),

    # Update ESG module by adding answer in original answer
    path('answer/<str:uuid_module_esg>', views.add_in_original_answers, name='views.add_in_original_answers'),

    # Answer to a question
    path('answer', views.answer_question, name='answer_question'),
]