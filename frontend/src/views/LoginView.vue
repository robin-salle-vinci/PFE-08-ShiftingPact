<template>
  <div class="login-container">
    <vue-particles class="particles-background" id="tsparticles" :options="options" />

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
  import { ref } from 'vue'
  import axios from 'axios'
  import { useRouter } from 'vue-router'
  import type { AxiosResponse, AxiosError } from 'axios'

  const router = useRouter()

  const username = ref<string>('')
  const password = ref<string>('')
  const errorMessage = ref<string | null>(null)

  const handleLogin = () => {
    console.log(username.value, password.value)
    axios
      .post('http://localhost:8000/users/login/', {
        username: username.value,
        password: password.value,
      })
      .then((response: AxiosResponse) => {
        errorMessage.value = null
        const token = response.data.token
        if(token) {
            localStorage.setItem("token", token);
            localStorage.setItem("user", JSON.stringify(response.data.user))
            router.push('/')
        } else {
          console.error("No tokens provided in the response.");
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

  const options = {
    background: {
      color: {
        value: '#fafafa',
      },
    },
    fpsLimit: 120,
    interactivity: {
      modes: {
        bubble: {
          distance: 400,
          duration: 2,
          opacity: 0.8,
          size: 40,
        },
        push: {
          quantity: 4,
        },
        repulse: {
          distance: 200,
          duration: 0.4,
        },
      },
    },
    particles: {
      color: {
        value: '#013238',
      },
      links: {
        color: '#013238',
        distance: 150,
        enable: true,
        opacity: 0.5,
        width: 1,
      },
      move: {
        direction: 'none',
        enable: true,
        outModes: 'bounce',
        random: false,
        speed: 2,
        straight: false,
      },
      number: {
        density: {
          enable: true,
        },
        value: 100,
      },
      opacity: {
        value: 0.5,
      },
      shape: {
        type: 'circle',
      },
      size: {
        value: { min: 1, max: 5 },
      },
    },
    detectRetina: false,
  }
</script>

<style scoped>
  * {
    font-family: Arial, sans-serif; /* Replace with your desired font */
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
