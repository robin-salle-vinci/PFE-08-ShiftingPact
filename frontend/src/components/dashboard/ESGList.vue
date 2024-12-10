<template>
  <div class="container">
    <h1>Questionaires ESG en attente de validation</h1>
    <div class="list" v-for="item in allEsg" :key="item.id">
      <div class="item">
        <span>{{ item.client_information.company_name }}</span>
        <span>{{ new Date(item.date_last_modification).toLocaleDateString('fr-FR') }}</span>
        <div>
          <button @click="handleSeeForm(item.id)">Voir/Editer</button>
          <button @click="handleValidate(item.id)">Valider</button>
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
      const response = await axios.get(
        `${import.meta.env.VITE_API_URL}/modules?state=verification`,
        {
          headers: {
            Authorization: 'Bearer ' + localStorage.getItem('token'),
          },
        },
      )
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

  .list {
    display: flex;
    flex-direction: column;
    /* background-color: blue; */
    width: 80%;
  }

  .item {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    background-color: #dfd4fb;
    border-radius: 10px;
    padding: 10px;
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
