<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>

  <div class="container">
    <div class="sub-container">
      <div v-if="!esgForm || !client" class="loading-container">
        <div class="loading"></div>
      </div>
      <div v-else>
        <h1 class="title-white">Questionaires ESG de l'entreprise: {{ client.company_name }}</h1>
        <div v-for="challenge in esgForm.challenges" v-bind:key="challenge.id" c>
          <h2 class="title-white challenge-name">{{ challenge.value }}</h2>
          <div
            v-for="subChallenge in challenge.sub_challenges"
            v-bind:key="subChallenge.id"
            class="sub-challenge"
          >
            <h3>{{ subChallenge.value }}</h3>
            <div
              v-for="question in subChallenge.questions"
              v-bind:key="question.id"
              class="question"
            >
              <QuestionElement
                :idEsg="idEsg"
                :state="stateEsg"
                :question="question"
                :clientAnswer="clientResponse[question.id]"
                :employeeAnswer="employeeResponse ? employeeResponse[question.id] : undefined"
                :companyName="client.company_name"
                v-if="checkDisplayTemplate(question)"
              />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import QuestionElement from '@/components/dashboard/QuestionElement.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import type { Answer } from '@/types/Answer'
  import type { Challenge } from '@/types/Challenge'
  import type { ClientInformation } from '@/types/ClientInformation'
  import type { Question } from '@/types/Question'
  import axios from 'axios'
  import { onMounted, ref } from 'vue'
  import { useRoute } from 'vue-router'

  const id = useRoute().params.id as string

  const esgForm = ref<{ challenges: Array<Challenge> }>()
  const clientResponse = ref<Record<string, Answer>>({})
  const employeeResponse = ref<Record<string, Answer>>({})
  const client = ref<ClientInformation>()
  const idEsg = ref<string>('')
  const stateEsg = ref<string>('')

  onMounted(async () => {
    try {
      const [questionsResponse, clientEsg] = await Promise.all([
        // Get All questions from ESG module
        axios.get(`${import.meta.env.VITE_API_URL}/questions/`, {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('token'),
          },
        }),
        // Get All answers from ESG module
        axios.get(`${import.meta.env.VITE_API_URL}/modules/${id}`, {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('token'),
          },
        }),
      ])
      // Get esg information
      idEsg.value = clientEsg.data.id
      client.value = clientEsg.data.client_information
      stateEsg.value = clientEsg.data.state

      // Get the questions
      esgForm.value = questionsResponse.data

      // Get the client and employee answers
      clientResponse.value = clientEsg.data.original_answers
      employeeResponse.value = clientEsg.data.modified_answers
    } catch {}
  })

  const checkDisplayTemplate = (question: Question) => {
    switch (question.template) {
      case 'ALL':
        return true

      case 'OWNED FACILITY':
        return client.value?.owned_facility

      case 'WORKERS':
        return Number(client.value?.number_workers) > 0

      case 'PRODUITS':
        return client.value?.service_or_product == 'produit'

      case 'SERVICES':
        return client.value?.service_or_product == 'service'
      default:
        return false
    }
  }

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
  }

  .container {
    height: 85vh;
    width: 100%;
    overflow: hidden;
    padding: 2% 12%;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: stretch;
  }

  .sub-container {
    height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
    background-color: #013238;
    border-radius: 4px;
    padding: 30px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  }

  .container h1 {
    text-align: center;
  }

  .title-white {
    color: white;
  }

  .challenge-name {
    margin-top: 5%;
    margin-left: 2%;
  }

  .back-button {
    position: absolute;
    margin: 2%;
    width: 50px;
    height: 50px;
    background-color: #013238;
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

  .challenge h2 {
    color: white;
  }

  .sub-challenge {
    margin-left: 2%;
    margin-right: 2%;
    margin-bottom: 2%;
    background-color: white;
    border-radius: 10px;
    padding: 30px;
  }

  .loading-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100%;
    width: 100%;
  }

  .loading {
    border: 15px solid white;
    border-top: 15px solid #b5cdbf;
    border-radius: 50%;
    width: 125px;
    height: 125px;
    animation: spin 2s linear infinite;
  }

  @keyframes spin {
    0% {
      transform: rotate(0deg);
    }
    100% {
      transform: rotate(360deg);
    }
  }
</style>
