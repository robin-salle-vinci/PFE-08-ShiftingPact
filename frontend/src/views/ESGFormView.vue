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
      :idESG="idESG"
      :isSubChallengeSelected="selectedSubChallenge.length !== 0 ? true : false"
      :onSubChallengeSelected="handleSubChallengeSelected"
    />
  </div>
</template>

<script setup lang="ts">
  import ESGFormList from '@/components/esg/ESGFormList.vue'
  import ESGFormQuestions from '@/components/esg/ESGFormQuestions.vue'
  import type { Answer } from '@/types/Answer.ts'
  import type { Question } from '@/types/Question.ts'
  import axios from 'axios'
  import { ref } from 'vue'
  import { getToken } from '../utils/localstorage'

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

    responses.value = response.data.original_answers
    idESG.value = response.data.id
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
