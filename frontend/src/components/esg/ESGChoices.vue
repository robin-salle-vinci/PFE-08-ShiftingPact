<template>
  <div v-if="question.type_response === 'radio'" class="radio-group">
    <div
      v-for="choice in choices.filter((c: Choice) => c.id_question === question.id)"
      :key="choice.id"
      class="radio-choice"
    >
      <label>
        <input type="radio" :name="question.id" :value="choice.value" />
        {{ choice.value }}
      </label>
    </div>
  </div>

  <div v-if="question.type_response === 'free'" class="textarea-container">
    <textarea placeholder="Entrez votre réponse ici"></textarea>
  </div>
</template>

<script setup lang="ts">
  const { question, choices } = defineProps({
    question: {
      type: Object,
      default: () => ({}),
    },
    choices: {
      type: Object,
      default: () => ({}),
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
    flex-direction: column;
    gap: 10px;
  }

  .radio-choice label {
    display: flex;
    align-items: center;
    font-size: 16px;
    cursor: pointer;
  }

  .radio-choice input[type='radio'] {
    margin-right: 10px;
    accent-color: #007bff;
  }

  .textarea-container textarea {
    width: 100%;
    max-width: 500px;
    height: 150px;
    font-size: 16px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    resize: none;
    outline: none;
    transition: border-color 0.3s;
  }

  .textarea-container textarea:focus {
    border-color: #007bff;
    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
  }

  /* Transition et animation */
  .radio-choice input[type='radio']:hover + label,
  .textarea-container textarea:hover {
    border-color: #0056b3;
  }
</style>
