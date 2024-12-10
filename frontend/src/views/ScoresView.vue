import HeaderElement from '@/components/structure/HeaderElement.vue'

<template>
        <HeaderElement />
        <h1 id="titre">Score ESG</h1>


    <div>
    <table class="esg-table">
      <thead>
        <tr>
          <th rowspan="2"></th>
          <th colspan="3" class="bold-header">Score actuel</th>
          <th colspan="3" class="bold-header">Score engagement</th>
          <th colspan="3" class="bold-header">Score total</th>
          <th rowspan="2" class="bold-header">Reste</th>
          <th rowspan="2" class="bold-header">Score "futur"</th>
        </tr>
        <tr>
          <th class="bold-header">Points</th>
          <th class="bold-header">/ Total</th>
          <th class="bold-header">%</th>
          <th class="bold-header">Points</th>
          <th class="bold-header">/ Total</th>
          <th class="bold-header">%</th>
          <th class="bold-header">Points</th>
          <th class="bold-header">/ Total</th>
          <th class="bold-header">%</th>
        </tr>
      </thead>
      <tbody>
        <tr class="category" v-for="(category, index) in categories" :key="index"
          :class="{
            'environment': category.name === 'Environnement',
            'social': category.name === 'Social',
            'gouvernance': category.name === 'Gouvernance',
            'total': category.name === 'TOTAL',
          }">
          <td>{{ category.name }}</td>
          <td class="bold-cell">{{ category.currentScore }}</td>
          <td class="bold-cell">/ {{ category.currentTotal }}</td>
          <td class="bold-cell">{{ (category.currentPercentage) }}%</td>
          <td class="bold-cell">{{ category.engagementScore }}</td>
          <td class="bold-cell">/ {{ category.engagementTotal }}</td>
          <td class="bold-cell">{{ (category.engagementPercentage) }}%</td>
          <td class="bold-cell">{{ category.total_esg_score }}</td>
          <td class="bold-cell">/ {{ 30 }}</td>
          <td class="bold-cell">{{ category.total_esg_score / 30 }}%</td>
          <td class="bold-cell">{{ 1 - category.total_esg_score / 30 }}%</td>
          <td class="bold-cell">{{ (category.currentScore + 4 * category.engagementScore ) / 30}}%</td>
        </tr>
      </tbody>
    </table>
  </div>




    <div class="container">
        <table class="esg-table">
  <thead>
    <tr>
      <th rowspan="2"></th>
      <th colspan="3" class="bold-header">Score actuel</th>
      <th colspan="3" class="bold-header">Score engagement</th>
    </tr>
    <tr>
      <th class="bold-header">Points</th>
      <th class="bold-header">/ Total</th>
      <th class="bold-header">%</th>
      <th class="bold-header">Points</th>
      <th class="bold-header">/ Total</th>
      <th class="bold-header">%</th>
    </tr>
  </thead>
  <tbody>
    <tr class="category" v-for="(category2, index) in categories2" :key="index"
      :class="{
      }">
      <td class="bold-cell">{{ category2.name }}</td>

      <td class="bold-cell">{{ category2.currentScore }}</td>
      <td class="bold-cell">/ {{ category2.currentTotal}}</td>
      <td class="bold-cell">{{ (category2.currentScore / category2.currentTotal) }}%</td>

      <td class="bold-cell">{{ category2.engagementScore }}</td>
      <td class="bold-cell">/ {{ category2.engagementTotal }}</td>
      <td class="bold-cell">{{ (category2.engagementScore / category2.engagementTotal) }}%</td>
    </tr>
    <!--
    <tr class="bonus" v-for="(bonus, index) in bonusItems" :key="index">
      <td>{{ bonus.name }}</td>
      <td>{{ bonus.currentScore }}</td>
       <td>/</td>
       <td>/</td>
      <td>{{ bonus.engagementScore }}</td>
      <td>/</td>
      <td>/</td>
    </tr>
    -->


  </tbody>
</table>
</div>


</template>







