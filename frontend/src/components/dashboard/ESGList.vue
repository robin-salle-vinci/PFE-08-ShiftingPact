<template>
  <ListElement
    v-if="esgVerification.length > 0"
    class="title"
    :title="'Questionnaires ESG en attente de vérification'"
    :esgElement="esgVerification"
    :handleSeeEditForm="handleSeeEditForm"
    :handleValidate="handleValidate"
    :seePact="false"
    :onlySee="false"
    :dontValidate="false"
  />

  <ListElement
    v-if="esgOpen.length > 0"
    class="title"
    :title="'Questionnaires ESG ouverts'"
    :esgElement="esgOpen"
    :handleSeeEditForm="handleSeeEditForm"
    :handleValidate="handleValidate"
    :seePact="false"
    :onlySee="false"
    :dontValidate="true"
  />

  <ListElement
    v-if="esgValidated.length > 0"
    class="title"
    :title="'Questionnaires ESG validés'"
    :esgElement="esgValidated"
    :handleSeeEditForm="handleSeeEditForm"
    :handleSeePactForm="handleSeePactForm"
    :handleSeeScore="handleSeeScore"
    :seePact="true"
    :onlySee="true"
    :dontValidate="true"
  />
</template>

<script setup lang="ts">
  import router from '@/router'
  import type { Esg } from '@/types/Esg'
  import axios from 'axios'
  import { ref } from 'vue'
  import ListElement from './ListeElement.vue'

  const fetchESGList = async () => {
    try {
      const response = await axios.get(`${import.meta.env.VITE_API_URL}/modules`, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      esgOpen.value = response.data.filter((esg: Esg) => esg.state === 'open')
      esgVerification.value = response.data.filter((esg: Esg) => esg.state === 'verification')
      esgValidated.value = response.data.filter((esg: Esg) => esg.state === 'validated')
    } catch (error) {
      console.error(error)
    }
  }
  fetchESGList()

  const esgVerification = ref<Esg[]>([])
  const esgOpen = ref<Esg[]>([])
  const esgValidated = ref<Esg[]>([])

  const handleSeeEditForm = (event: MouseEvent, _esgId: string) => {
    event.preventDefault()
    router.push(`/esg/${_esgId}`)
  }

  const handleValidate = (event: MouseEvent, _esgId: string) => {
    axios
      .patch(`${import.meta.env.VITE_API_URL}/modules/state/${_esgId}?newState=validated`, null, {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      })
      .catch((error) => {
        console.error(error)
      })
      .finally(() => {
        window.location.reload()
      })
  }
  const handleSeePactForm = (event: MouseEvent, _esgId: string) => {
    event.preventDefault()
    router.push(`/pact/${_esgId}`)
  }

  const handleSeeScore = (event: MouseEvent, _esgId: string) => {
    event.preventDefault()
    router.push(`/scores/${_esgId}`)
  }
</script>

<style scoped>
  * {
    font-family: Arial, sans-serif;
  }

  .title {
    color: #013238;
  }
</style>
