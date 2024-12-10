<template>
  <span class="progress" :class="getProgress()"></span>
</template>

<script setup lang="ts">
  const { type, responses, questions } = defineProps({
    type: {
      type: String,
      default: '',
    },
    responses: {
      type: Object,
      default: () => ({}),
    },
    questions: {
      type: Object,
      default: () => ({}),
    },
  })

  interface Question {
    id: string
    challenge: string
    sub_challenge: string
    template: string
    type_response: string
    value: string
  }

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

  const getProgress = () => {
    const totalQuestions = questions.length

    const answeredQuestions = responses.reduce((count: number, response: Response) => {
      const question = questions.some((q: Question) => q.id === response.id_question)
      return question ? count + 1 : count
    }, 0)

    const begin = type === 'challenge' ? 'progress-challenge' : 'progress-sub-challenge'

    if (answeredQuestions === totalQuestions) return begin + '-completed'
    if (answeredQuestions > 0) return begin + '-in-progress'
    return begin + '-not-started'
  }
</script>

<style scoped>
  .progress {
    display: inline-block;
    width: 20px;
    height: 20px;
    border-radius: 50%;
  }

  .progress-challenge-completed {
    background-color: #c8e2d3;
    border: 5px solid #b5cdbf;
  }

  .progress-challenge-in-progress {
    background-color: #f8d6d6;
    border: 5px solid #ff4d4d93;
  }

  .progress-challenge-not-started {
    background-color: #e7e7e9;
    border: 5px solid #c7c8cc;
  }

  .progress-sub-challenge-completed {
    background-color: #b5cdbf;
    border: 5px solid #c8e2d3;
  }

  .progress-sub-challenge-in-progress {
    background-color: #ff4d4d93;
    border: 5px solid #f8d6d6;
  }

  .progress-sub-challenge-not-started {
    background-color: #c7c8cc;
    border: 5px solid #e7e7e9;
  }
</style>
