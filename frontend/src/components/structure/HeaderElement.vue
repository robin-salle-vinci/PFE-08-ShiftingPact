<template>
  <header class="topbar">
    <div class="logo">
      <img src="@/assets/logo_shiftingpact_verteau_blanc.png" alt="Logo" />
    </div>

    <div class="profil">
      <img src="@/assets/profils.png" alt="profil" />
      <div class="profils-info">
        <span>{{ username }}</span>
        <a @click="handleLogout">se deconnecter</a>
      </div>
    </div>
  </header>
</template>

<script setup lang="ts">
  import router from '@/router'
  import { clearStorage, getUser } from '@/utils/localstorage'
  import { ref } from 'vue'
  const username = ref<string>('')

  username.value = getUser().username
  const handleLogout = () => {
    clearStorage()
    router.push('/')
  }
</script>

<style scoped>
  .topbar {
    background-color: #013238;
    display: flex;
    justify-content: space-between;
    height: 100px;
    width: auto;
    padding: 1%;
  }

  /* topbar left part */
  .logo img {
    width: auto;
    height: 100%;
  }

  /* topbar right part */
  .profil {
    display: flex;
    justify-content: center;

    align-items: center;
    width: auto;
    height: auto;
  }

  .profil img {
    width: auto;
    height: 85%;
  }
  .profils-info {
    display: flex;
    flex-direction: column;
    margin-left: 2%;
  }
  .profils-info span {
    color: #c5fddf;
    font-size: 1.2em;
  }

  .profils-info a {
    color: #fde791;
    font-size: 0.8em;
    text-decoration: none;
    font-weight: 900;
  }
</style>
