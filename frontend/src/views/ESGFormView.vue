<template>
  <div
    class="main-container-esg-form-view"
    :class="selectedSubChallenge ? 'main-container-esg-form-view-flex' : null"
  >
    <ESGFormQuestions
      v-if="selectedSubChallenge"
      :responses="responses"
      :selectedSubChallenge="selectedSubChallenge"
    />
    <ESGFormList
      :questions="questions"
      :responses="responses"
      :isSubChallengeSelected="selectedSubChallenge ? true : false"
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

  const apiUrl = import.meta.env.VITE_API_URL

  const selectedSubChallenge = ref<object | null>(null)

  const questions = ref([])
  const responses = ref([])

  async function createModule() {
    const response = await axios.post(`${apiUrl}/modules/create/`, {
      headers: {
        Authorization: 'Bearer ' + getToken(),
        Test: 'test',
      },
    })

    console.log(response.data)
    responses.value = response.data
  }

  createModule()

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

    console.log(response.data)
    responses.value = response.data
  }

  getQuestions()
  // getResponses()

  function handleSubChallengeSelected(question: object) {
    if (selectedSubChallenge.value === question) return
    const radios = document.querySelectorAll('input[type="radio"]')

    radios.forEach((radio) => {
      ;(radio as HTMLInputElement).checked = false
    })

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
