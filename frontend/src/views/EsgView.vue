<template>
  <HeaderElement />
  <button @click="handleBack">back</button>
  <div class="outer-container">
    <div class="container">
      <div v-for="(question, index) in questions" :key="index" class="question">
        <span>{{ question.text }}</span>

        <form action="">
          <input type="text" v-model="question.response" />
        </form>

        <div>
          <button @click="modifyQuestion(index)">Modifier</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  import { ref } from 'vue'
  //import { useRoute } from 'vue-router'

  //const route = useRoute()
  // const id = route.params.id

  const questions = ref([
    { text: 'loremlroororororororororoorororo', response: 'reponse client 1' },
    { text: 'loremlroororororororororoorororo', response: 'reponse client 2' },
    { text: 'loremlroororororororororoorororo', response: 'reponse client 3' },
  ])

  const handleBack = () => {
    router.push('/')
  }

  const modifyQuestion = (index: number) => {
    const answerModified = questions.value[index].response
    console.log(answerModified)
  }
</script>

<style scoped>
  .outer-container {
    display: flex;
    justify-content: center;
    height: 100vh;
  }

  .container {
    display: flex;
    flex-direction: column;
    width: 80%;
    background-color: aqua;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }

  .question {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    padding: 10px;
    border-bottom: 2px solid black;
  }
</style>
