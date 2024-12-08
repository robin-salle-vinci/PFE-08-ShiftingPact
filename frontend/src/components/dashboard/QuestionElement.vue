<script setup lang="ts">
  import { defineProps, ref } from 'vue'

  interface Choice {
    id: string
    indexation_choice: string
    value: string
    score: number
  }

  interface Question {
    id: string
    indexation_question: string
    template: string
    value: string
    type_response: string
    choices: Choice[]
  }

  const props = defineProps<{ question: Question }>()
  console.log(props.question)

  const questionModel = ref(props.question)

  // const handleSave = () => {
  //   console.log('save')
  // }
</script>

<template>
  <div>
    <!-- {{ questionModel }} -->

    <div>{{ questionModel.value }}</div>
    <div>
      <div>reponse du client TODO</div>
      <div v-if="questionModel.choices.length > 0">
        <select v-model="questionModel.value">
          <option v-for="choix in questionModel.choices" :key="choix.id" :value="choix">
            {{ choix.value }}
          </option>
        </select>
      </div>
      <div v-else>
        <input v-model="questionModel.value" type="text" />
      </div>

      <div>todo commentaire</div>
    </div>
  </div>
  <!-- <div class="card">

     <span>{{ questionModel.question }}</span>
    <form class="inputs">
      <div v-if="!questionModel.choix.length">
        <input v-model="questionModel.reponse" type="text" />
      </div>
      <textarea v-model="questionModel.commentaire" readonly disabled></textarea>
      <div>
        <label>
          <input type="radio" v-model="questionModel.isEngagement" :value="false" />
          Déjà en application
        </label>
        <label>
          <input type="radio" v-model="questionModel.isEngagement" :value="true" />
          Engagement
        </label>
      </div>
      <span>{{ questionModel.value }}</span>
      <div v-if="questionModel.choix.length">
        <select v-model="questionModel.value">
          <option v-for="choix in questionModel.choix" :key="choix" :value="choix">
            {{ choix }}
          </option>
        </select>
      </div>
      <button @click="handleSave">sauvgarder</button>
    </form> 
  </div> -->
</template>

<style>
  .card {
    display: flex;
    flex-direction: column;
    justify-content: center;
    width: 100%;
    height: 100%;
    background-color: #f5f5f5;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  .inputs {
    margin-top: 2%;
    display: flex;
    justify-content: space-around;
    gap: 10px;
  }
  textarea {
    resize: none;
  }
</style>
