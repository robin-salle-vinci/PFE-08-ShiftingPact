<template>
  <div class="question">
    <!-- Question -->

    <h4>{{ questionModel.value }}</h4>

    <!-- Answers -->

    <!-- Display old answer of the client -->

    <!-- If employee dont have already modify this question -->
    <div v-if="!alreadyModified" class="answers">
      <div class="each-answer">
        <div>
          <h5>Réponse client:</h5>
          <div>
            <label>Réponse:</label>
            <input type="text" :value="answerToModify.value" :disabled="!isModifying" />
          </div>
          <div>
            <label>Commentaire:</label>
            <textarea :value="answerToModify.commentary" :disabled="!isModifying"></textarea>
          </div>
          <div>
            <label>Engagement:</label>
            <input
              type="checkbox"
              :checked="answerToModify.is_commitment"
              :disabled="!isModifying"
            />
          </div>
        </div>
        <button
          @click="isModifying == true ? (isModifying = false) : (isModifying = true)"
          v-if="!isModifying"
        >
          modifier
        </button>
        <button v-else @click="handleSave">sauvagrder</button>
      </div>
    </div>

    <!-- if the epmloyee have already modify the answer -->
    <div v-else class="answers">
      <div class="each-answer">
        <h5>Réponse client:</h5>
        <div>
          <label>Réponse:</label>
          <input type="text" :value="originalAnswer.value" disabled />
        </div>
        <div>
          <label>Commentaire:</label>
          <textarea :value="originalAnswer.commentary" disabled></textarea>
        </div>
        <div>
          <label>Engagement:</label>
          <input type="checkbox" :checked="originalAnswer.is_commitment" disabled />
        </div>
      </div>

      <div class="each-answer" v-if="answerToModify">
        <h5>Réponse employé:</h5>
        <div>
          <label>Réponse:</label>
          <input v-if="!answerToModify.id_choice" type="text" :value="answerToModify.value" />
          <select v-else v-model="answerToModify.id_choice" @change="updateAnswerValue">
            <option v-for="choice in questionModel.choices" :key="choice.id" :value="choice.id">
              {{ choice.value }}
            </option>
          </select>
        </div>
        <div>
          <label>Commentaire:</label>
          <textarea v-model="answerToModify.commentary"></textarea>
        </div>
        <div>
          <label>Engagement:</label>
          <input type="checkbox" v-model="answerToModify.is_commitment" />
        </div>
        <button @click="handleSave">sauvagrder</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { defineProps, ref, type Ref } from 'vue'

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

  const questionModel: Ref<Question> = ref(props.question)
  const originalAnswer = ref(props.clientResponse)
  const alreadyModified = ref(true) //ref(props.employeeResponse ? true : false)
  const answerToModify: Ref<Reponse> = ref({
    id: props.clientResponse.id,
    challenge: props.clientResponse.challenge,
    sub_challenge: props.clientResponse.sub_challenge,
    id_choice: props.clientResponse.id_choice,
    value: props.clientResponse.value,
    commentary: props.clientResponse.commentary,
    score: props.clientResponse.score,
    is_commitment: props.clientResponse.is_commitment,
    score_response: props.clientResponse.score_response,
  })
  // if (props.employeeResponse) {
  //   answerToModify = ref(props.employeeResponse)
  // } else {
  //   answerToModify = ref(props.clientResponse)
  // }

  // const newResponseModel = ref({ ...props.clientResponse })

  const isModifying = ref(false)

  const updateAnswerValue = () => {
    const choice = questionModel.value.choices.find((c) => c.id === answerToModify.value.id_choice)
    answerToModify.value.value = choice?.value || ''
    answerToModify.value.id_choice = choice?.id || ''
  }

  const handleSave = () => {
    isModifying.value = false
    console.log(answerToModify.value)
    // TODO SEND THE MODIFIED RESPONSE TO THE SERVER
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
    width: 100%;
  }

  .each-answer {
    background-color: #dfd4fb;
    width: 100%;
    padding: 20px;
    border-radius: 10px;
    margin: 10px;
  }
</style>
