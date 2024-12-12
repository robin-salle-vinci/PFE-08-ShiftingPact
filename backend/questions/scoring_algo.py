from typing import Dict, Any, Tuple, List
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
        if not isinstance(choices, list):
            raise ValueError(
                f"Expected a list for choices, got {type(choices).__name__}: {choices}")

        # Initialize scores
        score_today = 0.0
        score_in_two_years = 0.0

        if question.type_response == '%':
            # Use the highest percentage value as the max score
            valid_scores = [choice.score for choice in choices if
                            choice.value is not None]
            if not valid_scores:
                raise ValueError("No valid scores found in choices.")
            max_percentage_value = max(valid_scores)
            score_max = round(max_percentage_value / 2.0, 2)
        else:
            # Default max score logic
            score_max = round(sum(choice.score for choice in choices) / 2 if choices else 0.0, 2)

        # Calculate the actual score
        selected_choice = next((choice for choice in choices if choice.id == answer.id_choice), None)
        if selected_choice:
            if answer.is_commitment:
                score_in_two_years = round((selected_choice.score * 100) /4, 2)
            else:
                score_today = round(selected_choice.score, 2)
        return {
            "score_today": score_today,
            "score_in_two_years": score_in_two_years,
            "score_max": score_max,
        }
    except Exception as e:
        raise ValueError(f"Error calculating question score: {e}")


