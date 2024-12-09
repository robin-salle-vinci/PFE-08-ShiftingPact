<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>

  <div v-if="loading"></div>
  <div v-else class="container">
    <!-- <h1>Questionaires ESG de l'entreprise: {{ questionDb.client_information.company_name }}</h1> -->
    <div
      v-if="questionDb && questionDb.challenges"
      v-for="challenge in questionDb.challenges"
      v-bind:key="challenge.id"
    >
      <p>{{ challenge.value }}</p>
      <div v-for="subChallenge in challenge.sub_challenges" v-bind:key="subChallenge.id">
        <p>{{ subChallenge.value }}</p>
        <div
          class="questions-container"
          v-for="question in subChallenge.questions"
          v-bind:key="question.id"
        >
          <QuestionElement :question="question" :reponse="reponse[question.id]" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import QuestionElement from '@/components/dashboard/QuestionElement.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import axios from 'axios'
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'
  const loading = ref(false)

  const route = useRoute()
  const id = route.params.id
  const apiUrl = import.meta.env.VITE_API_URL
  // interface QuestionDb {
  //   id: number
  //   client_information: {
  //     company_name: string
  //   }
  // }

  const questionDb = ref(null)
  const fetchData = async () => {
    const response = await axios.get(`${apiUrl}/questions/`, {
      headers: {
        Authorization: 'Bearer ' + localStorage.getItem('token'),
      },
    })
    questionDb.value = response.data
    loading.value = false
  }

  fetchData()

  const reponse = ref({})
  const fetchReponse = async () => {
    const response = await axios.get(`${apiUrl}/modules/esg/${id}`, {
      headers: {
        Authorization: 'Bearer ' + localStorage.getItem('token'),
      },
    })
    reponse.value = response.data.original_answers
    console.log(reponse.value)
  }

  fetchReponse()

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100vh;
    position: relative;
  }

  .questions-container {
    display: flex;
    flex-direction: column;
    width: 80%;
  }

  .back-button {
    margin: 5%;
    width: 50px;
    height: 50px;
    background-color: #b5cdbf;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-bottom: 20px;
  }

  .arrow-left {
    display: inline-block;
    width: 0;
    height: 0;
    margin-right: 5px;
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
    border-right: 10px solid white;
  }
</style>
