<template>
  <main>
    <h1>Home</h1>
    <p>Welcome, {{ username }} -- > {{ role }}</p>
    <button @click="handleLogout">deconnection</button>
  </main>
</template>

<script setup lang="ts">
  import router from '@/router'
  import { clearStorage, getUser } from '@/utils/localstorage'
  import { ref } from 'vue'
  const user = getUser()
  const username = ref<string>(user.username)
  const role = ref<string>(user.role)

  const handleLogout = () => {
    clearStorage()
    router.push('/login')
  }
</script>