def calculate_sub_challenge_scores(module_esg) -> Dict[str, Dict[str, Any]]:
    # Initialize the dictionary to store sub-challenge scores
    sub_challenge_scores = {"today": {}, "in_two_years": {}}

    # Retrieve all the original and modified answers in one query
    original_answers = {answer.id_question: answer for answer in Answers.objects.filter(id__in=module_esg.original_answers)}
    modified_answers = {answer.id_question: answer for answer in Answers.objects.filter(id__in=module_esg.modified_answers)}

    # Combine original and modified answers
    answers_dict = {**original_answers, **modified_answers}

    # List of answers to commit (no need to iterate twice)
    answers_to_commitment = answers_dict.values()

    # Iterate through all answers to calculate sub-challenge scores
    for answer in answers_to_commitment:
        try:
            # Retrieve associated data
            question = Questions.get_by_id(answer.id_question)
            sub_challenge = SubChallenges.get_by_id(answer.id_sub_challenge)
            choices = [Choices.get_by_id(choice_id) for choice_id in question.choices]

            # Calculate scores for the question
            question_scores = calculate_question_score(answer, question, choices)

            # Initialize sub-challenge scores if not already done
            sub_challenge_scores["today"].setdefault(sub_challenge.id, {
                "name": sub_challenge.value, "score": 0.0, "score_max": 0.0
            })
            sub_challenge_scores["in_two_years"].setdefault(sub_challenge.id, {
                "name": sub_challenge.value, "score": 0.0, "score_max": 0.0
            })

            # Update scores
            sub_challenge_scores["today"][sub_challenge.id]["score"] += question_scores["score_today"]
            sub_challenge_scores["today"][sub_challenge.id]["score_max"] += question_scores["score_max"]
            sub_challenge_scores["in_two_years"][sub_challenge.id]["score"] += question_scores["score_in_two_years"]
            sub_challenge_scores["in_two_years"][sub_challenge.id]["score_max"] += question_scores["score_max"]

        except Exception as e:
            print(f"Error processing answer {answer.id}: {e}")

    challenges_index = {"today": {}, "in_two_years": {}, "total_score": 0.0, "total_score_max" : 0.0, "total_score_pourcentage": 0.0}
    # Integrate the sub-challenge scores into the challenge index
    for challenge in Challenges.get_all():
        # Ensure sub-challenge scores are initialized in challenge index
        challenges_index["today"].setdefault(challenge.index_challenge, {
            "id": challenge.id,
            "value": challenge.value,
            "sub_challenges": {}
        })
        challenges_index["in_two_years"].setdefault(challenge.index_challenge, {
            "id": challenge.id,
            "value": challenge.value,
            "sub_challenges": {}
        })
        challenges_index["total_score"] = 0.0
        challenges_index["total_score_max"] = 0.0
        challenges_index["total_score_pourcentage"] = 0.0

        for sub_challenge_id in challenge.sub_challenges:
            sub_challenge_object = SubChallenges.get_by_id(sub_challenge_id)

            challenges_index["today"][challenge.index_challenge][
                "sub_challenges"].setdefault(
                sub_challenge_object.index_sub_challenge, {
                    "id": sub_challenge_object.id,
                    "value": sub_challenge_object.value,
                    "score": 0.0,
                    "score_max": 0.0,
                })
            challenges_index["in_two_years"][challenge.index_challenge][
                "sub_challenges"].setdefault(
                sub_challenge_object.index_sub_challenge, {
                    "id": sub_challenge_object.id,
                    "value": sub_challenge_object.value,
                    "score": 0.0,
                    "score_max": 0.0,
                })

            # Add scores from sub_challenge_scores to the challenges index
            if sub_challenge_object.id in sub_challenge_scores["today"]:
                challenges_index["today"][challenge.index_challenge][
                    "sub_challenges"][sub_challenge_object.index_sub_challenge][
                    "score"] = \
                    sub_challenge_scores["today"][sub_challenge_object.id][
                        "score"]
                challenges_index["today"][challenge.index_challenge][
                    "sub_challenges"][sub_challenge_object.index_sub_challenge][
                    "score_max"] = \
                    sub_challenge_scores["today"][sub_challenge_object.id][
                        "score_max"]

            if sub_challenge_object.id in sub_challenge_scores["in_two_years"]:
                challenges_index["in_two_years"][challenge.index_challenge][
                    "sub_challenges"][sub_challenge_object.index_sub_challenge][
                    "score"] = \
                    sub_challenge_scores["in_two_years"][
                        sub_challenge_object.id]["score"]
                challenges_index["in_two_years"][challenge.index_challenge][
                    "sub_challenges"][sub_challenge_object.index_sub_challenge][
                    "score_max"] = \
                    sub_challenge_scores["in_two_years"][
                        sub_challenge_object.id]["score_max"]

        # Sort sub-challenges by index
        challenges_index["today"][challenge.index_challenge][
            "sub_challenges"] = dict(
            sorted(challenges_index["today"][challenge.index_challenge][
                       "sub_challenges"].items(), key=lambda x: x[0])
        )
        challenges_index["in_two_years"][challenge.index_challenge][
            "sub_challenges"] = dict(
            sorted(challenges_index["in_two_years"][challenge.index_challenge][
                       "sub_challenges"].items(), key=lambda x: x[0])
        )

    # Sort challenges by index_challenge
    challenges_index["today"] = dict(
        sorted(challenges_index["today"].items(), key=lambda x: x[0])
    )
    challenges_index["in_two_years"] = dict(
        sorted(challenges_index["in_two_years"].items(), key=lambda x: x[0])
    )

    return challenges_index


