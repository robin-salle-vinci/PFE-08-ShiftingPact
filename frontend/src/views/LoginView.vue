<template>
  <div class="login-container">
    <div class="login-card">
      <h1>Connexion</h1>
      <form @submit.prevent="handleLogin">
        <div class="form-group">
          <label for="email">Email</label>
          <input
            type="email"
            id="email"
            v-model="email"
            placeholder="Entrez votre email"
            required
          />
        </div>
        <div class="form-group">
          <label for="password">Mot de passe</label>
          <input
            type="password"
            id="password"
            v-model="password"
            placeholder="Entrez votre mot de passe"
            required
          />
        </div>
        <button v-on:click="handleLogin" type="submit" class="login-button">Se connecter</button>
      </form>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref } from 'vue'

  const email = ref('')
  const password = ref('')

  const handleLogin = () => {
    console.log('Email:', email.value)
    console.log('Password:', password.value)
    // Ajoute la logique d'authentification ici
    alert('Connexion réussie (simulation)')
  }
</script>

<style scoped>
  .login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    background-color: #f5f5f5;
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

  .login-card h1 {
    margin-bottom: 1rem;
    font-size: 1.5rem;
    color: #333;
  }

  .form-group {
    margin-bottom: 1rem;
    text-align: left;
  }

  label {
    display: block;
    font-weight: bold;
    margin-bottom: 0.5rem;
    color: #555;
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
    background-color: #007bff;
    color: white;
    font-size: 1rem;
    border-radius: 4px;
    cursor: pointer;
  }

  .login-button:hover {
    background-color: #0056b3;
  }

  .register-link {
    margin-top: 1rem;
    font-size: 0.9rem;
    color: #666;
  }

  .register-link a {
    color: #007bff;
    text-decoration: none;
  }

  .register-link a:hover {
    text-decoration: underline;
  }
</style>
