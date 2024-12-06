# test_views.py
from django.test import TestCase, Client
from django.urls import reverse
from .models import Users, ClientInformation
import json


class UserViewsTestCase(TestCase):
    def setUp(self):
        self.client = Client()
        self.register_url = reverse('register_view')
        self.login_url = reverse('login_view')

    def test_register_view(self):
        data = {
            'companyName': 'Test Company',
            'numberWorkers': 10,
            'facilityOwner': 'Test Facility',
            'isService': True
        }
        response = self.client.post(self.register_url, json.dumps(data), content_type='application/json')
        self.assertEqual(response.status_code, 201)
        self.assertIn('User created successfully', response.json()['message'])

        print(f'response: {response.json()}')

    def test_login_view(self):
        # First, register a user
        register_data = {
            'companyName': 'Test Company',
            'numberWorkers': 10,
            'facilityOwner': 'Test Facility',
            'isService': True
        }
        self.client.post(self.register_url, json.dumps(register_data), content_type='application/json')

        # Retrieve the created user to get the password
        user = Users.objects.first()
        password = str(user.id)

        # Now, test login with the registered user
        login_data = {
            'username': 'testcompany',
            'password': password
        }
        response = self.client.post(self.login_url, json.dumps(login_data), content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertIn('Authentication successful', response.json()['message'])

        print(f'response: {response.json()}')

        # Access the user and client information after login
        user = Users.objects.first()
        client_info = ClientInformation.objects.get(id=user.id_client_information)
        print(f'User in database: '
              f'Username: {user.username}, '
              f'User Role: {user.role}, '
              f'Client Info - numberWorkers : {client_info.numberWorkers}, '
              f'Client Info - ownedFacility : {client_info.ownedFacility}, '
              f'Client Info - serviceOrProduct : {client_info.serviceOrProduct}')
