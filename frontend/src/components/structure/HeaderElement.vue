<template>
  <header class="topbar">
    <div class="logo">
      <img src="@/assets/logo_shiftingpact_verteau_blanc.png" alt="Logo" />
    </div>

    <div class="profil">
      <img src="@/assets/profils.png" alt="profil" />
      <div class="profils-info">
        <span>{{ username }}</span>
        <button @click="handleLogout" class="logout">Se déconnecter</button>
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
    // rerender the page
    clearStorage()
    router.push('/')
  }
</script>

<style scoped>
  * {
    font-family: Arial, sans-serif;
  }

  .topbar {
    background-color: #013238;
    display: flex;
    justify-content: space-between;
    height: 15vh;
    overflow: hidden;
    width: auto;
    padding: 1%;
    box-sizing: border-box;
  }

  .logo img {
    width: auto;
    height: 100%;
  }

  .profil {
    display: flex;
    justify-content: right;

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
    align-items: center;
  }
  .profils-info span {
    color: white;
    font-size: 1.2em;
  }

  .profils-info button {
    color: #013238;
    background-color: #ffffff;
    font-size: 0.8em;
    text-decoration: none;
    font-weight: 600;
    border-radius: 5px;
    padding: 5px 10px;
    margin-top: 10px;
  }

  .profils-info button:hover {
    background-color: #d2d2d2;
    color: #013238;
    transform: scale(1.02);
    transition: transform 0.3s ease;
  }
</style>
