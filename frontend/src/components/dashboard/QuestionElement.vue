<script setup lang="ts">
  import { defineProps, ref } from 'vue'

  interface Choice {
    id: string
    index_choice: string
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

  interface Reponse {
    id: string
    challenge: string
    sub_challenge: string
    id_choice: string
    value: string
    commentary: string
    score: number
    is_commitment: boolean
    score_response: number
  }

  const props = defineProps<{ question: Question; reponse: Reponse }>()

  const questionModel = ref(props.question)
  const reponseModel = ref(props.reponse)

  const newResponse = ref(reponseModel.value) // Create a copy of the current response
  const newChoice = ref(reponseModel.value.id_choice)
  const newIsEngagement = ref(reponseModel.value.is_commitment)

  const handleSave = () => {
    console.log('QuestionId:', questionModel.value.id)
    console.log('Response', newResponse.value)
    console.log('Choice', newChoice.value)
    console.log('Is Engagement', newIsEngagement.value)
    console.log('save', newResponse.value)
  }
</script>

<template>
  <div style="border: 2px solid black; margin: 20px; width: 1000px">
    <!-- Question -->
    <div>
      <span>{{ questionModel.value }}</span>
    </div>
    <br />
    <br />

    <!-- Answeres -->
    <div>
      <!-- Display old answere of the client -->
      <div>
        <label for="reponse">Reponse client: </label>

        <div>
          <input type="text" :value="reponseModel.value" disabled />
          <label for="comment">Commentaire: </label>
          <input type="text" :value="reponseModel.commentary" id="comment" disabled />
          <label for="commitment">Engagement: </label>
          <input type="checkbox" :checked="reponseModel.is_commitment" id="commitment" disabled />
        </div>
      </div>

      <!-- New potentiel reponse -->
      <div>
        <label for="new-reponse">Reponse potentiel: </label>

        <!-- Type of question -->
        <div v-if="questionModel.choices.length > 0">
          <select v-model="newChoice">
            <option v-for="choix in questionModel.choices" :key="choix.id" :value="choix.id">
              {{ choix.value }}
            </option>
          </select>
        </div>
        <div v-else>
          <input type="text" id="new-reponse" />
        </div>

        <div>
          <label for="commitment">Engagement: </label>
          <input
            type="checkbox"
            :checked="reponseModel.is_commitment"
            v-model="newIsEngagement"
            id="commitment"
          />
        </div>

        <br />
        <button @click="handleSave">Modifier</button>
      </div>
    </div>
  </div>
</template>

<style></style>
