from questions.models import Challenges, SubChallenges, Questions, Choices
from modules.models import Answers
from users.models import ClientInformation



def client_info_json(client_info):
  return \
    {
      'id_user': str(client_info.id_user),
      'number_workers': int(client_info.number_workers),
      'owned_facility': str(client_info.owned_facility),
      'service_or_product': str(client_info.service_or_product),
      'company_name': str(client_info.company_name),
    }

def choice_json(choice):
  return \
    {
      'id': str(choice.id),
      'index_choice': int(choice.index_choice),
      'value': str(choice.value),
      'score': float(choice.score if choice.score else 0),
    }

def question_json(question):
  return \
    {
      'id': str(question.id),
      'index_question': int(question.index_question),
      'value': str(question.value),
      'type_response': str(question.type_response),
      'choices':
        [
          choice_json(choice)
          for choice in (Choices.get_by_id(id_choice) for id_choice in question.choices)
        ]
    }

def sub_challenge_json(sub_challenge):
  return \
    {
      'id': str(sub_challenge.id),
      'index_sub_challenge': int(sub_challenge.index_sub_challenge),
      'value': str(sub_challenge.value),
      'questions':
        [
          question_json(question)
          for question in (Questions.get_by_id(id_question) for id_question in sub_challenge.questions)
        ],
    }

def challenge_json(challenge):
  return \
    {
      'id': str(challenge.id),
      'index_challenge': int(challenge.index_challenge),
      'value': str(challenge.value),
      'color': str(challenge.color),
      'sub_challenges':
        [
          sub_challenge_json(sub_challenge)
          for sub_challenge in (SubChallenges.get_by_id(id_sub_challenge) for id_sub_challenge in challenge.sub_challenges)
        ],
    }

def answer_json(answer):
  return \
    {
      'id': str(answer.id),
      'challenge': challenge_json(Challenges.get_by_id(answer.id_challenge)),
      'sub_challenge': sub_challenge_json(SubChallenges.get_by_id(answer.id_sub_challenge)),
      'question': question_json(Questions.get_by_id(answer.id_question)),
      'value': str(answer.value),
      'commentary': str(answer.commentary),
      'is_commitment': bool(answer.is_commitment),
      'score_response': float(answer.score_response if answer.score_response else 0),
    }

def module_json(module):
  return \
    {
      'id': str(module.id),
      'client_information': client_info_json(ClientInformation.get_by_id(module.id_client)),
      'date_last_modification': module.date_last_modification.isoformat(),
      'original_answers':
        [
          answer_json(answer)
          for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.original_answers)
        ],
      'modified_answers':
        [
          answer_json(answer)
          for answer in (Answers.get_by_id(idAnswer) for idAnswer in module.modified_answers)
        ],
      'state': module.state,
      'calculated_score': module.calculated_score
    }

def module_single_json(module):
  return \
    {
      'id': str(module.id),
      'client_information': client_info_json(ClientInformation.get_by_id(module.id_client)),
      'date_last_modification': module.date_last_modification.isoformat(),
      'original_answers': [
          str(idAnswer)
          for idAnswer in module.original_answers
        ],
      'modified_answers': [
        str(idAnswer)
        for idAnswer in module.modified_answers
      ],
      'state': str(module.state),
      'calculated_score': float(module.calculated_score)
    }