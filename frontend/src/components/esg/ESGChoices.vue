<template>
  <div v-if="question.type_response === 'qcm'" class="radio-group">
    <div v-for="choice in question.choices" :key="choice.id" class="radio-choice">
      <ESGRadioChoice
        :choice="choice"
        :questionId="question.id"
        :isActive="responseId == choice.id"
      />
    </div>
  </div>

  <div v-if="question.type_response === 'open'" class="textarea-container">
    <textarea placeholder="Entrez votre réponse ici" :value="responseValue"></textarea>
  </div>
</template>

<script setup lang="ts">
  import ESGRadioChoice from './ESGRadioChoice.vue'

  const { question, responseId, responseValue } = defineProps({
    question: {
      type: Object,
      default: () => ({}),
    },
    responseId: {
      type: String,
      default: '() => ({})',
    },
    responseValue: {
      type: String,
      default: '',
    },
  })
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
