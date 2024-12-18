<script setup lang="ts">
  import type { Esg } from '@/types/Esg'

  defineProps<{
    esgElement: Array<Esg>
    title: string
    onlySee: boolean
    seePact: boolean
    dontValidate: boolean
    handleSeeEditForm: (payload: MouseEvent, id: string) => void
    handleValidate?: (payload: MouseEvent, id: string) => void
    handleSeePactForm?: (payload: MouseEvent, id: string) => void
    handleSeeScore?: (payload: MouseEvent, id: string) => void
  }>()
</script>

<template>
  <div class="container">
    <h1>{{ title }}</h1>
    <div class="list" v-for="item in esgElement" :key="item.id">
      <div class="item">
        <span class="company-name">{{ item.client_information.company_name }}</span>
        <span class="modification-date">{{
          new Date(item.date_last_modification).toLocaleDateString('fr-FR')
        }}</span>
        <div class="actions">
          <button @click="(event) => handleSeeEditForm(event, item.id)">
            {{ onlySee ? 'Voir' : 'Voir/Éditer' }}
          </button>
          <button
            v-if="!dontValidate"
            @click="(event) => handleValidate && handleValidate(event, item.id)"
          >
            Valider
          </button>
          <button
            v-if="seePact"
            @click="(event) => handleSeePactForm && handleSeePactForm(event, item.id)"
          >
            Voir Pacte
          </button>
          <button
            v-if="seePact"
            @click="(event) => handleSeeScore && handleSeeScore(event, item.id)"
          >
            Voir Score
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
  * {
    font-family: Arial, sans-serif;
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
    background-color: #b5cdbf;
    color: white;
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
    background-color: white;
    color: #013238;
    cursor: pointer;
    transition: background-color 0.3s;
  }

  button:hover {
    background-color: rgb(231, 231, 231);
    transform: scale(1.03);
    transition: transform 0.3s ease;
  }
</style>
