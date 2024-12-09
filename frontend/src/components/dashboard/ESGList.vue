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
  import axios from 'axios'
  import { ref } from 'vue'
  const apiUrl = import.meta.env.VITE_API_URL
  interface ESGItem {
    id: number
    client_information: {
      company_name: string
    }
    date_last_modification: string
  }

  const allEsg = ref<ESGItem[]>([])

  const fetchESGList = async () => {
    try {
      const response = await axios.get(`${apiUrl}/modules?state=validated`, {
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
    // TODO request to validate ESG
    console.log(_esgId)
    console.log('validate')
    // axios
    //   .post('http://localhost:3000/esg/validate', {
    //     esgID: _esgId,
    //   })
    //   .then((response) => {
    //     console.log(response)
    //   })
    //   .catch(() => {})
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
