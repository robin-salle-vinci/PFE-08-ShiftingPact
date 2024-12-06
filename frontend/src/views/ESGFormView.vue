<template>
  <div class="main-container">
    <vue-particles class="particles-background" id="tsparticles" :options="particlesConfig" />

    <div class="progress-bar-container">
      <div class="progress-bar">
        <div class="bar" :style="{ width: progress + '%' }"></div>
        <span class="progress-text">{{ Math.round(progress * 10) / 10 }}%</span>
      </div>
    </div>

    <div class="form-container">
      <div
        v-for="(challenge, challengeName) in groupedQuestions"
        :key="challengeName"
        class="category"
      >
        <div class="category-header" @click="toggleCategory(challengeName)">
          <h3>{{ challengeName }}</h3>
          <div class="category-right-content">
            <div class="category-progress">
              <span :class="getCategoryProgress(challengeName)"></span>
            </div>
            <span class="toggle-arrow" :class="{ open: categoryState[challengeName] }"
              >&#9662;</span
            >
          </div>
        </div>

        <div v-show="categoryState[challengeName]" class="subcategories" ref="subcategoriesref">
          <div
            v-for="(subChallenge, subChallengeName) in challenge"
            :key="subChallengeName"
            class="subcategory"
          >
            <h4>{{ subChallengeName }}</h4>
            <span :class="getSubCategoryProgress(subChallengeName)"></span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, computed } from 'vue'
  import { particlesConfig } from '@/config/particles-config'

  const subcategoriesref = ref(null)

  const responses = ref([
    {
      id: 'c03ba929-1427-4612-9ec2-c5efa943e616',
      id_client: 1,
      id_question: '6116bd17-7885-4444-b275-be7b79f8730f',
      comment: "Commentaire de l'utilisateur",
      isEngagement: false,
      value: '123456',
      score_response: 1.0,
      date_modification: '2021-09-01T00:00:00.000Z',
    },
  ])

  const choices = ref([
    {
      id: '23a59c4f-afc6-47e6-ac22-835def738a76',
      id_question: '0aaf3234-516e-4dd6-8994-e28df9fa6858',
      score_choice: 1.0,
      value: 'a',
    },
    {
      id: '294339f1-16a8-4300-b4dd-6de14b7157d0',
      id_question: '0aaf3234-516e-4dd6-8994-e28df9fa6858',
      score_choice: 1.0,
      value: 'b',
    },
    {
      id: '72f60fb9-ce7b-4d48-9250-2278512221c8',
      id_question: '0aaf3234-516e-4dd6-8994-e28df9fa6858',
      score_choice: 1.0,
      value: 'c',
    },
    {
      id: '1355d6b6-0c61-4533-9189-f4f8cac354ca',
      id_question: 'fffa8818-eb49-4be5-8006-3591ae22395b',
      score_choice: 1.0,
      value: 'a',
    },
    {
      id: 'fbbedf27-d3a6-4eff-81ef-e028aba7caea',
      id_question: 'fffa8818-eb49-4be5-8006-3591ae22395b',
      score_choice: 1.0,
      value: 'b',
    },
    {
      id: 'd1a27447-fc10-4e18-9950-d9fb8c1f7674',
      id_question: '62c652b1-dfdf-447a-95e5-5a3322f271c4',
      score_choice: 1.0,
      value: 'a',
    },
    {
      id: '787dab99-b61b-4ec0-b46c-a8813c33024c',
      id_question: '62c652b1-dfdf-447a-95e5-5a3322f271c4',
      score_choice: 1.0,
      value: 'b',
    },
  ])

  const questions = ref([
    {
      id: '0aaf3234-516e-4dd6-8994-e28df9fa6858',
      challenge: '1. ENERGIE & CARBONE',
      sub_challenge: "1.1. GESTION DE L'ENERGIE",
      template: 'ALL',
      type_response: 'radio',
      value: "Suivez-vous la consommation d'énergie de XXX ?",
    },
    {
      id: '6116bd17-7885-4444-b275-be7b79f8730f',
      challenge: '1. ENERGIE & CARBONE',
      sub_challenge: "1.1. GESTION DE L'ENERGIE",
      template: 'ALL',
      type_response: 'free',
      value:
        "Si vous la suivez, veuillez indiquer votre consommation d'énergie totale des 12 derniers mois (en kWh)",
    },
    {
      id: 'fffa8818-eb49-4be5-8006-3591ae22395b',
      challenge: '1. ENERGIE & CARBONE',
      sub_challenge: '1.2. EMPREINTE CARBONE',
      template: 'WORKERS',
      type_response: 'radio',
      value:
        'Quelle(s) pratique(s) avez-vous mise(s) en place pour limiter votre empreinte carbone ?',
    },
    {
      id: '62c652b1-dfdf-447a-95e5-5a3322f271c4',
      challenge: '2. EAU, MATIERES PREMIERES ET FOURNITURES',
      sub_challenge: '2.1. EAU',
      template: 'FACILITY',
      type_response: 'radio',
      value: "Mesurez-vous la consommation d'eau de XXX ?",
    },
  ])

  const progress = computed(() => {
    if (progress.value === 100) return 100
    return (responses.value.length / questions.value.length) * 100
  })

  interface Question {
    id: string
    challenge: string
    sub_challenge: string
    template: string
    type_response: string
    value: string
  }

  const categoryState = ref<Record<string, boolean>>({})

  const groupedQuestions = computed(() => {
    const grouped: Record<string, Record<string, Question[]>> = {}

    questions.value.forEach((question) => {
      const { challenge, sub_challenge } = question

      if (!grouped[challenge]) {
        grouped[challenge] = {}
        categoryState.value[challenge] = false
      }

      if (!grouped[challenge][sub_challenge]) {
        grouped[challenge][sub_challenge] = []
      }

      grouped[challenge][sub_challenge].push(question)
    })

    return grouped
  })

  const getCategoryProgress = (challenge: string) => {
    const challengeQuestions = questions.value.filter((q) => q.challenge === challenge)
    const totalQuestions = challengeQuestions.length

    const answeredQuestions = responses.value.reduce((count, response) => {
      const question = challengeQuestions.some((q) => q.id === response.id_question)
      return question ? count + 1 : count
    }, 0)

    if (answeredQuestions === totalQuestions) {
      return 'progress-completed'
    } else if (answeredQuestions > 0) {
      return 'progress-in-progress'
    } else {
      return 'progress-not-started'
    }
  }

  const getSubCategoryProgress = (subChallenge: string) => {
    const challengeQuestions = questions.value.filter((q) => q.sub_challenge === subChallenge)
    const totalQuestions = challengeQuestions.length

    const answeredQuestions = responses.value.reduce((count, response) => {
      const question = challengeQuestions.some((q) => q.id === response.id_question)
      return question ? count + 1 : count
    }, 0)

    if (answeredQuestions === totalQuestions) {
      return 'progress-completed'
    } else if (answeredQuestions > 0) {
      return 'progress-in-progress'
    } else {
      return 'progress-not-started'
    }
  }

  // Fonction pour alterner l'état d'ouverture des catégories
  const toggleCategory = (challenge: string) => {
    categoryState.value[challenge] = !categoryState.value[challenge]
  }
