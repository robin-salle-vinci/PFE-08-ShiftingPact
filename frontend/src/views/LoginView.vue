<template>
  <div class="login-container">
    <vue-particles class="particles-background" id="tsparticles" :options="particlesConfig" />

    <div class="login-card">
      <div class="logo-container">
        <img
          src="@/assets/logo_shiftingpact_vert_verteau.png"
          alt="Logo"
          class="logo"
          draggable="false"
          @contextmenu.prevent
        />
      </div>

      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <input
            type="text"
            id="username"
            v-model="username"
            placeholder="Entrez votre login"
            required
          />
        </div>
        <div class="form-group">
          <input
            type="password"
            id="password"
            v-model="password"
            placeholder="Entrez votre mot de passe"
            required
          />
        </div>
        <button type="submit" class="login-button">Se connecter</button>
      </form>

      <div v-if="errorMessage" class="error-message">
        {{ errorMessage }}
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import type { AxiosError, AxiosResponse } from 'axios'
  import axios from 'axios'
  import { ref } from 'vue'
  import { useRouter } from 'vue-router'
  import { particlesConfig } from '@/config/particles-config'
  import { setToken, setUser } from '../utils/localstorage.ts'

  const apiUrl = import.meta.env.VITE_API_URL

  const router = useRouter()

  const username = ref<string>('')
  const password = ref<string>('')
  const errorMessage = ref<string | null>(null)

  const handleLogin = () => {
    axios
      .post(`${apiUrl}/users/login/`, {
        username: username.value,
        password: password.value,
      })
      .then((response: AxiosResponse) => {
        errorMessage.value = null
        const token = response.data.token
        if (token) {
          setUser(response.data.user)
          setToken(token)
          router.push('/')
        } else {
          console.error('No tokens provided in the response.')
        }
      })
      .catch((error: AxiosError) => {
        if (error.response) {
          if (error.response.status === 401 || error.response.status === 404) {
            errorMessage.value = 'Identifiants invalides, veuillez réessayer.'
          } else {
            errorMessage.value = 'Une erreur inconnue est survenue'
          }
        } else if (error.request) {
          errorMessage.value = 'Le serveur ne répond pas. Vérifiez votre connexion.'
        } else {
          errorMessage.value = 'Une erreur inconnue est survenue'
        }
      })
  }
</script>

<style scoped>
  * {
    font-family: Arial, sans-serif;
  }

  .particles-background {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    z-index: -1;
  }

  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: transparent;
  }

  .login-card {
    background: white;
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 100%;
    max-width: 400px;
  }

  .logo-container {
    margin-bottom: 1rem;
  }

  .logo {
    width: 50%;
    margin-bottom: 10%;
    height: auto;
    user-select: none;
  }

  h1 {
    font-size: 1.5rem;
    margin-bottom: 1.5rem;
    color: #333;
  }

  .form-group {
    margin-bottom: 1.5rem;
    text-align: left;
  }

  input {
    width: 100%;
    padding: 0.8rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
    color: #333;
    box-sizing: border-box;
  }

  .login-button {
    width: 100%;
    padding: 0.8rem;
    border: none;
    background-color: #013238;
    color: white;
    font-size: 1rem;
    border-radius: 4px;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  .login-button:hover {
    background-color: #013238;
    box-shadow: 0 4px 8px #b5cdbf;
    transform: scale(1.05);
    transition: transform 0.3s ease;
  }

  .error-message {
    color: red;
    font-size: 1rem;
    margin-top: 1rem;
    text-align: center;
  }
</style>
