<template>
  <div class="question">
    <!-- Question -->
    <h4>{{ questionModel.value.replace('XXX', companyName) }}</h4>

    <!-- Answers -->
    <!-- If employee don't have already modified this question -->
    <div v-if="!alreadyModified" class="answers">
      <div class="each-answer">
        <div>
          <h5>Réponse client:</h5>
          <div>
            <label>Réponse:</label>
            <input
              v-if="!answerToModify.id_choice"
              type="text"
              :disabled="props.state === 'validated' || !isModifying"
              v-model="answerToModify.value"
            />
            <select
              v-else
              v-model="answerToModify.id_choice"
              @change="updateAnswerValue"
              :disabled="props.state === 'validated' || !isModifying"
            >
              <option v-for="choice in questionModel.choices" :key="choice.id" :value="choice.id">
                {{ choice.value }}
              </option>
            </select>
          </div>
          <div>
            <label>Commentaire:</label>
            <textarea
              v-model="answerToModify.commentary"
              :disabled="props.state === 'validated' || !isModifying"
            ></textarea>
          </div>
          <div>
            <label>Engagement:</label>
            <input
              type="checkbox"
              v-model="answerToModify.is_commitment"
              :disabled="props.state === 'validated' || !isModifying"
            />
          </div>
        </div>
        <button
          @click="isModifying == true ? (isModifying = false) : (isModifying = true)"
          v-if="!isModifying && props.state !== 'validated'"
        >
          modifier
        </button>
        <button v-else-if="props.state !== 'validated'" @click="handleSave">sauvagarder</button>
      </div>
    </div>

    <!-- If the employee has already modified the answer -->
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
          <input
            v-if="!answerToModify.id_choice"
            type="text"
            :value="answerToModify.value"
            :disabled="props.state === 'validated'"
          />
          <select
            v-else
            v-model="answerToModify.id_choice"
            @change="updateAnswerValue"
            :disabled="props.state === 'validated'"
          >
            <option v-for="choice in questionModel.choices" :key="choice.id" :value="choice.id">
              {{ choice.value }}
            </option>
          </select>
        </div>
        <div>
          <label>Commentaire:</label>
          <textarea
            v-model="answerToModify.commentary"
            :disabled="props.state === 'validated'"
          ></textarea>
        </div>
        <div>
          <label>Engagement:</label>
          <input
            type="checkbox"
            v-model="answerToModify.is_commitment"
            :disabled="props.state === 'validated'"
          />
        </div>
        <button @click="handleSave" v-if="props.state !== 'validated'">sauvagarder</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import type { Answer } from '@/types/Answer'
  import type { Question } from '@/types/Question'
  import axios from 'axios'
  import { defineProps, ref, type Ref } from 'vue'

  const props = defineProps<{
    question: Question
    clientAnswer: Answer
    employeeAnswer?: Answer
    idEsg: string
    state: string
    companyName: string
    challenge: string
    subChallenge: string
  }>()

  // Toggle the modification mode
  const isModifying = ref(false)
  const questionModel: Ref<Question> = ref(props.question)
  const originalAnswer = ref(props.clientAnswer)
  const alreadyModified = ref(props.employeeAnswer ? true : false)

  // If no employee answer, we use the client answer for the modification
  let answerToModify: Ref<Answer>
  if (props.employeeAnswer) {
    answerToModify = ref({ ...props.employeeAnswer })
  } else if (props.clientAnswer) {
    answerToModify = ref({ ...props.clientAnswer })
  } else {
    console.log(questionModel.value)
    answerToModify = ref({
      challenge: props.challenge,
      sub_challenge: props.subChallenge,
      commentary: '',
      id_choice: '',
      value: '',
      is_commitment: false,
    })
  }

  const updateAnswerValue = () => {
    const choice = questionModel.value.choices.find((c) => c.id === answerToModify.value.id_choice)
    answerToModify.value.value = choice?.value || ''
    answerToModify.value.id_choice = choice?.id || ''
  }

  const handleSave = () => {
    isModifying.value = false
    alreadyModified.value = true
    answerToModify = ref({ ...answerToModify.value })

    axios.patch(
      `${import.meta.env.VITE_API_URL}/modules/add/answer/`,
      {
        id_esg: props.idEsg,
        id_challenge: answerToModify.value.challenge,
        id_sub_challenge: answerToModify.value.sub_challenge,
        commentary: answerToModify.value.commentary,
        id_question: questionModel.value.id,
        id_choice: answerToModify.value.id_choice,
        value: answerToModify.value.value,
        is_commitment: answerToModify.value.is_commitment,
      },
      {
        headers: {
          Authorization: 'Bearer ' + localStorage.getItem('token'),
        },
      },
    )
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
