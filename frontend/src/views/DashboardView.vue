<template>
  <HeaderElement />
  <main>
    <div class="menu">
      <button @click="handleView">Voir les questionaires ESG</button>
      <button @click="handleCreate">Ajouter une entreprise</button>
    </div>

    <CreateCompany v-if="selectedAction == 'create'" />
    <ESGList v-else-if="selectedAction == 'view'" />
  </main>
</template>

<script setup lang="ts">
  import CreateCompany from '@/components/dashboard/CreateCompany.vue'
  import ESGList from '@/components/dashboard/ESGList.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import { ref } from 'vue'

  const selectedAction = ref('view')

  const handleCreate = () => {
    selectedAction.value = 'create'
  }
  const handleView = () => {
    selectedAction.value = 'view'
  }
</script>

<style scoped>
  .menu {
    display: flex;
    flex-direction: row;
    justify-content: start;
    gap: 20px;
    margin: 20px;
  }

  button {
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 5px;
    background-color: #b5cdbf;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  button:hover {
    background-color: #dfd4fb;
  }
</style>
