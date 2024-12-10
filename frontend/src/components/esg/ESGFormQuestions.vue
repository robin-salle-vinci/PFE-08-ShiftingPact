<template>
  <div class="main-container-esg-from-questions">
    <div class="form-container-questions">
      <div v-for="(question, questionIndex) in selectedSubChallenge" :key="questionIndex">
        <h4>{{ question.value }}</h4>
        <ESGChoices
          :question="question"
          :responseId="questionResponses[question.id]?.id_choice"
          :responseValue="questionResponses[question.id]?.value"
        />

        <h4>Mise en place de la pratique :</h4>
        <div class="radio-group">
          <ESGRadioChoice
            :choice="{ id: question.id + '-' + 1, value: 'Maintenant' }"
            :questionId="question.id + '-when'"
            :isActive="
              !questionResponses[question.id] ? false : !questionResponses[question.id].isEngagement
            "
          />
          <ESGRadioChoice
            :choice="{ id: question.id + '-' + 2, value: 'Dans les 2 ans' }"
            :questionId="question.id + '-when'"
            :isActive="
              !questionResponses[question.id] ? false : questionResponses[question.id].isEngagement
            "
          />
          
        </div>

        <h4>Commentaire ?</h4>
        <div class="textarea-container">
          <textarea
            placeholder="Entrez votre commentaire ici"
            :value="questionResponses[question.id]?.comment"
          ></textarea>
        </div>

        <div
          v-if="parseInt(questionIndex) < selectedSubChallenge.length - 1"
          class="separator"
        ></div>
      </div>

      <div class="save-button-container">
        <button class="save-button">Sauvegarder</button>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { computed } from 'vue'
  import ESGChoices from './ESGChoices.vue'
  import ESGRadioChoice from './ESGRadioChoice.vue'

  const { responses, selectedSubChallenge } = defineProps({
    responses: {
      type: Object,
      default: () => ({}),
    },
    selectedSubChallenge: {
      type: Object,
      default: null,
    },
  })

  interface Response {
    id: string
    id_client: number
    id_question: string
    comment: string
    isEngagement: boolean
    value: string
    score_response: number
    date_modification: string
  }

  const questionResponses = computed(() => {
    const questionResponsesTemp: any = {}

    selectedSubChallenge.forEach((question) => {
      questionResponsesTemp[question.id] =
        responses.find((r: Response) => r.id_question === question.id) || null
    })

    return questionResponsesTemp
  })
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
    background-color: #e7e7e9;
    border-radius: 5px;
    overflow-y: auto;
    overflow-x: hidden;
    padding: 0% 2% 2% 2%;
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

  .separator {
    width: 100%;
    height: 2px;
    background-color: #ccc;
    margin-top: 20px;
    margin-bottom: 20px;
  }

  .save-button-container {
    position: -webkit-sticky;
    position: sticky;
    bottom: 0;
    right: 0;
    text-align: right;
    margin-top: 0;
    z-index: 1000;
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
