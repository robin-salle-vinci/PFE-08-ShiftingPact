from uuid import uuid4
from django.test import TestCase, Client
from unittest.mock import patch
from django.urls import reverse

from modules.models import Answers
from users.models import Users


class ModulesViewTests(TestCase):
    def setUp(self):
        self.client = Client()
        self.url = reverse('read_modules')

        self.user = Users(
            id=uuid4(),
            username='testuser',
            password='testpassword',
            role='employee'
        )

        self.answers = Answers(
            id=uuid4(),
            id_challenge = uuid4(),
            id_sub_challenge = uuid4(),
            id_question = uuid4(),
            id_choice = uuid4(),  # Optional, only for QCM type questions
            value = 'test',
            commentary = 'test',
            is_commitment = False,  # Boolean pour savoir si engagement ou pas
            score_response = 85
        )

    def mock_decode_function(self, token):
        return {'id': str(self.user.id), 'role': self.user.role}

    @patch('modules.views.module_json')
    @patch('modules.views.decode_token')
    @patch('users.models.Users.get_by_id')
    @patch('questions.models.Answers.get_by_id')
    @patch('modules.models.ModuleESG.get_all')
    def test_successful_get_modules(self, mock_get_all, mock_answers_get, mock_users_get, mock_decode, mock_module_json):
        mock_users_get.return_value = self.user
        mock_decode.side_effect = self.mock_decode_function
        mock_module_json.return_value = {}
        mock_answers_get.return_value = self.answers
        mock_get_all.return_value = []

        response = self.client.get(self.url, **{'HTTP_AUTHORIZATION': 'Bearer valid_token'})

        self.assertEqual(response.status_code, 200)


    @patch('modules.views.decode_token')
    def test_invalid_token(self, mock_decode):
        mock_decode.side_effect = lambda token: (_ for _ in ()).throw(Exception("Invalid token"))

        response = self.client.get(self.url, {'state': 'open'}, **{'HTTP_AUTHORIZATION': 'Bearer invalid_token'})

        self.assertEqual(response.status_code, 401)
        self.assertJSONEqual(response.content.decode("utf-8"), {'error': 'Invalid token'})

    @patch('modules.views.decode_token')
    def test_missing_token(self, mock_decode):
        mock_decode.side_effect = lambda token: (_ for _ in ()).throw(Exception("Token is missing"))

        response = self.client.get(self.url, {'state': 'open'})

        self.assertEqual(response.status_code, 400)
        self.assertJSONEqual(response.content.decode("utf-8"), {'error': 'Invalid Authorization header'})