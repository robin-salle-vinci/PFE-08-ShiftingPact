<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>

  <div class="container">
    <h1>Questionaires de l'entreprise NOM_ENTREPRISE {{ id }}</h1>

    <div class="questions-container" v-for="(question, index) in questions" :key="index">
      <QuestionElement :question="question" />
    </div>
  </div>
</template>

<script setup lang="ts">
  import QuestionElement from '@/components/dashboard/QuestionElement.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'

  const route = useRoute()
  const id = route.params.id

  const questions = ref([
    {
      question: 'Combien de cheval on peux mettre dans un appartement ?',
      reponse: 'Reponse 1',
      commentaire: 'Commentaire 1',
      isEngagement: true,
      value: '400',
      choix: ['oui', 'non'],
    },
  ])

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100vh;
    position: relative;
  }

  .questions-container {
    display: flex;
    flex-direction: column;
    width: 80%;
  }

  .back-button {
    margin: 5%;
    width: 50px;
    height: 50px;
    background-color: #b5cdbf;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-bottom: 20px;
  }

  .arrow-left {
    display: inline-block;
    width: 0;
    height: 0;
    margin-right: 5px;
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
    border-right: 10px solid white;
  }
</style>