<!--
  // eslint-disable-next-line vue/block-lang
  <script lang="ts">
  import HeaderElement from '@/components/structure/HeaderElement.vue';
  export default {
    components: {
        HeaderElement
    },
    data() {
      return {
        categories: [
          { name: 'Environnement', currentScore: 50, totalScore: 100, engagementScore: 40 },
          { name: 'Social', currentScore: 60, totalScore: 100, engagementScore: 50 },
          { name: 'Gouvernance', currentScore: 70, totalScore: 100, engagementScore: 60 },
          { name: 'TOTAL', currentScore: 180, totalScore: 300, engagementScore: 150 }
        ],
        bonusItems: [
        { name: 'BONUS Transparence', currentScore: 5, engagementScore : 0.111111 },
        { name: 'BONUS Formalisation', currentScore: 7, engagementScore : 0.1234326}
      ],
        categories2: [
            { name: 'Energie', currentScore: 50, totalScore: 100, engagementScore: 40 },
            { name: 'empreinte carbone', currentScore: 60, totalScore: 100, engagementScore: 50 },
            { name: 'eau', currentScore: 70, totalScore: 100, engagementScore: 60 },
            { name: 'matières premières & fournitures', currentScore: 80, totalScore: 100, engagementScore: 70 },
            { name: 'déchets', currentScore: 65, totalScore: 100, engagementScore: 55 },
            { name: 'écosystèmes & biodiversités', currentScore: 75, totalScore: 100, engagementScore: 65 },
            { name: 'diversité inclusion & équité', currentScore: 85, totalScore: 100, engagementScore: 75 },
            { name: 'sécurité au travail', currentScore: 90, totalScore: 100, engagementScore: 80 },
            { name: 'santé & bien-être', currentScore: 88, totalScore: 100, engagementScore: 78 },
            { name: 'développement des compétences', currentScore: 95, totalScore: 100, engagementScore: 85 },
            { name: 'engagement & satisfaction', currentScore: 70, totalScore: 100, engagementScore: 60 },
            { name: 'engagement civique', currentScore: 60, totalScore: 100, engagementScore: 50 },
            { name: 'structure de gouvernance', currentScore: 80, totalScore: 100, engagementScore: 70 },
            { name: 'intégration des parties prenantes', currentScore: 85, totalScore: 100, engagementScore: 75 },
            { name: 'gestion durable', currentScore: 90, totalScore: 100, engagementScore: 80 },
            { name: 'éthique des affaires', currentScore: 75, totalScore: 100, engagementScore: 65 },
            { name: 'protection des données', currentScore: 95, totalScore: 100, engagementScore: 85 },
            { name: 'certifications', currentScore: 60, totalScore: 100, engagementScore: 50 },
            ],
          score_max_today: today.score_max,
          score_max_engagement: future.score_max || today.score_max,
      };
    },
  };
  </script>
-->











<script setup lang="ts">
import { ref, onMounted } from 'vue';
import axios from 'axios';
import HeaderElement from '@/components/structure/HeaderElement.vue';
import type { AxiosResponse } from 'axios';

interface category {
  name: string;
  currentScore: number;
  currentTotal: number;
  currentPercentage: number;
  engagementScore: number;
  engagementTotal: number;
  engagementPercentage: number;
  total_esg_score_today: number;
  total_esg_score_in_two_years: number;
  total_esg_score: number;
}

interface category2 {
  name: string;
  currentScore: number;
  currentTotal: number;
  currentPercentage: number;
  engagementScore: number;
  engagementTotal: number;
  engagementPercentage: number;
  totalScore: number;
}

const categories = ref<category[]>([]);
const categories2 = ref<category2[]>([]);

// Récupérer les données du backend
const fetchESGData = async () => {
    const apiUrl = import.meta.env.VITE_API_URL;
    const uuidModuleEsg = '550e8400-e29b-41d4-a716-446655440025';
    const fullUrl = `${apiUrl}/modules/score/${uuidModuleEsg}`;

    // Récupérer le token depuis localStorage
    const token = localStorage.getItem('token');  // S'assurer que le token est stocké dans localStorage
    if (!token) {
        console.error('Token manquant');
        return; // Arrêter l'exécution si le token n'est pas trouvé
    }

    try {
        // Effectuer la requête GET avec le token dans l'en-tête Authorization
        const response: AxiosResponse = await axios.get(fullUrl, {
            headers: {
                'Authorization': `Bearer ${token}`,
            },
        });

        const moduleData = response.data;

        // Transformation des données du backend pour les sous-challenges
        const todayScores = moduleData.sub_challenge_scores.today;
        const futureScores = moduleData.sub_challenge_scores.in_two_years;
        const total_esg_score_today = moduleData.total_esg_score_today;
        const total_esg_score_in_two_years = moduleData.total_esg_score_in_two_years;
        const total_esg_score = moduleData.total_esg_score;

        // Fusionner les données basées sur le nom des sous-challenges
        const combinedScores = Object.keys(todayScores).map((id) => {
            const today = todayScores[id];
            const future = futureScores[id] || {};

            const currentPercentage = (today.score / today.score_max) * 100;
            const engagementPercentage = (future.score / future.score_max) * 100;

            return {
                name: today.name, // Nom du sous-défi
                currentScore: today.score, // Score actuel
                currentTotal: today.score_max, // Total actuel
                currentPercentage: currentPercentage, // Pourcentage actuel
                engagementScore: future.score || 0, // Score d'engagement (valeur par défaut 0)
                engagementTotal: future.score_max || today.score_max, // Total d'engagement
                engagementPercentage: engagementPercentage, // Pourcentage d'engagement
                total_esg_score_today, // Total aujourd'hui
                total_esg_score_in_two_years, // Total dans 2 ans
                total_esg_score, // Score total
                totalScore: moduleData.total_esg_score, // Ajouter totalScore
            };
        });

        // Transformation des données du backend pour les thèmes
        const todayScores_theme = moduleData.theme_scores.today;
        const futureScores_theme = moduleData.theme_scores.in_two_years;

        // Fusionner les données basées sur le nom des thèmes (Environnement, Social, etc.)
        const combinedScores2 = Object.keys(todayScores_theme).map((key) => {
            const today = todayScores_theme[key];
            const future = futureScores_theme[key] || {};

            // Calculer les pourcentages
            const currentPercentage = (today.score / today.score_max) * 100;
            const engagementPercentage = (future.score / future.score_max) * 100;

            return {
                name: key, // Nom de la catégorie (Environnement, Social, etc.)
                currentScore: today.score, // Score actuel
                currentTotal: today.score_max, // Total actuel
                currentPercentage: currentPercentage, // Pourcentage actuel
                engagementScore: future.score || 0, // Score d'engagement
                engagementTotal: future.score_max || today.score_max, // Total d'engagement
                engagementPercentage: engagementPercentage, // Pourcentage d'engagement
                totalScore: moduleData.total_esg_score, // Score total
            };
        });

        // Vérifier les données avant de les mapper
        console.log("Données combinées pour les thèmes (combinedScores2) : ", combinedScores2);

        // Assigner les résultats aux variables réactives
        categories.value = combinedScores2.map(score => {
            console.log("Score avant mappage :", score); // Afficher chaque score
            return {
                ...score,
                total_esg_score_today,
                total_esg_score_in_two_years,
                total_esg_score
            };
        });

        categories2.value = combinedScores;  // Remplir categories2 avec les sous-challenges

        console.log("Noms des catégories extraits : ", combinedScores2.map(c => c.name));

    } catch (error) {
        if (axios.isAxiosError(error)) {
            console.error('Erreur Axios:', error.response ? error.response.data : error.message);
        } else {
            console.error('Erreur lors de la récupération des données ESG', error);
        }
    }
};

