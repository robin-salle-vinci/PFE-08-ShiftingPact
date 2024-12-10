from django.urls import path

from modules import views

urlpatterns = [
    # Get all ESG modules
    path('',views.read_modules, name='read_modules'),

    # Get one ESG module for 
    path('esg/<str:uuid_module_esg>', views.read_module_by_esg_id, name='read_module_by_esg_id'),

    # Get one ESG module by client id most recent
    path('client/<str:uuid_client>', views.read_module_by_client_id, name='read_module_by_client_id'),

    # Create ESG module
    path('create/<str:uuid_client>', views.create_esg_views, name='create_esg_views'),

    # Update ESG module
    path('state/<str:uuid_module_esg>', views.change_state_esg, name='change_state_esg_view'),

    # Add answer to the modified list of answers
    path('add/answer', views.add_modified_answers, name='add_modified_answer'),

    # Add answer  to the original list of answers
    path('add/answer/<str:uuid_module_esg>', views.add_original_answers, name='add_original_answer'),

    # Add score to module
    path('add/score/<str:uuid_module_esg>', views.add_score, name='add_score'),

    # Get all info about score of module
    path('score/<str:uuid_module_esg>', views.get_score, name='get_score'),
]