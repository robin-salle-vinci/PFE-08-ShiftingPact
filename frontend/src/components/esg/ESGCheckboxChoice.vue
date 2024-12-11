<template>
  <input
    type="checkbox"
    :name="questionId"
    :value="choice.value"
    :id="`choice-${choice.id}-${questionId}`"
    :id_choice="choice.id"
    :checked="isActive"
  />
  <label :for="`choice-${choice.id}-${questionId}`">
    {{ choice.value }}
  </label>
</template>

<script setup lang="ts">
  const { questionId, choice, isActive } = defineProps({
    questionId: {
      type: String,
      default: '',
    },
    choice: {
      type: Object,
      default: () => ({}),
    },
    isActive: {
      type: Boolean,
      default: false,
    },
  })
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  input[type='checkbox'] {
    display: none;
  }

  label {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 10px 15px;
    font-size: 16px;
    cursor: pointer;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 5px;
    transition: all 0.3s;
    text-align: center;
    user-select: none;
    max-width: 100%;
    word-wrap: break-word;
  }

  [type='checkbox']:checked + label {
    background-color: #013238;
    color: white;
    border-color: #013238;
    box-shadow: 0 0 5px #b5cdbf;
  }

  label:hover {
    border-color: #013238;
    background-color: #0132380c;
    transform: scale(1.02);
    transition: transform 0.3s ease;
  }
</style>
