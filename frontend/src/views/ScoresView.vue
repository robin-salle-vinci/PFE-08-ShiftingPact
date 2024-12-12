import HeaderElement from '@/components/structure/HeaderElement.vue'

<template>
  <div v-if="isLoading" class="loader">
    <div class="container2">
      <div class="coffee-header">
        <div class="coffee-header__buttons coffee-header__button-one"></div>
        <div class="coffee-header__buttons coffee-header__button-two"></div>
        <div class="coffee-header__display"></div>
        <div class="coffee-header__details"></div>
      </div>
      <div class="coffee-medium">
        <div class="coffe-medium__exit"></div>
        <div class="coffee-medium__arm"></div>
        <div class="coffee-medium__liquid"></div>
        <div class="coffee-medium__smoke coffee-medium__smoke-one"></div>
        <div class="coffee-medium__smoke coffee-medium__smoke-two"></div>
        <div class="coffee-medium__smoke coffee-medium__smoke-three"></div>
        <div class="coffee-medium__smoke coffee-medium__smoke-for"></div>
        <div class="coffee-medium__cup"></div>
      </div>
      <div class="coffee-footer"></div>
    </div>
  </div>

  <div v-else>
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
          <tr
            class="category"
            v-for="(category, index) in categories"
            :key="index"
            :class="{
              environment: category.name === 'Environnement',
              social: category.name === 'Social',
              gouvernance: category.name === 'Gouvernance',
              total: category.name === 'TOTAL',
            }"
          >
            <td>{{ category.name }}</td>
            <td class="bold-cell">{{ category.currentScore.toFixed(1) }}</td>
            <td class="bold-cell">/ {{ category.currentTotal.toFixed(1) }}</td>
            <td class="bold-cell">{{ category.currentPercentage.toFixed(1) }}%</td>
            <td class="bold-cell">{{ category.engagementScore.toFixed(1) }}</td>
            <td class="bold-cell">/ {{ category.engagementTotal.toFixed(1) }}</td>
            <td class="bold-cell">{{ category.engagementPercentage.toFixed(1) }}%</td>
            <td class="bold-cell">{{ category.total_esg_score.toFixed(1) }}</td>
            <td class="bold-cell">/ {{ 30 }}</td>
            <td class="bold-cell">{{ (category.total_esg_score / 30).toFixed(1) }}%</td>
            <td class="bold-cell">{{ (1 - category.total_esg_score / 30).toFixed(1) }}%</td>
            <td class="bold-cell">
              {{ ((category.currentScore + 4 * category.engagementScore) / 30).toFixed(1) }}%
            </td>
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
          <tr class="category" v-for="(category2, index) in categories2" :key="index" :class="{}">
            <td class="bold-cell">{{ category2.name }}</td>

            <td class="bold-cell">{{ category2.currentScore.toFixed(1) }}</td>
            <td class="bold-cell">/ {{ category2.currentTotal.toFixed(1) }}</td>
            <td class="bold-cell">
              {{ (category2.currentScore / category2.currentTotal).toFixed(1) }}%
            </td>

            <td class="bold-cell">{{ category2.engagementScore.toFixed(1) }}</td>
            <td class="bold-cell">/ {{ category2.engagementTotal.toFixed(1) }}</td>
            <td class="bold-cell">
              {{ (category2.engagementScore / category2.engagementTotal).toFixed(1) }}%
            </td>
          </tr>

          <tr class="bonus" v-for="(bonus, index) in [bonusTransparence, bonusFormalisation]" :key="index">
            <td>{{ bonus.name }}</td>
            <td>{{ bonus.currentScore }}</td>
              <td>/</td>
              <td>/</td>
            <td>{{ bonus.engagementScore }}</td>
            <td>/</td>
            <td>/</td>
          </tr>

        </tbody>
      </table>
    </div>
  </div>
</template>




<script setup lang="ts">
import HeaderElement from '@/components/structure/HeaderElement.vue';
import { getToken } from '@/utils/localstorage';
import type { AxiosResponse } from 'axios';
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';