def calculate_challenge_scores(module_esg) -> dict[str, dict[str, Any]]:
    # Calculate sub-challenge scores
    challenges_index_1 = calculate_sub_challenge_scores(module_esg)
    # Aggregate challenge scores
    for index_challenge, sub_challenges in challenges_index_1["today"].items():
        # Initialize dictionaries to hold scores
        challenge_score_today = 0.0
        challenge_score_max_today = 0.0
        challenge_score_two_years = 0.0
        challenge_score_max_two_years = 0.0

        # Store sub-challenge details and aggregate scores
        for index_sub_challenge, sub_challenge_data in sub_challenges["sub_challenges"].items():
            # Add to the score totals
            challenge_score_today += sub_challenge_data["score"]
            challenge_score_max_today += sub_challenge_data["score_max"]
            challenge_score_two_years += challenges_index_1["in_two_years"][index_challenge]["sub_challenges"].get(index_sub_challenge, {}).get("score", 0.0)
            challenge_score_max_two_years += challenges_index_1["in_two_years"][index_challenge]["sub_challenges"].get(index_sub_challenge, {}).get("score_max", 0.0)

        # Store the challenge scores
        challenges_index_1["today"][index_challenge] = {
            "score_details": {
                "score": challenge_score_today,
                "score_max": challenge_score_max_today
            }
        }
        challenges_index_1["in_two_years"][index_challenge] = {
            "score_details": {
                "score": challenge_score_two_years,
                "score_max": challenge_score_max_two_years
            }
        }
        challenges_index_1["today"][index_challenge]["sub_challenges"] = sub_challenges
        challenges_index_1["in_two_years"][index_challenge]["sub_challenges"] = sub_challenges

    return challenges_index_1




def calculate_theme_scores(module_esg) -> tuple[
    dict[str, dict[str, Any]], dict[str, list[Any] | dict[Any, Any]]]:
    theme_scores = {"today": {}, "in_two_years": {}}
    challenges_index_1 = calculate_challenge_scores(module_esg)
    print("looooo")
    # Iterate over the 'today' and 'in_two_years' challenges to calculate theme scores
    for period in ["today", "in_two_years"]:
        for challenge_id, challenge_data in challenges_index_1[period].items():
            try:
                # Retrieve the challenge and its associated theme from color
                challenge_uuid = challenges_index_1[period][challenge_id]["sub_challenges"]["id"]
                challenge = Challenges.get_by_id(challenge_uuid)
                theme = Challenges.get_theme_from_color(challenge.color)
                # Ensure the theme exists in theme_scores structure
                if theme not in theme_scores[period]:
                    theme_scores[period][theme] = {"score": 0.0,"score_max": 0.0}
                # Accumulate the scores for this theme
                theme_scores[period][theme]["score"] += challenge_data["score_details"]["score"]
                theme_scores[period][theme]["score_max"] += challenge_data["score_details"]["score_max"]

            except Exception as e:
                print(f"Error processing challenge {challenge_id}: {e}")


    return challenges_index_1, theme_scores


# Step 4: Calculate global ESG scores
def calculate_global_esg_scores(module_esg) -> Dict[str, float]:
    challenges_scores, theme_scores_result = calculate_theme_scores(module_esg)
    try:
        # Initialize variables for total scores and max scores
        total_today = {"score": 0, "max_score": 0}
        total_in_two_years = {"score": 0, "max_score": 0}

        # # Calculate the sum of scores and max scores for today
        # if theme_scores.get("today"):
        #     for theme in theme_scores["today"].values():
        #         total_today["score"] += theme.get("score", 0)
        #         total_today["max_score"] += theme.get("score_max", 0)
        #
        # # Calculate the sum of scores and max scores for in two years
        # if theme_scores.get("in_two_years"):
        #     for theme in theme_scores["in_two_years"].values():
        #         total_in_two_years["score"] += theme.get("score", 0)
        #         total_in_two_years["max_score"] += theme.get("score_max", 0)
        #
        # # Combine total scores for today and in two years
        # combined_total = {
        #     "score": total_today["score"] + total_in_two_years["score"],
        #     "max_score": total_today["max_score"]
        # }
        #
        # # Calculate total ESG percentages
        # total_percentage = (
        #     combined_total["score"] / combined_total["max_score"] * 100
        #     if combined_total["max_score"] > 0 else 0
        # )

        # Prepare combined scores for return
        combined_scores = stringify_keys({
            "challenges_score" : challenges_scores,
            "theme_scores": theme_scores_result,
            # "total_today": total_today,
            # "total_in_two_years": total_in_two_years,
            # "combined_total": combined_total,
            # "total_percentage": total_percentage
        })

        return combined_scores
    except Exception as e:
        raise ValueError(f"Error calculating global ESG scores: {e}")
