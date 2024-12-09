from modules.models import Answers, ModulesESG
from questions.models import Choices, Challenges, SubChallenges, Questions


def calculate_esg_scores(module_esg):
  try:
    # Initialize data structures
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
        max_score_today = 0.0
        if question.type_response == "%":
          # Handle percentage logic: use the choice with the highest percentage value
          if choices:
            max_percentage_value = max(
                choice.value for choice in choices if choice.value is not None
            )
            max_score_today = max_percentage_value / 2.0  # Divide by 2 as per the instruction
        else:
          # Default calculation for other question types
          max_score_today = sum(
              choice.score for choice in choices) / 2 if choices else 0.0

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
            "score_today": 0.0,
            "max_score_today": 0.0
          }
        sub_challenge_scores_today[theme][sub_challenge.id]["score_today"] += actual_score_today
        sub_challenge_scores_today[theme][sub_challenge.id]["max_score_today"] += max_score_today

        # Sub-challenges: Two-year scores
        if sub_challenge.id not in sub_challenge_scores_in_two_years[theme]:
          sub_challenge_scores_in_two_years[theme][sub_challenge.id] = {
            "name": sub_challenge.value,
            "score_in_two_years": 0.0,
            "max_score_in_two_years": 0.0
          }
        sub_challenge_scores_in_two_years[theme][sub_challenge.id]["score_in_two_years"] += actual_score_in_two_years
        sub_challenge_scores_in_two_years[theme][sub_challenge.id]["max_score_in_two_years"] += max_score_today
      except Exception as e:
        print(f"Error processing answer {answer_id}: {e}")

    # Calculate scores per theme
    theme_scores_today = {}
    theme_scores_in_two_years = {}

    # Aggregate scores for each theme
    for theme in sub_challenge_scores_today:
      print(theme)
      # Calculate today's score
      total_score_today = sum(
          sc["score_today"] for sc in sub_challenge_scores_today[theme].values())
      total_max_score_today = sum(
          sc["max_score_today"] for sc in sub_challenge_scores_today[theme].values())
      theme_scores_today[theme] = (
        (
              total_score_today / total_max_score_today * 100) if total_max_score_today > 0 else 0.0
      )

      total_score_in_two_years = sum(
          sc["score_in_two_years"] for sc in
          sub_challenge_scores_in_two_years[theme].values())
      total_max_score_in_two_years = sum(
          sc["max_score_in_two_years"] for sc in
          sub_challenge_scores_in_two_years[theme].values())
      theme_scores_in_two_years[theme] = (
        (
              total_score_in_two_years / total_max_score_in_two_years * 100) if total_max_score_in_two_years > 0 else 0.0
      )

      # Calculate final global scores
      total_esg_score_today = sum(theme_scores_today.values()) / len(
          theme_scores_today) if theme_scores_today else 0.0
      total_esg_score_in_two_years = sum(
        theme_scores_in_two_years.values()) / len(
          theme_scores_in_two_years) if theme_scores_in_two_years else 0.0

      # Calculate the total_esg as the sum of today and two years
      total_esg = total_esg_score_today + total_esg_score_in_two_years

      # Final response structure
      result = {
        "themes": [],
        "total_esg_score_today": total_esg_score_today,
        "total_esg_score_in_two_years": total_esg_score_in_two_years,
        "total_esg_score": total_esg
      }

    # Map results back into themes with detailed sub-challenges
    for theme in sub_challenge_scores_today:
      result["themes"].append({
        "name": theme,
        "score_today": theme_scores_today[theme],
        "score_in_two_years": theme_scores_in_two_years[theme],
        "sub_challenges_today": [
          {
            "name": sc["name"],
            "score_today": sc["score_today"],
            "max_score_today": sc["max_score_today"]
          }
          for sc_id, sc in sub_challenge_scores_today[theme].items()
        ],
        "sub_challenges_in_two_years": [
          {
            "name": sc["name"],
            "score_in_two_years": sc["score_in_two_years"],
            "max_score_in_two_years": sc["max_score_in_two_years"]
          }
          for sc_id, sc in sub_challenge_scores_in_two_years[theme].items()
        ]
      })

    return result

  except Exception as e:
    return {"error": f"Error calculating ESG score: {e}"}




