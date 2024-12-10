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

  axios
    .get(`${apiUrl}/questions/`, {
      headers: {
        Authorization: 'Bearer ' + getToken(),
      },
    })
    .then((response) => {
      questions.value = response.data
    })
    .catch((error) => {
      console.error('Erreur lors de la requête:', error)
    })

  const responses = ref([
    {
      id: 'c03ba929-1427-4612-9ec2-c5efa943e616',
      id_client: 1,
      id_question: '550e8400-e29b-41d4-a716-44665544000e',
      comment: "Commentaire de l'utilisateur",
      isEngagement: true,
      value: 'b',
      score_response: 1.0,
      date_modification: '2021-09-01T00:00:00.000Z',
    },
  ])

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
