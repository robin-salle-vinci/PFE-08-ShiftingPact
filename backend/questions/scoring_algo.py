import json
from typing import Dict, Any
from modules.models import Answers
from questions.models import Choices, Challenges, SubChallenges, Questions


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
    # print(module_esg.original_answers)
    # print(module_esg.modified_answers)
    # # If there are modified answers, map them to the original ones
    # if module_esg.modified_answers:
    #   # Replace IDs with their modified versions if a match is found
    #   answer_id_list = [
    #     modified_id if modified_id in [ans for ans in
    #                                    module_esg.modified_answers]
    #     else original_id
    #     for original_id, modified_id in
    #     zip(module_esg.original_answers, module_esg.modified_answers)
    #   ]
    # else:
    #   answer_id_list = module_esg.original_answers
    # print(answer_id_list)

    for answer_id in module_esg.original_answers:
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


def calculate_challenge_scores(sub_challenge_scores) -> Dict[str, Dict[str, float]]:
  challenge_scores = {"today": {}, "in_two_years": {}}

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

  return challenge_scores


def calculate_theme_scores(challenge_scores) -> Dict[str, Dict[str, float]]:
  theme_scores = {"today": {}, "in_two_years": {}}

  for challenge_id, scores in challenge_scores["today"].items():
    try:
      # Retrieve the theme for the challenge based on its color
      challenge = Challenges.get_by_id(challenge_id)
      theme = Challenges.get_theme_from_color(challenge.color)

      if theme not in theme_scores["today"]:
        theme_scores["today"][theme] = {"score": 0.0, "score_max": 0.0}
        theme_scores["in_two_years"][theme] = {"score": 0.0, "score_max": 0.0}

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
    theme_scores["today"][theme]["percentage"] = (
        scores["score"] / today_max * 100) if today_max > 0 else 0.0

  for theme, scores in theme_scores["in_two_years"].items():
    in_two_years_max = scores["score_max"]
    theme_scores["in_two_years"][theme]["percentage"] = (scores[
                                                           "score"] / in_two_years_max * 100) if in_two_years_max > 0 else 0.0

  return theme_scores


# Step 4: Calculate global ESG scores
def calculate_global_esg_scores(theme_scores) -> Dict[str, float]:
  try:
    # Calculate the total ESG score for today
    total_score_today = sum(theme["percentage"] for theme in theme_scores["today"].values()) if theme_scores["today"] else 0.0
    # Calculate the total ESG score for in two years
    total_score_in_two_years = sum(theme["percentage"] for theme in theme_scores["in_two_years"].values()) if theme_scores["in_two_years"] else 0.0

    # Average scores for global ESG calculation
    total_esg_score_today = total_score_today / len(theme_scores["today"]) if theme_scores["today"] else 0.0
    total_esg_score_in_two_years = total_score_in_two_years / len(theme_scores["in_two_years"]) if theme_scores["in_two_years"] else 0.0

    # Sum of global scores
    total_esg_score = total_esg_score_today + total_esg_score_in_two_years

    return {
      "total_esg_score_today": total_esg_score_today,
      "total_esg_score_in_two_years": total_esg_score_in_two_years,
      "total_esg_score": total_esg_score,
    }
  except Exception as e:
    raise ValueError(f"Error calculating global ESG scores: {e}")