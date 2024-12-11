<template>
  <div class="main-container-esg-from-questions">
    <div class="form-container-questions">
      <div
        v-for="(question, questionIndex) in selectedSubChallenge"
        :key="questionIndex"
        :class="['question', { 'question-disabled': !canAnswer(question) }]"
      >
        <h4>{{ question.value }}</h4>
        <ESGChoices
          :question="question"
          :responseId="responses[question.id]?.id_choice"
          :responseValue="responses[question.id]?.value"
        />

        <h4>Mise en place de la pratique :</h4>
        <div class="radio-group">
          <ESGRadioChoice
            :choice="{ id: question.id + '-' + 1, value: 'Maintenant' }"
            :questionId="question.id + '-when'"
            :isActive="!responses[question.id] ? false : !responses[question.id]?.is_commitment"
          />
          <ESGRadioChoice
            :choice="{ id: question.id + '-' + 2, value: 'Dans les 2 ans' }"
            :questionId="question.id + '-when'"
            :isActive="!responses[question.id] ? false : responses[question.id]?.is_commitment"
          />
        </div>

        <h4>Commentaire ?</h4>
        <div class="textarea-container">
          <textarea
            placeholder="Entrez votre commentaire ici"
            :name="question.id + '-comment'"
            :value="responses[question.id]?.commentary"
          ></textarea>
        </div>
      </div>

      <div class="save-button-container">
        <button class="save-button" @click="saveResponses()">Sauvegarder</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import type { Question } from '@/types/Question'
  import { getToken } from '@/utils/localstorage'
  import axios from 'axios'
  import ESGChoices from './ESGChoices.vue'
  import ESGRadioChoice from './ESGRadioChoice.vue'

  const apiUrl = import.meta.env.VITE_API_URL

  const {
    responses,
    idESG,
    selectedChallengeId,
    selectedSubChallengeId,
    selectedSubChallenge,
    canAnswer,
    addOneAnswer,
  } = defineProps({
    responses: {
      type: Object,
      default: () => ({}),
    },
    idESG: {
      type: String,
      default: '',
    },
    selectedChallengeId: {
      type: String,
      default: '',
    },
    selectedSubChallengeId: {
      type: String,
      default: '',
    },
    selectedSubChallenge: {
      type: Object,
      default: null,
    },
    canAnswer: {
      type: Function,
      default: () => {},
    },
    addOneAnswer: {
      type: Function,
      default: () => {},
    },
  })

  const saveResponses = () => {
    selectedSubChallenge.forEach((question: Question) => {
      if (!canAnswer(question)) return

      let idChoice = null
      let valueChoice = null

      if (question.type_response === 'qcm' || question.type_response === 'pourcentage') {
        const selectedRadio = document.querySelector(`input[name="${question.id}"]:checked`)
        idChoice = selectedRadio?.getAttribute('id_choice')
        valueChoice = selectedRadio?.getAttribute('value')
      }

      if (question.type_response === 'qrm') {
        const selectedCheckboxes = document.querySelectorAll(`input[name="${question.id}"]:checked`)
        valueChoice = Array.from(selectedCheckboxes).map(
          (checkbox) => (checkbox as HTMLInputElement).value,
        )
        if (valueChoice.length === 0) valueChoice = null
      }

      if (question.type_response === 'question ouverte') {
        const textarea = document.querySelector(`textarea[name="${question.id}"]`)
        valueChoice = (textarea as HTMLTextAreaElement)?.value
        if (valueChoice === '') valueChoice = null
      }

      const selectedRadioWhen = document.querySelector(`input[name="${question.id}-when"]:checked`)
      const isCommitment = selectedRadioWhen?.getAttribute('id_choice') === question.id + '-2'
      const comment = (
        document.querySelector(`textarea[name="${question.id}-comment"]`) as HTMLTextAreaElement
      )?.value

      axios
        .patch(
          `${apiUrl}/modules/add/answer/${idESG}`,
          {
            id_challenge: selectedChallengeId,
            id_sub_challenge: selectedSubChallengeId,
            commentary: comment,
            id_question: question.id,
            id_choice: idChoice,
            value: valueChoice,
            is_commitment: isCommitment,
          },
          {
            headers: {
              Authorization: `Bearer ${getToken()}`,
              'Content-Type': 'application/json',
            },
          },
        )
        .then(() => {
          addOneAnswer(question.id, {
            challenge: selectedChallengeId,
            sub_challenge: selectedSubChallengeId,
            id_choice: idChoice,
            value: valueChoice,
            commentary: comment,
            is_commitment: isCommitment,
          })
        })
        .catch(() => {})
    })
  }
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  body {
    padding: 0px;
    margin: 0px;
  }

  .main-container-esg-from-questions {
    height: 100vh;
    width: 100%;
    box-sizing: border-box;
    padding: 2% 0% 2% 2%;
    overflow: hidden;
  }

  .form-container-questions {
    height: 100%;
    overflow-y: auto;
    overflow-x: hidden;
    border-radius: 4px;
    position: relative;
  }

  .question {
    background-color: #e7e7e9;
    border-radius: 5px;
    margin: 0;
    padding: 1% 2% 2% 2%;
  }

  .question-disabled {
    opacity: 0.5;
    pointer-events: none;
    user-select: none;
  }

  .question-disabled textarea,
  .question-disabled input,
  .question-disabled button {
    pointer-events: none;
    background-color: #f0f0f0;
    cursor: not-allowed;
  }

  .question:not(:last-child) {
    margin-bottom: 1%;
  }

  .radio-group {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
  }

  .textarea-container textarea {
    width: 100%;
    max-width: 500px;
    height: 100px;
    font-size: 16px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
    resize: none;
    outline: none;
    transition: border-color 0.3s;
  }

  .textarea-container textarea:focus {
    border-color: #013238;
    box-shadow: 0 0 5px #b5cdbf;
  }

  .save-button-container {
    bottom: 1%;
    margin-right: 1%;
    text-align: center;
    background-color: #e7e7e9;
    border-radius: 4px;
    padding: 1%;
  }

  .save-button {
    background-color: #013238;
    color: white;
    border: none;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 5px;
    cursor: pointer;
  }

  .save-button:hover {
    background-color: #00252a;
    transform: scale(1.03);
    transition: transform 0.3s ease;
  }
</style>