interface Category {
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

interface Category2 {
  name: string;
  currentScore: number;
  currentTotal: number;
  currentPercentage: number;
  engagementScore: number;
  engagementTotal: number;
  engagementPercentage: number;
  totalScore: number;
}

interface BonusTransparence {
  name: string;
  currentScore: number;
  engagementScore: number;
}

interface BonusFormalisation {
  name: string;
  currentScore: number;
  engagementScore: number;
}

const categories = ref<Category[]>([]);
const categories2 = ref<Category2[]>([]);
const isLoading = ref(true);
const bonusTransparence = ref<BonusTransparence>({ name : "Bonus Transparence", currentScore: 0, engagementScore: 0 });
const bonusFormalisation = ref<BonusFormalisation>({ name : "Bonus Formalisation", currentScore: 0, engagementScore: 0 });

const fetchESGData = async () => {
  const apiUrl = import.meta.env.VITE_API_URL;
  const route = useRoute();
  const id = Array.isArray(route.params.id) ? route.params.id[0] : route.params.id;

  try {
    const response: AxiosResponse = await axios.get(
      `${apiUrl}/modules/score/${id}?t=${Date.now()}`,
      {
        headers: { Authorization: `Bearer ${getToken()}` },
      }
    );

    const moduleData = response.data;
    console.log('Données renvoyées par l\'API :', moduleData);

    // Récupérer et transformer les sous-défis
    const todayChallenges = moduleData.challenges_score?.today || {};
    const futureChallenges = moduleData.challenges_score?.in_two_years || {};

    const combinedScores = Object.keys(todayChallenges).flatMap((challengeId) => {
      const todayChallenge = todayChallenges[challengeId];
      const futureChallenge = futureChallenges[challengeId] || {};

      // Vérification pour TRANSPARENCE et FORMALISATION DES PRATIQUES
      if (todayChallenge.sub_challenges.value === 'TRANSPARENCE') {
        Object.keys(todayChallenge.sub_challenges.sub_challenges).forEach((subId) => {
          const todaySubChallenge = todayChallenge.sub_challenges.sub_challenges[subId];
          const futureSubChallenge =
            futureChallenge.sub_challenges?.sub_challenges?.[subId] || {};

          bonusTransparence.value.currentScore += todaySubChallenge.score || 0;
          bonusTransparence.value.engagementScore += futureSubChallenge.score || 0;
        });
      }

      if (todayChallenge.sub_challenges.value === 'FORMALISATION DES PRATIQUES') {
        Object.keys(todayChallenge.sub_challenges.sub_challenges).forEach((subId) => {
          const todaySubChallenge = todayChallenge.sub_challenges.sub_challenges[subId];
          const futureSubChallenge =
            futureChallenge.sub_challenges?.sub_challenges?.[subId] || {};

          bonusFormalisation.value.currentScore += todaySubChallenge.score || 0;
          bonusFormalisation.value.engagementScore += futureSubChallenge.score || 0;
        });
      }

      return Object.keys(todayChallenge.sub_challenges.sub_challenges).map((subId) => {
        const todaySubChallenge = todayChallenge.sub_challenges.sub_challenges[subId];
        const futureSubChallenge =
          futureChallenge.sub_challenges?.sub_challenges?.[subId] || {};

        const currentPercentage = todaySubChallenge.score_max
          ? (todaySubChallenge.score / todaySubChallenge.score_max) * 100
          : 0;
        const engagementPercentage = futureSubChallenge.score_max
          ? (futureSubChallenge.score / futureSubChallenge.score_max) * 100
          : 0;

        return {
          name: todaySubChallenge.value,
          currentScore: todaySubChallenge.score,
          currentTotal: todaySubChallenge.score_max,
          currentPercentage,
          engagementScore: futureSubChallenge.score || 0,
          engagementTotal: futureSubChallenge.score_max || todaySubChallenge.score_max,
          engagementPercentage,
          totalScore: moduleData.combined_total || 0,
        };
      });
    });

    // Récupérer et transformer les thèmes
    const todayThemes = moduleData.theme_scores?.today || {};
    const futureThemes = moduleData.theme_scores?.in_two_years || {};

    const combinedScores2 = Object.keys(todayThemes).map((themeKey) => {
      const todayTheme = todayThemes[themeKey];
      const futureTheme = futureThemes[themeKey] || {};

      const currentPercentage = todayTheme.score_max
        ? (todayTheme.score / todayTheme.score_max) * 100
        : 0;
      const engagementPercentage = futureTheme.score_max
        ? (futureTheme.score / futureTheme.score_max) * 100
        : 0;

      return {
        name: themeKey,
        currentScore: todayTheme.score,
        currentTotal: todayTheme.score_max,
        currentPercentage,
        engagementScore: futureTheme.score || 0,
        engagementTotal: futureTheme.score_max || todayTheme.score_max,
        engagementPercentage,
        totalScore: moduleData.combined_total || 0,
      };
    });

    // Assigner les résultats
    categories.value = combinedScores2.map((score) => ({
      ...score,
      total_esg_score_today: moduleData.total_today || 0,
      total_esg_score_in_two_years: moduleData.total_in_two_years || 0,
      total_esg_score: moduleData.combined_total || 0,
    }));

    categories2.value = combinedScores;

    console.log('Catégories (Thèmes) :', categories.value);
    console.log('Catégories2 (Sous-challenges) :', categories2.value);
    console.log('Bonus Transparence :', bonusTransparence.value);
    console.log('Bonus Formalisation :', bonusFormalisation.value);
  } catch (error) {
    if (axios.isAxiosError(error)) {
      console.error('Erreur Axios:', error.response ? error.response.data : error.message);
    } else {
      console.error('Erreur lors de la récupération des données ESG:', error);
    }
  }
};

onMounted(async () => {
  await fetchESGData();
  setTimeout(() => {
    isLoading.value = false;
  }, 4000);
});
</script>










<!--
<script setup lang="ts">
import HeaderElement from '@/components/structure/HeaderElement.vue';
import { getToken } from '@/utils/localstorage';
import type { AxiosResponse } from 'axios';
import axios from 'axios';
import { onMounted, ref } from 'vue';
import { useRoute } from 'vue-router';

interface Category {
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

interface Category2 {
  name: string;
  currentScore: number;
  currentTotal: number;
  currentPercentage: number;
  engagementScore: number;
  engagementTotal: number;
  engagementPercentage: number;
  totalScore: number;
}

interface bonusTransparence {
  currentScore: number;
  engagementScore: number;
}

interface bonusFormalisation {
  currentScore: number;
  engagementScore: number;
}

const categories = ref<Category[]>([]);
const categories2 = ref<Category2[]>([]);
const isLoading = ref(true);

const fetchESGData = async () => {
  const apiUrl = import.meta.env.VITE_API_URL;
  const route = useRoute();
  const id = Array.isArray(route.params.id) ? route.params.id[0] : route.params.id;

  try {
    const response: AxiosResponse = await axios.get(
      `${apiUrl}/modules/score/${id}?t=${Date.now()}`,
      {
        headers: { Authorization: `Bearer ${getToken()}` },
      }
    );

    const moduleData = response.data;
    console.log('Données renvoyées par l\'API :', moduleData);

    // Récupérer et transformer les sous-défis
    const todayChallenges = moduleData.challenges_score?.today || {};
    const futureChallenges = moduleData.challenges_score?.in_two_years || {};

    const combinedScores = Object.keys(todayChallenges).flatMap((challengeId) => {
      const todayChallenge = todayChallenges[challengeId];
      const futureChallenge = futureChallenges[challengeId] || {};

      return Object.keys(todayChallenge.sub_challenges.sub_challenges).map((subId) => {
        const todaySubChallenge = todayChallenge.sub_challenges.sub_challenges[subId];
        const futureSubChallenge =
          futureChallenge.sub_challenges?.sub_challenges?.[subId] || {};

        const currentPercentage = todaySubChallenge.score_max
          ? (todaySubChallenge.score / todaySubChallenge.score_max) * 100
          : 0;
        const engagementPercentage = futureSubChallenge.score_max
          ? (futureSubChallenge.score / futureSubChallenge.score_max) * 100
          : 0;

        return {
          name: todaySubChallenge.value,
          currentScore: todaySubChallenge.score,
          currentTotal: todaySubChallenge.score_max,
          currentPercentage,
          engagementScore: futureSubChallenge.score || 0,
          engagementTotal: futureSubChallenge.score_max || todaySubChallenge.score_max,
          engagementPercentage,
          totalScore: moduleData.combined_total || 0,
        };
      });
    });

    // Récupérer et transformer les thèmes
    const todayThemes = moduleData.theme_scores?.today || {};
    const futureThemes = moduleData.theme_scores?.in_two_years || {};

    const combinedScores2 = Object.keys(todayThemes).map((themeKey) => {
      const todayTheme = todayThemes[themeKey];
      const futureTheme = futureThemes[themeKey] || {};

      const currentPercentage = todayTheme.score_max
        ? (todayTheme.score / todayTheme.score_max) * 100
        : 0;
      const engagementPercentage = futureTheme.score_max
        ? (futureTheme.score / futureTheme.score_max) * 100
        : 0;

      return {
        name: themeKey,
        currentScore: todayTheme.score,
        currentTotal: todayTheme.score_max,
        currentPercentage,
        engagementScore: futureTheme.score || 0,
        engagementTotal: futureTheme.score_max || todayTheme.score_max,
        engagementPercentage,
        totalScore: moduleData.combined_total || 0,
      };
    });

    // Assigner les résultats
    categories.value = combinedScores2.map((score) => ({
      ...score,
      total_esg_score_today: moduleData.total_today || 0,
      total_esg_score_in_two_years: moduleData.total_in_two_years || 0,
      total_esg_score: moduleData.combined_total || 0,
    }));

    categories2.value = combinedScores;

    console.log('Catégories (Thèmes) :', categories.value);
    console.log('Catégories2 (Sous-challenges) :', categories2.value);
  } catch (error) {
    if (axios.isAxiosError(error)) {
      console.error('Erreur Axios:', error.response ? error.response.data : error.message);
    } else {
      console.error('Erreur lors de la récupération des données ESG:', error);
    }
  }
};

onMounted(async () => {
  await fetchESGData();
  setTimeout(() => {
    isLoading.value = false;
  }, 4000);
});
</script>
-->





<style scoped>
  .container {
    padding-bottom: 50px; /* Ajoute de l'espace en bas du conteneur */
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
    border: 2px solid black; /* Contour plus épais pour les cellules */
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

  #titre {
    font-family: 'Lobster Two', cursive;
    font-size: 5rem;
    text-shadow: 0px 1px 0px rgba(255, 255, 255, 1);
    color: #343434;
    text-align: center; /* Centre le texte horizontalement */
    margin: 0;
    position: relative;
    z-index: 1;

    /* Animation de pulsation sur le titre */
    animation: pulseText 2s infinite cubic-bezier(0.5, 0.5, 0, 1);
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
    animation: pulse 2s cubic-bezier(0.5, 0.5, 0, 1);
  }

