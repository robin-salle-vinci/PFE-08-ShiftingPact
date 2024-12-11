<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>
  <div v-if="pact?.answers_commitment">
    <div class="container">
      <h1>Engagement</h1>
      <div v-for="commitment in pact.answers_commitment" :key="commitment.id">
        <p>commitment.value</p>
      </div>
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

  async function getPact(id: string) {
    const response = await axios.get(`${import.meta.env.VITE_API_URL}/commitments/module/${id}`, {
      headers: {
        Authorization: 'Bearer ' + localStorage.getItem('token'),
      },
    })
    pact.value = response.data
  }

  getPact(id)

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
