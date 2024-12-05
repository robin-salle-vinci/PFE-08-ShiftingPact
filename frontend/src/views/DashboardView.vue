<template>
  <HeaderElement />
  <main>
    <div class="card">
      <h2>Creer une entreprise</h2>
      <form>
        <input type="text" name="firstname" placeholder="Prenom de l'employee" />
        <input type="text" name="lastname" placeholder="Nom de l'employee" />
        <input type="text" name="email" placeholder="Email de l'employee" v-model="email" />
        <!-- <input
          type="text"
          name="employee-function"
          id="employee-function"
          placeholder="Fonction de l'employee"
        /> -->
        <!-- <input type="text" name="company-name" placeholder="Nom de l'entreprise" />
        <input type="text" name="adress" placeholder="N° d'entreprise" />
        <input type="text" name="form-juridique" placeholder="Forme juridique" />
        <input type="text" name="adress-social-siege" placeholder="Adresse du siège social" />
        <input type="text" name="web-site-url" placeholder="Adresse de votre site web" />
        <input type="text" name="code-nace" placeholder="Code Nace" /> -->
        <input
          type="text"
          name="chiffre-affaire-compatble"
          id="Chiffre d'affaire du derrnier exercises comptable"
        />
        <input type="text" placeholder="Nombre de travailleurs" />
        <input type="submit" value="creer l'accces" />
      </form>
    </div>
  </main>
</template>

<script setup lang="ts">
  import HeaderElement from '@/components/HeaderElement.vue'
  import { ref } from 'vue'
  const email = ref('')
</script>

<style scoped>
  main {
    display: flex;
    justify-content: center;
  }

  .card {
    margin-top: 2%;
    background: rgb(177, 12, 12);
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 100%;
    max-width: 500px;
  }

  form {
    display: flex;
    flex-direction: column;
  }

  input {
    width: 100%;
    padding: 0.8rem;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 1rem;
    color: #333;
    box-sizing: border-box;
    margin-top: 2%;
  }

  input[type='submit'] {
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
</style>
