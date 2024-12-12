<script setup lang="ts">
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import type { Pact } from '@/types/Pact'
  import { getToken } from '@/utils/localstorage'
  import axios from 'axios'
  import { ref } from 'vue'

  const allPacts = ref<Pact[]>([])

  axios
    .get(`${import.meta.env.VITE_API_URL}/commitments/client/`, {
      headers: {
        Authorization: `Bearer ${getToken()}`,
      },
    })
    .then((response) => {
      allPacts.value = response.data
    })

  const handleSeePact = (id: string) => {
    router.push(`/pact/${id}`)
  }
  const handleSeeScore = (id: string) => {
    router.push(`/scores/${id}`)
  }
</script>

<template>
  <HeaderElement />
  <div class="container" v-if="allPacts.length > 0">
    <h1>List Pacts</h1>
    <div class="list" v-for="item in allPacts" :key="item.id">
      <div class="item">
        <span class="company-name">{{ item.client_information.company_name }}</span>
        <span class="modification-date">{{
          new Date(item.creation_date).toLocaleDateString('fr-FR')
        }}</span>
        <div class="actions">
          <button @click="handleSeePact(item.id_module_esg)">Voir mais engangment</button>
          <button @click="handleSeeScore(item.id_module_esg)">Voir mon score</button>
        </div>
      </div>
    </div>
  </div>
  <div v-else class="container">
    <h1>Aucun pacte d'engagement</h1>
  </div>
</template>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
  }

  .container {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 20px;
  }
  .container h1 {
    margin-top: 2%;
    margin-bottom: 0px;
    text-align: center;
  }

  .list {
    display: flex;
    flex-direction: column;
    width: 50%;
  }

  .item {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    background-color: #dfd4fb;
    border-radius: 10px;
    padding: 10px;
    width: 100%;
    box-sizing: border-box;
  }

  .company-name {
    flex: 1;
  }

  .modification-date {
    flex: 1;
    text-align: center;
  }

  .actions {
    flex: 1;
    display: flex;
    justify-content: flex-end;
  }

  button {
    margin-left: 10px;
    padding: 5px 10px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    background-color: #b5cdbf;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
  }
</style>
