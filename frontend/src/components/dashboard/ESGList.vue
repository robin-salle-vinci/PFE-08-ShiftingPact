<template>
  <div class="container">
    <h1>Questionnaires ESG en attente de vérification</h1>
    <div
      class="list"
      v-for="item in allEsg.filter((esg) => esg.state === 'verification')"
      :key="item.id"
    >
      <div class="item">
        <span class="company-name">{{ item.client_information.company_name }}</span>
        <span class="modification-date">{{
          new Date(item.date_last_modification).toLocaleDateString('fr-FR')
        }}</span>
        <div class="actions">
          <button @click="handleSeeForm(item.id)">Voir/Éditer</button>
          <button @click="handleValidate(item.id)">Valider</button>
        </div>
      </div>
    </div>
  </div>
  <div class="container">
    <h1>Questionnaires ESG ouverts</h1>
    <div class="list" v-for="item in allEsg.filter((esg) => esg.state === 'open')" :key="item.id">
      <div class="item">
        <span class="company-name">{{ item.client_information.company_name }}</span>
        <span class="modification-date">{{
          new Date(item.date_last_modification).toLocaleDateString('fr-FR')
        }}</span>
        <div class="actions">
          <button @click="handleSeeForm(item.id)">Voir/Éditer</button>
        </div>
      </div>
    </div>
  </div>
  <div class="container">
    <h1>Questionnaires ESG validés</h1>
    <div
      class="list"
      v-for="item in allEsg.filter((esg) => esg.state === 'validated')"
      :key="item.id"
    >
      <div class="item">
        <span class="company-name">{{ item.client_information.company_name }}</span>
        <span class="modification-date">{{
          new Date(item.date_last_modification).toLocaleDateString('fr-FR')
        }}</span>
        <div class="actions">
          <button @click="handleSeeForm(item.id)">Voir</button>
          <button>Voir le pacte d'engagement</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import router from '@/router'
  import type { Esg } from '@/types/Esg'
  import axios from 'axios'
  import { ref } from 'vue'

  const allEsg = ref<Esg[]>([])

  const fetchESGList = async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_API_URL}/modules`, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      allEsg.value = response.data
    } catch (error) {
      console.error(error)
    }
  }
  fetchESGList()

  const handleSeeForm = (_esgId: number) => {
    router.push(`/esg/${_esgId}`)
  }

  const handleValidate = (_esgId: number) => {
    axios
      .patch(`${import.meta.env.VITE_API_URL}/modules/state/${_esgId}?newState=validated`, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      .catch((error) => {
        console.error(error)
      })
  }
</script>

<style scoped>
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
