<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>

  <div v-if="loading"></div>
  <div v-else class="container">
    <h1>Questionaires ESG de l'entreprise: {{ clientName }}</h1>
    <div
      class="form challenge"
      v-if="questionDb && questionDb.challenges"
      v-for="challenge in questionDb.challenges"
      v-bind:key="challenge.id"
      c
    >
      <h2>{{ challenge.value }}</h2>
      <div
        v-for="subChallenge in challenge.sub_challenges"
        v-bind:key="subChallenge.id"
        class="sub-challenge"
      >
        <h3>{{ subChallenge.value }}</h3>
        <div v-for="question in subChallenge.questions" v-bind:key="question.id" class="question">
          <QuestionElement
            :question="question"
            :clientResponse="clientResponse[question.id]"
            :employeeResponse="employeeResponse ? employeeResponse[question.id] : undefined"
          />
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

  const questionDb = ref(null)
  const clientResponse = ref<Record<string, any>>({})
  const employeeResponse = ref<Record<string, any>>({})
  const clientName = ref('')

  const fetchData = async () => {
    try {
      const [questionsResponse, reponseResponse] = await Promise.all([
        // Get All questions from ESG module
        axios.get(`${apiUrl}/questions/`, {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('token'),
          },
        }),
        // Get All answers from ESG module
        axios.get(`${apiUrl}/modules/esg/${id}`, {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('token'),
          },
        }),
      ])

      questionDb.value = questionsResponse.data
      clientResponse.value = reponseResponse.data.original_answers
      employeeResponse.value = reponseResponse.data.employee_answers
      clientName.value = reponseResponse.data.client_information.company_name
    } catch (error) {
      console.error('Error fetching data:', error)
    } finally {
      loading.value = false
    }
  }

  fetchData()

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  .container h1 {
    text-align: center;
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

  .challenge {
    margin-left: 20%;
    margin-right: 20%;
    background-color: #013238;
    border-radius: 10px;
    padding: 30px;
    margin-bottom: 5%;
  }
  .challenge h2 {
    color: white;
  }

  .sub-challenge {
    margin-left: 2%;
    margin-right: 2%;
    margin-bottom: 2%;
    background-color: #b5cdbf;
    border-radius: 10px;
    padding: 30px;
  }
</style>
