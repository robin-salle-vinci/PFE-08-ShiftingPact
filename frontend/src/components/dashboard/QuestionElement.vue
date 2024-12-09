<template>
  <div class="question">
    <!-- Question -->

    <h4>{{ questionModel.value }}</h4>

    <!-- Answers -->
    <div class="answers">
      <div class="each-answer">
        <!-- Display old answer of the client -->
        <div>
          <h5>Réponse client:</h5>
          <div>
            <label>Réponse:</label>
            <input type="text" :value="reponseModel.value" disabled />
          </div>
          <div>
            <label>Commentaire:</label>
            <input type="text" :value="reponseModel.commentary" disabled />
          </div>
          <div>
            <label>Engagement:</label>
            <input type="checkbox" :checked="reponseModel.is_commitment" disabled />
          </div>
        </div>
      </div>

      <div class="each-answer" v-if="employeeResponse">
        <h5>Réponse employé:</h5>
        <div>
          <label>Réponse:</label>
          <input type="text" :value="employeeResponse.value" disabled />
        </div>
        <div>
          <label>Commentaire:</label>
          <input type="text" :value="employeeResponse.commentary" disabled />
        </div>
        <div>
          <label>Engagement:</label>
          <input type="checkbox" :checked="employeeResponse.is_commitment" disabled />
        </div>
      </div>

      <!-- New potential response -->
      <div class="each-answer">
        <h5>Réponse potentielle:</h5>
        <div>
          <label for="new-reponse">Réponse:</label>
          <div v-if="questionModel.choices.length > 0">
            <select v-model="newResponseModel.id_choice" @change="updateNewResponseValue">
              <option v-for="choix in questionModel.choices" :key="choix.id" :value="choix.id">
                {{ choix.value }}
              </option>
            </select>
          </div>
          <div v-else>
            <input type="text" id="new-reponse" v-model="newResponseModel.value" />
          </div>
        </div>
        <div>
          <label for="new-commitment">Engagement:</label>
          <input type="checkbox" v-model="newResponseModel.is_commitment" id="new-commitment" />
        </div>
        <button @click="handleSave">Modifier</button>
      </div>
    </div>
  </div>
</template>

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

  const props = defineProps<{
    question: Question
    clientResponse: Reponse
    employeeResponse: Reponse | undefined
  }>()

  const questionModel = ref(props.question)
  const reponseModel = ref(props.clientResponse)

  const newResponseModel = ref({ ...props.clientResponse })

  const updateNewResponseValue = () => {
    const choice = questionModel.value.choices.find(
      (c) => c.id === newResponseModel.value.id_choice,
    )
    newResponseModel.value.value = choice?.value || ''
    newResponseModel.value.id_choice = choice?.id || ''
  }

  const handleSave = () => {
    // TODO SEND THE MODIFIED RESPONSE TO THE SERVER
    console.log(newResponseModel.value)
  }
</script>

<style scoped>
  .question {
    margin: 20px;
    padding: 20px;
    border-radius: 5px;
  }

  .question h4 {
    text-align: center;
    margin-top: 2px;
  }

  .answers {
    display: flex;
    flex-direction: row;
    justify-content: center;
    gap: 20px;
  }
  .each-answer {
    background-color: rgb(111, 196, 41);
    width: 33%;
    padding: 20px;
    border-radius: 10px;
  }
</style>
