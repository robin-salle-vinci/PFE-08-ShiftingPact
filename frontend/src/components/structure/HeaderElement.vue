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
    // rerednder the page
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

  .profils-info button {
    color: #013238; /* Text color */
    background-color: #fde791; /* Background color */
    font-size: 0.8em;
    text-decoration: none;
    font-weight: 600;
    border: 2px solid #013238;
    border-radius: 5px;
    padding: 5px 10px; /* Add some padding for better appearance */
    transition: all 0.3s ease; /* Smooth transition for hover effect */
  }

  /* Hover effect */
  .profils-info button:hover {
    background-color: #c5fddf; /* New background color on hover */
    color: #013238; /* Text color on hover */
    border-color: #c5fddf; /* Border color matches background */
  }
</style>
