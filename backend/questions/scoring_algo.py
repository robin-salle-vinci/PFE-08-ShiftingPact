def calculate_esg_score(questions, choices, responses):
  # Initialiser les scores par thème
  theme_scores_today = {"Environnement": 0, "Social": 0, "Gouvernance": 0}
  theme_scores_in_two_years = {"Environnement": 0, "Social": 0,
                               "Gouvernance": 0}
  max_scores_by_theme = {"Environnement": 0, "Social": 0, "Gouvernance": 0}

  # Calcul des scores pour chaque enjeu
  for question in questions:
    question_id = question["id"]

    # Récupérer les choix et le score max pour cette question
    question_choices = [c for c in choices if c["id_question"] == question_id]
    max_score_question = sum(c["score_choice"] for c in question_choices) / 2

    if max_score_question == 0:
      continue

    # Réponses associées à la question
    question_responses = [r for r in responses if
                          r["id_question"] == question_id]

    # Calculer les scores des engagements aujourd'hui et dans deux ans
    score_today = sum(
        c["score_choice"] for r in question_responses if
        r["type_engagement"] == "aujourd'hui"
        for c in question_choices if c["value"] == r["value"]
    )
    score_in_two_years = sum(
        c["score_choice"] * 0.25 for r in question_responses if
        r["type_engagement"] == "dans deux ans"
        for c in question_choices if c["value"] == r["value"]
    )

    # Normaliser les scores sur le score max
    score_today = min(score_today, max_score_question)
    score_in_two_years = min(score_in_two_years, max_score_question)

    # Debug prints
    print(f"Question ID: {question_id}")
    print(f"Score Today: {score_today}/{max_score_question}")
    print(f"Score In Two Years: {score_in_two_years}/{max_score_question}")

    # Ajouter les scores au thème correspondant
    theme = question["challenge"]
    theme_scores_today[theme] += score_today / max_score_question
    theme_scores_in_two_years[theme] += score_in_two_years / max_score_question

    # Ajouter le score max au total pour le thème
    max_scores_by_theme[theme] += 1

  # Calcul des scores totaux par thème
  total_scores_today = sum(
      theme_scores_today[theme] for theme in theme_scores_today)
  total_scores_in_two_years = sum(
      theme_scores_in_two_years[theme] for theme in theme_scores_in_two_years)
  max_scores_total = sum(
      max_scores_by_theme[theme] for theme in max_scores_by_theme)

  # Calcul du score ESG total en pourcentage
  esg_score_percentage = ((total_scores_today + total_scores_in_two_years) / max_scores_total) * 100

  return theme_scores_today, theme_scores_in_two_years, esg_score_percentage


# Simuler les questions
questions = [
  {"id": "q1", "challenge": "Environnement",
   "sub_challenge": "Gestion de l'énergie", "type_response": "QCM"},
  {"id": "q2", "challenge": "Environnement",
   "sub_challenge": "Empreinte carbone", "type_response": "QCM"},
  {"id": "q3", "challenge": "Environnement", "sub_challenge": "Eau",
   "type_response": "QCM"},
  {"id": "q4", "challenge": "Environnement",
   "sub_challenge": "Matières premières et fournitures",
   "type_response": "QCM"},
  {"id": "q5", "challenge": "Environnement", "sub_challenge": "Déchets",
   "type_response": "QCM"},
  {"id": "q6", "challenge": "Environnement",
   "sub_challenge": "Écosystèmes et biodiversité", "type_response": "QCM"}
]

# Simuler les choix
choices = [
  {"id_question": "q1", "value": "Énergie renouvelable", "score_choice": 2.0},
  {"id_question": "q1", "value": "Énergie fossile", "score_choice": 0.0},
  {"id_question": "q2", "value": "Réduction des émissions",
   "score_choice": 3.0},
  {"id_question": "q2", "value": "Augmentation des émissions",
   "score_choice": 1.0},
  {"id_question": "q3", "value": "Réduction de la consommation d'eau",
   "score_choice": 4.0},
  {"id_question": "q3", "value": "Augmentation de la consommation",
   "score_choice": 0.0},
  {"id_question": "q4", "value": "Utilisation de matériaux recyclés",
   "score_choice": 3.0},
  {"id_question": "q4", "value": "Utilisation de nouveaux matériaux",
   "score_choice": 1.0},
  {"id_question": "q5", "value": "Gestion efficace des déchets",
   "score_choice": 2.5},
  {"id_question": "q5", "value": "Aucune gestion", "score_choice": 0.0},
  {"id_question": "q6", "value": "Protection des habitats",
   "score_choice": 3.5},
  {"id_question": "q6", "value": "Destruction des habitats",
   "score_choice": 0.0}
]

# Simuler les réponses
responses = [
  {"id_question": "q1", "value": "Énergie renouvelable",
   "type_engagement": "aujourd'hui"},
  {"id_question": "q2", "value": "Réduction des émissions",
   "type_engagement": "dans deux ans"},
  {"id_question": "q3", "value": "Réduction de la consommation d'eau",
   "type_engagement": "aujourd'hui"},
  {"id_question": "q4", "value": "Utilisation de matériaux recyclés",
   "type_engagement": "dans deux ans"},
  {"id_question": "q5", "value": "Gestion efficace des déchets",
   "type_engagement": "aujourd'hui"},
  {"id_question": "q6", "value": "Protection des habitats",
   "type_engagement": "dans deux ans"}
]

# Calculer les scores
results = calculate_esg_score(questions, choices, responses)

# Afficher les résultats
print("\n=== Résultats ===")
print("Scores par thème aujourd'hui:", results[0])
print("Scores par thème dans deux ans:", results[1])
print("Score ESG total en pourcentage:", results[2])
