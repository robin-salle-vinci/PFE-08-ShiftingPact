<template>
  <main>
    <div class="card" v-if="!submited">
      <div>
        <h2>Enregistrer une nouvelle entreprise</h2>
        <form @submit.prevent="handleCreate">
          <!--<input type="text" name="firstname" placeholder="Prenom de l'employee" />
          <input type="text" name="lastname" placeholder="Nom de l'employee" />
          <input type="text" name="email" placeholder="Email de l'employee" v-model="email" />
          <input
            type="text"
            name="employee-function"
            id="employee-function"
            placeholder="Fonction de l'employee"
          />
          <input type="text" name="company-name" placeholder="Nom de l'entreprise" />
          <input type="text" name="adress" placeholder="N° d'entreprise" />
          <input type="text" name="form-juridique" placeholder="Forme juridique" />
          <input type="text" name="adress-social-siege" placeholder="Adresse du siège social" />
          <input type="text" name="web-site-url" placeholder="Adresse de votre site web" />
          <input type="text" name="code-nace" placeholder="Code Nace" />
          <input
            type="text"
            name="chiffre-affaire-compatble"
            id="Chiffre d'affaire du derrnier exercises comptable"
          />
          <input type="text" placeholder="Nombre de travailleurs" />-->
          <div class="input-element">
            <label for="company-name">Nom de l'entreprise</label>
            <input
              id="company-name"
              type="text"
              name="company-name"
              placeholder="Nom de la PME"
              v-model="companyName"
            />
          </div>

          <div class="input-element">
            <label for="number-worker">Nombre d'employee</label>
            <input
              id="number-worker"
              type="number"
              name="number-worker"
              placeholder="Nombre d'employee"
              v-model="numberWorkers"
            />
          </div>
          <div class="input-element">
            <label for="building-owner">La societe dispose d'une propriétaire</label>
            <input
              id="building-owner"
              type="checkbox"
              name="building-owner"
              v-model="facilityOwner"
            />
          </div>

          <div class="input-element">
            <label for="product-service">La société propose des services</label>
            <input
              id="product-service"
              type="checkbox"
              name="product-service"
              v-model="isService"
            />
          </div>

          <input type="submit" value="Générer un accès client" />
        </form>
      </div>
    </div>
    <div v-else class="card">
      <h2>Identifiant de connection de l'entreprise</h2>
      <div class="cred-container">
        <div class="cred-element">
          <p>
            Identifiant: <strong>{{ username }}</strong>
          </p>
          <button @click="copyToClipboard(username)">copy</button>
        </div>
        <div class="cred-element">
          <p>
            Mot de passe: <strong>{{ password }}</strong>
          </p>
          <button @click="copyToClipboard(password)">copy</button>
        </div>
      </div>
    </div>
  </main>
</template>

<script setup lang="ts">
  import axios, { type AxiosResponse } from 'axios'
  import { ref } from 'vue'

  const apiUrl = import.meta.env.VITE_API_URL
  console.log(apiUrl)
  const submited = ref<boolean>(false)

  const companyName = ref<string>('')
  const numberWorkers = ref<number>(0)
  const facilityOwner = ref<boolean>(false)
  const isService = ref<boolean>(false)

  const username = ref<string>('username')
  const password = ref<string>('password')

  const handleCreate = () => {
    if (!companyName.value) return

    submited.value = true
    // TODO put cred in press papier

    axios
      .post(`${apiUrl}/users/register`, {
        companyName: companyName.value,
        numberWorkers: numberWorkers.value,
        facilityOwner: facilityOwner.value,
        isService: isService.value,
      })
      .then((response: AxiosResponse) => {
        submited.value = true
        const data = response.data
        username.value = data.username
        password.value = data.password
      })
      .catch(() => {})
  }

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text)
  }
</script>

<style scoped>
  main {
    display: flex;
    justify-content: center;
  }

  .card {
    margin-top: 2%;
    background: rgb(255, 255, 255);
    padding: 2rem;
    border-radius: 8px;
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    text-align: center;
    width: 100%;
    max-width: 800px;
  }

  form {
    display: flex;
    flex-direction: column;
    text-align: left; /* Permet d'aligner les labels à gauche */
  }
  .input-element {
    display: flex;
    flex-direction: row; /* Aligne les éléments en ligne */
    align-items: center;
    margin-top: 1rem;
    gap: 1rem;
    width: 100%; /* Assure que l'élément prend toute la largeur */
  }

  .input-element input[type='checkbox'] {
    flex: 0; /* Empêche la checkbox de s'étendre */
    width: 20px; /* Largeur fixe */
    height: 20px;
    margin: 0; /* Pas de marge supplémentaire */
  }

  .input-element label {
    flex: 1; /* Les labels occupent une partie de la ligne */
    text-align: left; /* Texte aligné à gauche */
  }

  .input-element input[type='text'],
  .input-element input[type='number'] {
    flex: 2; /* Les champs texte/numériques prennent plus d'espace */
  }

  input[type='checkbox'] {
    appearance: none;
    -webkit-appearance: none;
    width: 20px;
    height: 20px;
    border: 2px solid #013238;
    border-radius: 4px;
    transition:
      background-color 0.3s ease,
      border-color 0.3s ease;
    cursor: pointer;
    position: relative;
  }

  input[type='checkbox']::after {
    content: '';
    display: block;
    width: 10px;
    height: 10px;
    background-color: transparent;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 2px;
    transition: background-color 0.3s ease;
  }

  input[type='checkbox']:checked {
    border-color: #013238;
    background-color: #013238;
  }

  input[type='checkbox']:checked::after {
    background-color: white;
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

  /* Credentials */

  .cred-element {
    display: flex;
    justify-content: space-around;
    padding: 2%;
  }
  .cred-element button {
    background-color: #013238;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    width: 70px;
  }
</style>