</script>

<style>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  body {
    margin: 0;
    padding: 0;
    overflow: hidden;
  }

  .main-container {
    height: 100vh;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: stretch;
    padding: 2% 10% 2% 10%;
  }

  .form-container {
    background: #ffffff;
    border-radius: 4px;
    padding: 30px;
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
    height: 100%;
    overflow-y: auto;
    box-sizing: border-box;
  }

  .progress-bar-container {
    margin-bottom: 30px;
  }

  .progress-bar {
    background: #e0e0e0;
    border-radius: 4px;
    position: relative;
    height: 30px;
    width: 100%;
    overflow: hidden;
  }

  .bar {
    background: #b5cdbf;
    height: 100%;
    border-radius: 4px;
    transition: width 0.5s ease-in-out;
  }

  .progress-text {
    position: absolute;
    color: #013238;
    font-weight: 600;
    font-size: 25px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 2;
  }

  /* Categories and subcategories */
  .category {
    margin-bottom: 15px;
    border-radius: 4px;
  }

  .category-header {
    cursor: pointer;
    font-weight: 600;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #2c3e50;
    color: #ffffff;
    padding: 10px 20px;
    border-radius: 4px;
  }

  .category-header:hover {
    background-color: #34495e;
    transform: scale(1.005);
    transition: transform 0.3s ease;
  }

  .category-header .toggle-arrow {
    font-size: 20px;
    transition: transform 0.3s;
  }

  .category-header .toggle-arrow.open {
    transform: rotate(180deg);
  }

  .category-right-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 5%;
  }

  .category-progress {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .subcategory {
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #f0f4f2;
    padding: 0% 2% 0% 2%;
    border-radius: 4px;
  }

  .subcategories {
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin: 0 10px 0 10px;
    padding: 10px 20px 10px 20px;
    border-end-start-radius: 4px;
    border-end-end-radius: 4px;
    background-color: #ffffff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }

  .particles-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
  }

  .progress-completed {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #c5fddf;
    border-radius: 50%;
    border: 2px solid #b5cdbf;
  }

  .progress-in-progress {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #f0f4f2;
    border-radius: 50%;
    border: 2px solid #8e8e8e;
  }

  .progress-not-started {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #c03a2b84;
    border-radius: 50%;
    border: 2px solid #c0392b;
  }

  .navbar-no-side-popup {
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
  }
</style>
