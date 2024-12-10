from typing import Dict, Any, Tuple
from modules.models import Answers
from questions.models import Choices, Challenges, SubChallenges, Questions

# Helper function to convert dictionary keys to strings
def stringify_keys(data):
  """
  Recursively convert all dictionary keys to strings.
  """
  if isinstance(data, dict):
    return {str(key): stringify_keys(value) for key, value in data.items()}
  elif isinstance(data, list):
    return [stringify_keys(item) for item in data]
  return data

# Step 1: Calculate scores for a single question
def calculate_question_score(answer, question, choices) -> Dict[str, float]:
    try:
        # Initialize scores
        score_today = 0.0
        score_in_two_years = 0.0
        score_max = 0.0

        if question.type_response == "%":
            # Use the highest percentage value as the max score
            max_percentage_value = max(choice.value for choice in choices if choice.value is not None)
            score_max = max_percentage_value / 2.0  # Divide by 2 as per instruction
        else:
            # Default max score logic
            score_max = sum(choice.score for choice in choices) / 2 if choices else 0.0

        # Calculate the actual score
        selected_choice = next((choice for choice in choices if choice.id == answer.id_choice), None)
        if selected_choice:
            if answer.is_commitment:
                score_in_two_years = selected_choice.score * 0.25
            else:
                score_today = selected_choice.score

        return {
            "score_today": score_today,
            "score_in_two_years": score_in_two_years,
            "score_max": score_max,
        }
    except Exception as e:
        raise ValueError(f"Error calculating question score: {e}")


# Step 2: Aggregate scores for sub-challenges
def calculate_sub_challenge_scores(module_esg) -> Dict[str, Dict[str, Any]]:
    sub_challenge_scores = {
        "today": {},
        "in_two_years": {},
    }
    # Récupérer toutes les réponses originales et modifiées pour le pacte d'engagement
    original_answers = Answers.objects.filter(id__in=module_esg.original_answers)
    modified_answers = Answers.objects.filter(id__in=module_esg.modified_answers)

    # Créer un dictionnaire basé sur id_question pour permettre un écrasement des réponses originales
    answers_dict = {answer.id_question: answer for answer in original_answers}

    # Remplacer ou ajouter les réponses modifiées
    for answer in modified_answers:
      answers_dict[answer.id_question] = answer

    # Obtenir la liste des réponses finales
    answers_to_commitment = [answer.id for answer in answers_dict.values()]

    for answer_id in answers_to_commitment:
        try:
            # Retrieve associated data
            answer = Answers.get_by_id(answer_id)
            question = Questions.get_by_id(answer.id_question)
            sub_challenge = SubChallenges.get_by_id(answer.id_sub_challenge)
            choices = [Choices.get_by_id(choice_id) for choice_id in question.choices]

            # Calculate scores for the question
            question_scores = calculate_question_score(answer, question, choices)

            # Aggregate scores for the sub-challenge
            if sub_challenge.id not in sub_challenge_scores["today"]:
                sub_challenge_scores["today"][sub_challenge.id] = {
                    "name": sub_challenge.value,
                    "score": 0.0,
                    "score_max": 0.0,
                }
                sub_challenge_scores["in_two_years"][sub_challenge.id] = {
                    "name": sub_challenge.value,
                    "score": 0.0,
                    "score_max": 0.0,
                }

            sub_challenge_scores["today"][sub_challenge.id]["score"] += question_scores["score_today"]
            sub_challenge_scores["today"][sub_challenge.id]["score_max"] += question_scores["score_max"]
            sub_challenge_scores["in_two_years"][sub_challenge.id]["score"] += question_scores["score_in_two_years"]
            sub_challenge_scores["in_two_years"][sub_challenge.id]["score_max"] += question_scores["score_max"]
        except Exception as e:
            print(f"Error processing answer {answer_id}: {e}")

    return sub_challenge_scores