  .pulse circle:nth-child(2) {
    fill: #7fc6a4;
    animation: pulse 2s 0.75s cubic-bezier(0.5, 0.5, 0, 1);
  }

  .pulse circle:nth-child(3) {
    fill: #e5f77d;
    animation: pulse 2s 1.5s cubic-bezier(0.5, 0.5, 0, 1);
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

  .container2 {
    width: 300px;
    height: 280px;
    position: absolute;
    top: calc(50% - 140px);
    left: calc(50% - 150px);
  }
  .coffee-header {
    width: 100%;
    height: 80px;
    position: absolute;
    top: 0;
    left: 0;
    background-color: #ddcfcc;
    border-radius: 10px;
  }
  .coffee-header__buttons {
    width: 25px;
    height: 25px;
    position: absolute;
    top: 25px;
    background-color: #282323;
    border-radius: 50%;
  }
  .coffee-header__buttons::after {
    content: '';
    width: 8px;
    height: 8px;
    position: absolute;
    bottom: -8px;
    left: calc(50% - 4px);
    background-color: #615e5e;
  }
  .coffee-header__button-one {
    left: 15px;
  }
  .coffee-header__button-two {
    left: 50px;
  }
  .coffee-header__display {
    width: 50px;
    height: 50px;
    position: absolute;
    top: calc(50% - 25px);
    left: calc(50% - 25px);
    border-radius: 50%;
    background-color: #9acfc5;
    border: 5px solid #43beae;
    box-sizing: border-box;
  }
  .coffee-header__details {
    width: 8px;
    height: 20px;
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: #9b9091;
    box-shadow:
      -12px 0 0 #9b9091,
      -24px 0 0 #9b9091;
  }
  .coffee-medium {
    width: 90%;
    height: 160px;
    position: absolute;
    top: 80px;
    left: calc(50% - 45%);
    background-color: #bcb0af;
  }
  .coffee-medium:before {
    content: '';
    width: 90%;
    height: 100px;
    background-color: #776f6e;
    position: absolute;
    bottom: 0;
    left: calc(50% - 45%);
    border-radius: 20px 20px 0 0;
  }
  .coffe-medium__exit {
    width: 60px;
    height: 20px;
    position: absolute;
    top: 0;
    left: calc(50% - 30px);
    background-color: #231f20;
  }
  .coffe-medium__exit::before {
    content: '';
    width: 50px;
    height: 20px;
    border-radius: 0 0 50% 50%;
    position: absolute;
    bottom: -20px;
    left: calc(50% - 25px);
    background-color: #231f20;
  }
  .coffe-medium__exit::after {
    content: '';
    width: 10px;
    height: 10px;
    position: absolute;
    bottom: -30px;
    left: calc(50% - 5px);
    background-color: #231f20;
  }
  .coffee-medium__arm {
    width: 70px;
    height: 20px;
    position: absolute;
    top: 15px;
    right: 25px;
    background-color: #231f20;
  }
  .coffee-medium__arm::before {
    content: '';
    width: 15px;
    height: 5px;
    position: absolute;
    top: 7px;
    left: -15px;
    background-color: #9e9495;
  }
  .coffee-medium__cup {
    width: 80px;
    height: 47px;
    position: absolute;
    bottom: 0;
    left: calc(50% - 40px);
    background-color: #fff;
    border-radius: 0 0 70px 70px / 0 0 110px 110px;
  }
  .coffee-medium__cup::after {
    content: '';
    width: 20px;
    height: 20px;
    position: absolute;
    top: 6px;
    right: -13px;
    border: 5px solid #fff;
    border-radius: 50%;
  }
  @keyframes liquid {
    0% {
      height: 0px;
      opacity: 1;
    }
    5% {
      height: 0px;
      opacity: 1;
    }
    20% {
      height: 62px;
      opacity: 1;
    }
    95% {
      height: 62px;
      opacity: 1;
    }
    100% {
      height: 62px;
      opacity: 0;
    }
  }
  .coffee-medium__liquid {
    width: 6px;
    height: 63px;
    opacity: 0;
    position: absolute;
    top: 50px;
    left: calc(50% - 3px);
    background-color: #74372b;
    animation: liquid 3s linear;
  }
  .coffee-medium__smoke {
    width: 8px;
    height: 20px;
    position: absolute;
    border-radius: 5px;
    background-color: #b3aeae;
  }
  @keyframes smokeOne {
    0% {
      bottom: 20px;
      opacity: 0;
    }
    40% {
      bottom: 50px;
      opacity: 0.5;
    }
    80% {
      bottom: 80px;
      opacity: 0.3;
    }
    100% {
      bottom: 80px;
      opacity: 0;
    }
  }
  @keyframes smokeTwo {
    0% {
      bottom: 40px;
      opacity: 0;
    }
    40% {
      bottom: 70px;
      opacity: 0.5;
    }
    80% {
      bottom: 80px;
      opacity: 0.3;
    }
    100% {
      bottom: 80px;
      opacity: 0;
    }
  }
  .coffee-medium__smoke-one {
    opacity: 0;
    bottom: 50px;
    left: 102px;
    animation: smokeOne 3s 4s linear infinite;
  }
  .coffee-medium__smoke-two {
    opacity: 0;
    bottom: 70px;
    left: 118px;
    animation: smokeTwo 3s 5s linear infinite;
  }
  .coffee-medium__smoke-three {
    opacity: 0;
    bottom: 65px;
    right: 118px;
    animation: smokeTwo 3s 6s linear infinite;
  }
  .coffee-medium__smoke-for {
    opacity: 0;
    bottom: 50px;
    right: 102px;
    animation: smokeOne 3s 5s linear infinite;
  }
  .coffee-footer {
    width: 95%;
    height: 15px;
    position: absolute;
    bottom: 25px;
    left: calc(50% - 47.5%);
    background-color: #41bdad;
    border-radius: 10px;
  }
  .coffee-footer::after {
    content: '';
    width: 106%;
    height: 26px;
    position: absolute;
    bottom: -25px;
    left: -8px;
    background-color: #000;
  }

  .loader {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh; /* Prend tout l'écran */
    width: 100vw;
    background-color: #f4f4f4; /* Couleur de fond */
    position: fixed; /* Assure que le loader couvre toute la page */
    z-index: 9999; /* S'assure que le loader est au-dessus de tout */
  }
</style>
