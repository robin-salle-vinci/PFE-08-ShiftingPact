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
      :canAnswer="canAnswer"
      :addOneAnswer="addOneAnswer"
    />
    <ESGFormList
      :questions="questions"
      :responses="responses"
      :idESG="idESG"
      :isSubChallengeSelected="selectedSubChallenge.length !== 0 ? true : false"
      :onSubChallengeSelected="handleSubChallengeSelected"
      :canAnswer="canAnswer"
    />
  </div>
</template>

<script setup lang="ts">
  import ESGFormList from '@/components/esg/ESGFormList.vue'
  import ESGFormQuestions from '@/components/esg/ESGFormQuestions.vue'
  import type { Answer } from '@/types/Answer.ts'
  import type { Challenge } from '@/types/Challenge'
  import type { Question } from '@/types/Question.ts'
  import { getToken, getUser } from '@/utils/localstorage'
  import axios from 'axios'
  import { ref } from 'vue'

  const apiUrl = import.meta.env.VITE_API_URL
  const client = getUser()

  const idESG = ref('')
  const selectedChallengeId = ref('')
  const selectedSubChallengeId = ref('')
  const selectedSubChallenge = ref<Question[]>([])

  const questions = ref({})
  const responses = ref<{ [key: string]: Answer }>({})

  async function getQuestions() {
    const response = await axios.get(`${apiUrl}/questions/`, {
      headers: {
        Authorization: 'Bearer ' + getToken(),
      },
    })

    questions.value = sortAll(response.data)
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

  function addOneAnswer(questionId: string, answer: Answer) {
    responses.value[questionId] = answer
  }

  const canAnswer = (question: Question) => {
    switch (question.template) {
      case 'ALL':
        return true

      case 'OWNED FACILITY':
        return client.ownedFacility

      case 'FACILITY':
        return client.ownedFacility

      case 'WORKERS':
        return Number(client.numberWorkers) > 0

      case 'PRODUITS':
        return client.serviceOrProduct == 'product'

      case 'SERVICES':
        return client.serviceOrProduct == 'service'

      default:
        return false
    }
  }

  function sortAll(data: { challenges: Challenge[] }) {
    data.challenges.sort((a: Challenge, b: Challenge) => a.index_challenge - b.index_challenge)

    data.challenges.forEach((challenge: Challenge) => {
      challenge.sub_challenges.sort((a, b) => a.index_sub_challenge - b.index_sub_challenge)

      challenge.sub_challenges.forEach((subChallenge) => {
        subChallenge.questions.sort((a, b) => Number(a.index_question) - Number(b.index_question))

        subChallenge.questions.forEach((question) => {
          question.choices.sort((a, b) => Number(a.index_choice) - Number(b.index_choice))
        })
      })
    })

    return data
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