def calculate_challenge_scores(module_esg) -> tuple[
  dict[str, dict[str, Any]], dict[str, dict[Any, Any]]]:
  challenge_scores = {"today": {}, "in_two_years": {}}
  sub_challenge_scores = calculate_sub_challenge_scores(module_esg)

  for sub_challenge_id, scores in sub_challenge_scores["today"].items():
    try:
      # Retrieve the parent challenge for the sub-challenge
      parent_challenge = Challenges.objects.filter(
        sub_challenges__contains=sub_challenge_id).first()
      if not parent_challenge:
        print(
          f"No parent challenge found for sub-challenge ID: {sub_challenge_id}")
        continue

      challenge_id = parent_challenge.id
      if challenge_id not in challenge_scores["today"]:
        challenge_scores["today"][challenge_id] = {
          "name": parent_challenge.value,
          "score": 0.0,
          "score_max": 0.0,
        }
        challenge_scores["in_two_years"][challenge_id] = {
          "name": parent_challenge.value,
          "score": 0.0,
          "score_max": 0.0,
        }

      # Add sub-challenge scores to the corresponding challenge
      challenge_scores["today"][challenge_id]["score"] += scores["score"]
      challenge_scores["today"][challenge_id]["score_max"] += scores[
        "score_max"]
      challenge_scores["in_two_years"][challenge_id]["score"] += \
      sub_challenge_scores["in_two_years"][sub_challenge_id]["score"]
      challenge_scores["in_two_years"][challenge_id]["score_max"] += \
      sub_challenge_scores["in_two_years"][sub_challenge_id]["score_max"]

    except Exception as e:
      print(f"Error processing sub-challenge {sub_challenge_id}: {e}")

  return sub_challenge_scores, challenge_scores


def calculate_theme_scores(module_esg) -> tuple[
  dict[str, dict[str, Any]], dict[str, dict[Any, Any]], dict[
    str, dict[Any, Any]]]:
  theme_scores = {"today": {}, "in_two_years": {}}
  sub_challenge_scores, challenge_scores = calculate_challenge_scores(module_esg)

  for challenge_id, scores in challenge_scores["today"].items():
    try:
      # Retrieve the theme for the challenge based on its color
      challenge = Challenges.get_by_id(challenge_id)
      theme = Challenges.get_theme_from_color(challenge.color)

      if theme not in theme_scores["today"]:
        theme_scores["today"][theme] = {"name": "", "score": 0.0, "score_max": 0.0}
        theme_scores["in_two_years"][theme] = {"name": "", "score": 0.0, "score_max": 0.0}

      # Add challenge scores to the theme
      theme_scores["today"][theme]["score"] += scores["score"]
      theme_scores["today"][theme]["score_max"] += scores["score_max"]
      theme_scores["in_two_years"][theme]["score"] += challenge_scores["in_two_years"][challenge_id]["score"]
      theme_scores["in_two_years"][theme]["score_max"] += challenge_scores["in_two_years"][challenge_id]["score_max"]

    except Exception as e:
      print(f"Error processing challenge {challenge_id}: {e}")

  # Calculate percentage scores for each theme
  for theme, scores in theme_scores["today"].items():
    today_max = scores["score_max"]
    theme_scores["today"][theme]["total30"] = (scores["score"] / today_max * 30) if today_max > 0 else 0.0
    theme_scores["today"][theme]["name"] = theme


  for theme, scores in theme_scores["in_two_years"].items():
    in_two_years_max = scores["score_max"]
    theme_scores["in_two_years"][theme]["total30"] = (scores["score"] / in_two_years_max * 30) if in_two_years_max > 0 else 0.0
    theme_scores["in_two_years"][theme]["name"] = theme

  return sub_challenge_scores, challenge_scores, theme_scores



# Step 4: Calculate global ESG scores
def calculate_global_esg_scores(module_esg) -> Dict[str, float]:
  sub_challenge_scores, challenge_scores, theme_scores = calculate_theme_scores(module_esg)
  try:
    # Calculate the total ESG score for today
    total_score_today = sum(theme["total30"] for theme in theme_scores["today"].values()) if theme_scores["today"] else 0.0
    # Calculate the total ESG score for in two years
    total_score_in_two_years = sum(theme["total30"] for theme in theme_scores["in_two_years"].values()) if theme_scores["in_two_years"] else 0.0

    # Average scores for global ESG calculation
    total_esg_score_today = total_score_today / 90 * 100
    total_esg_score_in_two_years = total_score_in_two_years / 90 * 100

    # Sum of global scores
    total_esg_score = total_esg_score_today + total_esg_score_in_two_years

    combined_scores = stringify_keys( {
      "sub_challenge_scores": sub_challenge_scores,
      "challenge_scores": challenge_scores,
      "theme_scores": theme_scores,
      "total_esg_score_today": total_esg_score_today,
      "total_esg_score_in_two_years": total_esg_score_in_two_years,
      "total_esg_score": total_esg_score,
    })

    return combined_scores
  except Exception as e:
    raise ValueError(f"Error calculating global ESG scores: {e}")