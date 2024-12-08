<template>
  <div class="main-container-esg-from-questions">
    <div class="form-container-questions">
      <!-- Boucle à travers les questions sélectionnées -->
      <div v-for="(question, questionKey) in selectedSubChallenge" :key="questionKey">
        <h4>{{ question.value }}</h4>
        <ESGChoices :question="question" :choices="choices" />
        <div class="separator"></div>
      </div>

      <!-- Bouton de sauvegarde -->
      <div class="save-button-container">
        <button class="save-button">Sauvegarder</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import ESGChoices from './ESGChoices.vue'

  const { responses, choices, questions, groupedQuestions, selectedSubChallenge } = defineProps({
    responses: {
      type: Object,
      default: () => ({}),
    },
    choices: {
      type: Object,
      default: () => ({}),
    },
    questions: {
      type: Object,
      default: () => ({}),
    },
    groupedQuestions: {
      type: Object,
      default: () => ({}),
    },
    selectedSubChallenge: {
      type: Object,
      default: null,
    },
  })
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  body {
    padding: 0px;
    margin: 0px;
  }

  .main-container-esg-from-questions {
    height: 100vh;
    width: 100%;
    box-sizing: border-box;
    padding: 2% 0% 2% 2%;
  }

  .form-container-questions {
    height: 100%;
    background-color: #e7e7e9;
    border-radius: 4px;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 2%;
  }

  .separator {
    width: 100%;
    height: 2px;
    background-color: #ccc;
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .save-button-container {
    text-align: right;
    margin-top: 20px;
  }

  .save-button {
    background-color: #007bff;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
  }

  .save-button:hover {
    background-color: #0056b3;
  }
</style>
