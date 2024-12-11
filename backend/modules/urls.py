from django.urls import path

from modules import views

urlpatterns = [
    # Get all ESG modules
    path('', views.read_all, name='read_all_esg_modules'),

    # Get one ESG module by id
    path('<str:uuid_esg_module>', views.read_one_by_id, name='read_one_module_by_id'),

    # Get one ESG module (last client module)
    path('esg/', views.read_last_module_for_client, name='read_last_module_for_client'),

    # Create ESG module
    path('create/', views.create_one, name='create_one'),

    # Update ESG module
    path('state/<str:uuid_module_esg>', views.change_state, name='change_state'),

    # Add answer to the modified list of answers
    path('add/answer/', views.add_modified_answers, name='add_modified_answers'),

    # Add answer  to the original list of answers
    path('add/answer/<str:uuid_module_esg>', views.add_original_answers, name='add_original_answers'),

    # Add score to module
    path('addScore/<str:uuid_module_esg>', views.add_score, name='add_score')
]
