<script setup lang="ts">
  import { defineProps, ref } from 'vue'

  interface Question {
    question: string
    reponse: string
    commentaire: string
    isEngagement: boolean
    value: string
    choix: string[]
  }

  const props = defineProps<{ question: Question }>()

  const questionModel = ref(props.question)

  const handleSave = () => {
    console.log('save')
  }
</script>

<template>
  <div class="card">
    <span>{{ question.question }}</span>
    <form class="inputs">
      <input v-model="questionModel.reponse" type="text" />
      <textarea v-model="questionModel.commentaire" readonly disabled></textarea>
      <span>{{ questionModel.isEngagement }}</span>
      <span>{{ questionModel.value }}</span>
      <span>{{ questionModel.choix }}</span>
      <button @click="handleSave">sauvgarder</button>
    </form>
  </div>
</template>

<style>
  .card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 100%;
    height: 100%;
    background-color: #f5f5f5;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .inputs {
    margin-top: 2%;
    display: flex;
    justify-content: space-around;
    /* same linge flex elem*/

    gap: 10px;
  }
  textarea {
    resize: none;
  }
</style>
