<template>
  <HeaderElement />
  <button class="back-button" @click="handleBack"><span class="arrow-left"></span></button>

  <div class="container">
    <h1>Questionaires de l'entreprise NOM_ENTREPRISE {{ id }}</h1>

    <div v-for="challenge in questionnaire[0].challenges" :key="challenge.id">
      <h2>{{ challenge.value }}</h2>

      <div v-for="subChallenge in challenge.sub_challenges" :key="subChallenge.id">
        <h3>{{ subChallenge.value }}</h3>

        <div
          class="questions-container"
          v-for="question in subChallenge.questions"
          :key="question.id"
        >
          <QuestionElement :question="question" />
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import QuestionElement from '@/components/dashboard/QuestionElement.vue'
  import HeaderElement from '@/components/structure/HeaderElement.vue'
  import router from '@/router'
  // import axios from 'axios'
  import { ref } from 'vue'
  import { useRoute } from 'vue-router'

  const route = useRoute()
  const id = route.params.id
  // const apiUrl = import.meta.env.VITE_API_URL
  // axios call to get questions
  // const questionDb = await axios.get(`${apiUrl}/questions`)
  // console.log(questionDb)

  const questionnaire = ref([
    {
      challenges: [
        {
          id: '1',
          indexation_challenge: 'CH001',
          value: 'Challenge 1',
          color: 'blue',
          sub_challenges: [
            {
              id: '101',
              indexation_sub_challenge: 'SC001',
              value: 'Sub-challenge 1',
              questions: [
                {
                  id: '1001',
                  indexation_question: 'Q001',
                  template: 'Template for question 1',
                  value: 'Question 1 text',
                  type_response: 'text',
                  choices: [
                    {
                      id: '2001',
                      indexation_choice: 'C001',
                      value: 'Choice 1 for question 1',
                      score: 10,
                    },
                    {
                      id: '2002',
                      indexation_choice: 'C002',
                      value: 'Choice 2 for question 1',
                      score: 5,
                    },
                  ],
                },
                {
                  id: '1002',
                  indexation_question: 'Q002',
                  template: 'Template for question 2',
                  value: 'Question 2 text',
                  type_response: 'multiple_choice',
                  choices: [
                    {
                      id: '2003',
                      indexation_choice: 'C003',
                      value: 'Choice 1 for question 2',
                      score: 8,
                    },
                    {
                      id: '2004',
                      indexation_choice: 'C004',
                      value: 'Choice 2 for question 2',
                      score: 3,
                    },
                  ],
                },
              ],
            },
            {
              id: '102',
              indexation_sub_challenge: 'SC002',
              value: 'Sub-challenge 2',
              questions: [
                {
                  id: '1003',
                  indexation_question: 'Q003',
                  template: 'Template for question 3',
                  value: 'Question 3 text',
                  type_response: 'text',
                  choices: [],
                },
              ],
            },
          ],
        },
        {
          id: '2',
          indexation_challenge: 'CH002',
          value: 'Challenge 2',
          color: 'green',
          sub_challenges: [],
        },
      ],
    },
  ])

  const handleBack = () => {
    router.push('/dashboard')
  }
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: column;
    align-items: center;
    height: 100vh;
    position: relative;
  }

  .questions-container {
    display: flex;
    flex-direction: column;
    width: 80%;
  }

  .back-button {
    margin: 5%;
    width: 50px;
    height: 50px;
    background-color: #b5cdbf;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
    margin-bottom: 20px;
  }

  .arrow-left {
    display: inline-block;
    width: 0;
    height: 0;
    margin-right: 5px;
    border-top: 10px solid transparent;
    border-bottom: 10px solid transparent;
    border-right: 10px solid white;
  }
</style>
