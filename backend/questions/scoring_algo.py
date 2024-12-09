from modules.models import Answers, ModulesESG
from questions.models import Choices, Challenges, SubChallenges, Questions


def calculate_esg_scores(module_esg):
  try:
    # Initialize data structures
    theme_scores_today = {
      "Environnement": 0.0,
      "Social": 0.0,
      "Gouvernance": 0.0
    }
    theme_scores_in_two_years = {
      "Environnement": 0.0,
      "Social": 0.0,
      "Gouvernance": 0.0
    }
    sub_challenge_scores_today = {
      "Environnement": {},
      "Social": {},
      "Gouvernance": {}
    }
    sub_challenge_scores_in_two_years = {
      "Environnement": {},
      "Social": {},
      "Gouvernance": {}
    }

    # Process all original answers
    for answer_id in module_esg.original_answers:
      try:
        # Fetch associated question, sub-challenge, and challenge, theme and answer
        answer = Answers.get_by_id(answer_id)
        question = Questions.get_by_id(answer.id_question)
        sub_challenge = SubChallenges.get_by_id(answer.id_sub_challenge)
        challenge = Challenges.get_by_id(answer.id_challenge)
        theme = Challenges.get_theme_from_color(challenge.color)

        # Fetch associated choices
        choices = [Choices.get_by_id(choice_id) for choice_id in question.choices]

        # Calculate max score for the question
        max_score_today = sum(choice.score for choice in choices) / 2 if choices else 0.0

        # Calculate actual score for the question
        actual_score_today = 0.0
        actual_score_in_two_years = 0.0

        if answer.is_commitment:
          selected_choice = next(
              (choice for choice in choices if choice.id == answer.id_choice), None)
          if selected_choice:
            actual_score_in_two_years = selected_choice.score * 0.25
        else:
          # Engagement for today
          selected_choice = next(
              (choice for choice in choices if choice.id == answer.id_choice),
              None)
          if selected_choice:
            actual_score_today = selected_choice.score

        # Update sub_challenge scores for both timeframes
        # Sub-challenges: Today's scores
        if sub_challenge.id not in sub_challenge_scores_today[theme]:
          sub_challenge_scores_today[theme][sub_challenge.id] = {
            "name": sub_challenge.value,
            "actual_score": 0.0,
            "max_score": 0.0
          }
        sub_challenge_scores_today[theme][sub_challenge.id]["actual_score"] += actual_score_today
        sub_challenge_scores_today[theme][sub_challenge.id]["max_score"] += max_score_today

        # Sub-challenges: Two-year scores
        if sub_challenge.id not in sub_challenge_scores_in_two_years[theme]:
          sub_challenge_scores_in_two_years[theme][sub_challenge.id] = {
            "name": sub_challenge.value,
            "actual_score": 0.0,
            "max_score": 0.0
          }
        sub_challenge_scores_in_two_years[theme][sub_challenge.id]["actual_score"] += actual_score_in_two_years
        sub_challenge_scores_in_two_years[theme][sub_challenge.id]["max_score"] += max_score_today
      except Exception as e:
        print(f"Error processing answer {answer_id}: {e}")

    # Aggregate scores for each theme
    for theme in sub_challenge_scores_today:
      # Calculate today's score
      theme_actual_today = sum(
          sc["actual_score"] for sc in
          sub_challenge_scores_today[theme].values())
      theme_max_today = sum(
          sc["max_score"] for sc in
          sub_challenge_scores_today[theme].values())
      theme_scores_today[theme] = (
            theme_actual_today / theme_max_today * 100) if theme_max_today > 0 else 0.0

      # Calculate two-year engagement score
      theme_actual_2yrs = sum(
          sc["actual_score"] for sc in
          sub_challenge_scores_in_two_years[theme].values())
      theme_max_2yrs = sum(
          sc["max_score"] for sc in
          sub_challenge_scores_in_two_years[theme].values())
      theme_scores_in_two_years[theme] = (
            theme_actual_2yrs / theme_max_2yrs * 100) if theme_max_2yrs > 0 else 0.0

    # Combine scores
    total_esg_score = sum(theme_scores_today.values()) / len(
        theme_scores_today) if theme_scores_today else 0.0

    # Prepare response
    result = {
      "themes": [],
      "total_esg_score": total_esg_score,
      "theme_scores_in_two_years": theme_scores_in_two_years
    }

    for theme, score in theme_scores_today.items():
      result["themes"].append({
        "name": theme,
        "score_today": score,
        "score_in_two_years": theme_scores_in_two_years[theme]
      })

    return result

  except Exception as e:
    return {"error": f"Error calculating ESG score: {e}"}




