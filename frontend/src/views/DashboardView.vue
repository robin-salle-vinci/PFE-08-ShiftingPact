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
  * {
    font-family: Arial, sans-serif;
  }

  .particles-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
  }

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
    background-color: #013238;
    border: 1px solid #b5cdbf;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  button:hover {
    border-color: #013238;
    background-color: #01272c;
    transform: scale(1.02);
    transition: transform 0.3s ease;
  }
</style>
