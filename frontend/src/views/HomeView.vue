<template>
  <main>
    <h1>Home</h1>
    <p>Welcome, {{ username }} -- > {{ role }}</p>
  </main>
</template>

<script setup lang="ts">
  import { getUser } from '@/utils/localstorage'
  import { ref } from 'vue'
  const user = getUser()
  const username = ref<string>(user.username)
  const role = ref<string>(user.role)
</script>
