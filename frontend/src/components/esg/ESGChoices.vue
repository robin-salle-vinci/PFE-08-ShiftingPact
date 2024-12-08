<template>
  <div v-if="question.type_response === 'radio'">
    <div v-for="choice in choices.filter((c) => c.id_question === question.id)" :key="choice.id">
      <label>
        <input type="radio" :name="question.id" :value="choice.value" />
        {{ choice.value }}
      </label>
    </div>
  </div>

  <div v-if="question.type_response === 'free'">
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
</script>

<style scoped></style>
