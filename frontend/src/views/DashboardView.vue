<template>
  <HeaderElement />
  <div class="">
    <button @click="handleCreate">Ajouter une entreprise</button>
    <button @click="handleView">Voir les formulaires</button>
  </div>

  <CreateCompany v-if="selectedAction == 'create'" />
  <div v-else>
    <p>View page</p>
  </div>
</template>

<script setup lang="ts">
  import CreateCompany from '@/components/dashboard/CreateCompany.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import { ref } from 'vue'

  const selectedAction = ref('create')

  const handleCreate = () => {
    selectedAction.value = 'create'
  }
  const handleView = () => {
    selectedAction.value = 'view'
  }
</script>

<style scoped></style>
