<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>
  <div v-if="pact?.answers_commitment" class="container">
    <h1>
      Pacte d'engagement du {{ new Date(pact.creation_date).toLocaleDateString('fr-FR') }} de
      {{ pact.client_information.company_name }}
    </h1>
    <div v-for="(answer, key) in pact.answers_commitment" :key="key" class="item">
      <span
        >{{ questions[key].value.replace('XXX', pact.client_information.company_name) }} :
        {{ answer.value }}</span
      >
    </div>
  </div>
  <div v-else class="loading-container">
    <div class="loading"></div>
  </div>
</template>

<script setup lang="ts">
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import type { Pact } from '@/types/Pact'
  import { getToken, getUser } from '@/utils/localstorage'
  import axios from 'axios'
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'

  const route = useRoute()
  const id = Array.isArray(route.params.id) ? route.params.id[0] : route.params.id

  const pact = ref<Pact>()
  const questions = ref<{ value: string }[]>([])
  const user = getUser()

  async function getPact(id: string) {
    await axios
      .get(`${import.meta.env.VITE_API_URL}/questions/only/`, {
        headers: {
          Authorization: 'Bearer ' + getToken(),
        },
      })
      .then((response) => {
        questions.value = response.data
      })

    await axios
      .get(`${import.meta.env.VITE_API_URL}/commitments/module/${id}`, {
        headers: {
          Authorization: 'Bearer ' + getToken(),
        },
      })
      .then((response) => {
        pact.value = response.data

        // Check if the user is the client of the pact
        if (user.role === 'client' && pact.value?.client_information.id_user !== user.id)
          router.push('/')
      })
  }
  getPact(id)

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
  }

  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 85vh;
    padding-bottom: 1%;
    overflow-y: auto;
    box-sizing: border-box;
  }
  .item {
    background-color: #b5cdbf;
    border-radius: 10px;
    padding: 20px;
    margin: 10px;
    width: 35%;
    color: white;
  }

  .container h1 {
    text-align: center;
    margin-bottom: 50px;
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

  .challenge {
    margin-left: 20%;
    margin-right: 20%;
    background-color: #013238;
    border-radius: 10px;
    padding: 30px;
    margin-bottom: 5%;
  }

  .loading-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 85vh;
  }

  .loading {
    border: 15px solid #f3f3f3;
    border-top: 15px solid #013238;
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
