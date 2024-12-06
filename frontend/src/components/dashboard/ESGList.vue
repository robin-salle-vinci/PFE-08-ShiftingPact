<template>
  <div class="container">
    <h1>Questionaires ESG en attente de validation</h1>
    <div class="list" v-for="item in fakeESG" :key="item.idClient">
      <div class="item">
        <span>{{ item.companyName }}</span>
        <span>{{ item.date }}</span>
        <div>
          <button @click="handleSeeForm(item.esgId)">Voir/Editer</button>
          <button @click="handleValidate(item.esgId)">Valider</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import router from '@/router'
  import { ref } from 'vue'

  const fakeESG = ref([
    {
      idClient: 1,
      companyName: 'Company Name',
      esgScore: 80,
      date: '2021-10-10',
      esgId: 1,
    },
    {
      idClient: 2,
      companyName: 'Company Name',
      esgScore: 80,
      date: '2021-10-10',
      esgId: 2,
    },
    {
      idClient: 3,
      companyName: 'Company Name',
      esgScore: 80,
      date: '2021-10-10',
      esgId: 3,
    },
  ])
  // TODO request to get ESG list

  const handleSeeForm = (_esgId: number) => {
    // TODO request to see ESG form
    console.log(_esgId)
    console.log('see form')
    // go to page form with _esgId
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
