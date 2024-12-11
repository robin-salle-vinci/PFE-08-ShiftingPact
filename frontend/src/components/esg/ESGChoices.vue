<template>
  <div v-if="question.type_response === 'qcm'" class="group">
    <div v-for="choice in question.choices" :key="choice.id" class="choice">
      <ESGRadioChoice
        v-if="choice.value != 'nan'"
        :choice="choice"
        :questionId="question.id"
        :isActive="responseId == choice.id"
      />
    </div>
  </div>

  <div v-if="question.type_response === 'qrm'" class="group">
    <div v-for="choice in question.choices" :key="choice.id" class="choice">
      <ESGCheckboxChoice
        v-if="choice.value != 'nan'"
        :choice="choice"
        :questionId="question.id"
        :isActive="choice.value.includes(responseValue)"
      />
    </div>
  </div>

  <div v-if="question.type_response === 'question ouverte'" class="textarea-container">
    <textarea placeholder="Entrez votre réponse ici" :value="responseValue"></textarea>
  </div>
</template>

<script setup lang="ts">
  import ESGRadioChoice from './ESGRadioChoice.vue'
  import ESGCheckboxChoice from './ESGCheckboxChoice.vue'

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

  .group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }

  .choice {
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
