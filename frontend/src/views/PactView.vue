<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>
  <div v-if="pact?.answers_commitment" class="container">
    <h1>
      Pacte d'engagement du {{ new Date(pact.creation_date).toLocaleDateString('fr-FR') }} de
      {{ pact.client_information.company_name }}
    </h1>
    <div v-for="(answer, key) in pact.answers_commitment" :key="key" class="item">
      <span>{{ questions[key].value }} : {{ answer.value }}</span>
    </div>
  </div>
</template>

<script setup lang="ts">
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import type { Pact } from '@/types/Pact'
  import axios from 'axios'
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'

  const route = useRoute()
  const id = Array.isArray(route.params.id) ? route.params.id[0] : route.params.id

  const pact = ref<Pact>()
  const questions = ref<{ value: string }[]>([])

  async function getPact(id: string) {
    await axios
      .get(`${import.meta.env.VITE_API_URL}/questions/only/`, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      .then((response) => {
        questions.value = response.data
        console.log(questions.value)
      })

    await axios
      .get(`${import.meta.env.VITE_API_URL}/commitments/module/${id}`, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      .then((response) => {
        pact.value = response.data
      })
  }
  getPact(id)

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
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
</style>
