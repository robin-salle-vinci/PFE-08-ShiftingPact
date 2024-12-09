<template>
  <div v-if="question.type_response === 'radio'" class="radio-group">
    <div
      v-for="choice in choices.filter((c: Choice) => c.id_question === question.id)"
      :key="choice.id"
      class="radio-choice"
    >
      <ESGRadioChoice :choice="choice" :questionId="question.id" :responseValue="responseValue" />
    </div>
  </div>

  <div v-if="question.type_response === 'free'" class="textarea-container">
    <textarea placeholder="Entrez votre réponse ici"></textarea>
  </div>
</template>

<script setup lang="ts">
  import ESGRadioChoice from './ESGRadioChoice.vue'

  const { question, choices, responseValue } = defineProps({
    question: {
      type: Object,
      default: () => ({}),
    },
    choices: {
      type: Object,
      default: () => ({}),
    },
    responseValue: {
      type: String,
      default: '',
    },
  })

  interface Choice {
    id: string
    id_question: string
    score_choice: number
    value: string
  }
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  .radio-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }

  .radio-choice {
    position: relative;
  }

  .textarea-container textarea {
    width: 100%;
    max-width: 500px;
    height: 100px;
    font-size: 16px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    resize: none;
    outline: none;
    transition: border-color 0.3s;
  }

  .textarea-container textarea:focus {
    border-color: #013238;
    box-shadow: 0 0 5px #b5cdbf;
  }
</style>
