<template>
  <div class="tab-bar">
    <div
      v-for="tab in tabs"
      :key="tab"
      :class="['tab', { active: selected === tab }]"
      @click="$emit('change', tab)"
    >
      {{ tab }}
    </div>
  </div>
</template>

<script setup lang="ts">
  defineProps({
    selected: String,
  })
  const tabs = ['create', 'view'] // Ajoutez d'autres onglets ici si nécessaire
</script>

<style scoped>
  .tab-bar {
    display: flex;
    gap: 10px;
  }

  .tab {
    padding: 10px 15px;
    border: 1px solid #ddd;
    border-radius: 5px;
    cursor: pointer;
    text-align: center;
  }

  .tab.active {
    background-color: #007bff;
    color: #fff;
    border: none;
  }
</style>
