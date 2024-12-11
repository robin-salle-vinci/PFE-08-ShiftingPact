<template>
  <div
    class="main-container-esg-form-view"
    :class="selectedSubChallenge.length != 0 ? 'main-container-esg-form-view-flex' : null"
  >
    <ESGFormQuestions
      v-if="selectedSubChallenge.length !== 0"
      :responses="responses"
      :idESG="idESG"
      :selectedChallengeId="selectedChallengeId"
      :selectedSubChallengeId="selectedSubChallengeId"
      :selectedSubChallenge="selectedSubChallenge"
    />
    <ESGFormList
      :questions="questions"
      :responses="responses"
      :isSubChallengeSelected="selectedSubChallenge.length !== 0 ? true : false"
      :onSubChallengeSelected="handleSubChallengeSelected"
    />
  </div>
</template>

<script setup lang="ts">
  import { ref } from 'vue'
  import axios from 'axios'
  import { getToken } from '../utils/localstorage'
  import ESGFormList from '@/components/esg/ESGFormList.vue'
  import ESGFormQuestions from '@/components/esg/ESGFormQuestions.vue'
  import type { Question } from '@/types/Question.ts'
  import type { Answer } from '@/types/Response.ts'

  const apiUrl = import.meta.env.VITE_API_URL

  const idESG = ref('')
  const selectedChallengeId = ref('')
  const selectedSubChallengeId = ref('')
  const selectedSubChallenge = ref<Question[]>([])

  const questions = ref({})
  const responses = ref<Answer[]>([])

  async function getQuestions() {
    const response = await axios.get(`${apiUrl}/questions/`, {
      headers: {
        Authorization: 'Bearer ' + getToken(),
      },
    })

    questions.value = response.data
  }

  async function getResponses() {
    const response = await axios.get(`${apiUrl}/modules/esg/`, {
      headers: {
        Authorization: 'Bearer ' + getToken(),
      },
    })

    response.data.original_answers = Object.keys(response.data.original_answers)
    responses.value = response.data.original_answers.map((answer: Answer) => ({
      id: answer.id,
      challenge: answer.challenge,
      sub_challenge: answer.sub_challenge,
      id_choice: answer.id_choice,
      value: answer.value,
      commentary: answer.commentary,
      score: answer.score,
      is_commitment: answer.is_commitment,
      score_response: answer.score_response,
    }))

    idESG.value = response.data.id
    console.log(response.data)
  }

  getQuestions()
  getResponses()

  function handleSubChallengeSelected(
    question: Array<Question>,
    challengeId: string,
    subChallengeId: string,
  ) {
    if (selectedSubChallenge.value === question) return
    const radios = document.querySelectorAll('input[type="radio"]')

    radios.forEach((radio) => {
      ;(radio as HTMLInputElement).checked = false
    })

    selectedSubChallenge.value = question
    selectedChallengeId.value = challengeId
    selectedSubChallengeId.value = subChallengeId
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
