<template>
  <div
    class="main-container-esg-form-view"
    :class="selectedSubChallenge ? 'main-container-esg-form-view-flex' : null"
  >
    <ESGFormQuestions
      v-if="selectedSubChallenge"
      :responses="responses"
      :choices="choices"
      :questions="questions"
      :groupedQuestions="groupedQuestions"
      :selectedSubChallenge="selectedSubChallenge"
    />
    <ESGFormList
      :responses="responses"
      :questions="questions"
      :groupedQuestions="groupedQuestions"
      :selectedSubChallenge="selectedSubChallenge"
      :onSubChallengeSelected="handleSubChallengeSelected"
    />
  </div>
</template>

<script setup lang="ts">
  import { ref, computed } from 'vue'
  import ESGFormList from '@/components/esg/ESGFormList.vue'
  import ESGFormQuestions from '@/components/esg/ESGFormQuestions.vue'

  const selectedSubChallenge = ref<object | null>(null)

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

  interface Question {
    id: string
    challenge: string
    sub_challenge: string
    template: string
    type_response: string
    value: string
  }

  const groupedQuestions = computed(() => {
    const grouped: Record<string, Record<string, Question[]>> = {}

    questions.value.forEach((question: Question) => {
      const { challenge, sub_challenge } = question

      if (!grouped[challenge]) {
        grouped[challenge] = {}
      }

      if (!grouped[challenge][sub_challenge]) {
        grouped[challenge][sub_challenge] = []
      }

      grouped[challenge][sub_challenge].push(question)
    })

    return grouped
  })

  function handleSubChallengeSelected(question: object) {
    selectedSubChallenge.value = question
  }
</script>

<style scoped>
  body {
    margin: 0px;
    padding: 0px;
    overflow: hidden;
  }

  .main-container-esg-form-view {
    margin: 0;
    padding: 0;
  }

  .main-container-esg-form-view-flex {
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
  }
</style>