// Charger les données lors de la montée du composant
onMounted(() => {
    fetchESGData();
});


</script>




























<style scoped>
.container {
  padding-bottom: 50px;  /* Ajoute de l'espace en bas du conteneur */
}
.esg-table {
  width: 100%; /* Fait en sorte que le tableau prenne toute la largeur disponible de son container */
  max-width: 1200px; /* Optionnel : limite la largeur maximale à 1200px (tu peux ajuster cette valeur) */
  margin-left: auto; /* Centrer le tableau */
  margin-right: auto; /* Centrer le tableau */
  border-collapse: collapse;
}

  .esg-table th,
  .esg-table td {
    border: 1px solid black;
    padding: 8px;
    text-align: center;
  }


.esg-table .bold-cell {
  font-weight: bold;
  border: 2px solid black;  /* Contour plus épais pour les cellules */
}

  .esg-table .category {
    font-weight: bold;
  }

  .esg-table .environment {
    background-color: #b5cdbf;
  }

  .esg-table .social {
    background-color: #dfd4fb;
  }

  .esg-table .gouvernance {
    background-color: #fde791;
  }

  .esg-table .total {
    background-color: #c5cae9; /* Bleu clair */
  }

  .esg-table .bonus {
    font-style: italic;
  }



    @import url('https://fonts.googleapis.com/css?family=Lobster+Two&display=swap');

    #titre{
    font-family: 'Lobster Two', cursive;
    font-size: 5rem;
    text-shadow: 0px 1px 0px rgba(255, 255, 255, 1);
    color: #343434;
    text-align: center;  /* Centre le texte horizontalement */
    margin: 0;
    position: relative;
    z-index: 1;

    /* Animation de pulsation sur le titre */
    animation: pulseText 2s infinite cubic-bezier(.5, .5, 0, 1);
    }

    .container {
        position: relative;
        z-index: 0;
        background-color: #ededed;
        display: flex;
        align-items: center;
        justify-content: center;
        min-height: 100vh;
        overflow: hidden;
    }

    .pulse {
        z-index: -1;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        max-width: 30rem;
    }

    .pulse circle {
        fill: #ff5154;
        transform: scale(0);
        opacity: 0;
        transform-origin: 50% 50%;
        animation: pulse 2s cubic-bezier(.5, .5, 0, 1);
    }

    .pulse circle:nth-child(2) {
        fill: #7fc6a4;
        animation: pulse 2s 0.75s cubic-bezier(.5, .5, 0, 1);
    }

    .pulse circle:nth-child(3) {
        fill: #e5f77d;
        animation: pulse 2s 1.5s cubic-bezier(.5, .5, 0, 1);
    }

    @keyframes pulse {
        25% {
            opacity: 0.4;
        }

        100% {
            transform: scale(1);
        }
    }

/* Animation pulsante sur le texte du titre */
    @keyframes pulseText {
        0% {
            transform: scale(1);
            opacity: 1;
            }

        50% {
            transform: scale(1.1);
            opacity: 0.7;
            }

        100% {
            transform: scale(1);
            opacity: 1;
            }
    }


    .bold-header {
  font-weight: bold;
  border: 2px solid black;
  padding: 10px;
}

</style>

