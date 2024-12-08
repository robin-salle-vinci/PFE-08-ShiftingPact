<template>
  <span
    :class="
      type == 'challenge'
        ? getCategoryProgress(challengeName)
        : getSubCategoryProgress(challengeName)
    "
  ></span>
</template>

<script setup lang="ts">
  const { type, responses, questions } = defineProps({
    type: {
      type: String,
      default: '',
    },
    challengeName: {
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

  const getCategoryProgress = (challenge: string) => {
    const challengeQuestions = questions.filter((q: Question) => q.challenge === challenge)
    const totalQuestions = challengeQuestions.length

    const answeredQuestions = responses.reduce((count: number, response: Response) => {
      const question = challengeQuestions.some((q: Question) => q.id === response.id_question)
      return question ? count + 1 : count
    }, 0)

    if (answeredQuestions === totalQuestions) {
      return 'progress-challenge-completed'
    } else if (answeredQuestions > 0) {
      return 'progress-challenge-in-progress'
    } else {
      return 'progress-challenge-not-started'
    }
  }

  const getSubCategoryProgress = (subChallenge: string) => {
    const challengeQuestions = questions.filter((q: Question) => q.sub_challenge === subChallenge)
    const totalQuestions = challengeQuestions.length

    const answeredQuestions = responses.reduce((count: number, response: Response) => {
      const question = challengeQuestions.some((q: Question) => q.id === response.id_question)
      return question ? count + 1 : count
    }, 0)

    if (answeredQuestions === totalQuestions) {
      return 'progress-sub-challenge-completed'
    } else if (answeredQuestions > 0) {
      return 'progress-sub-challenge-in-progress'
    } else {
      return 'progress-sub-challenge-not-started'
    }
  }
</script>

<style scoped>
  .progress-challenge-completed {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #c8e2d3;
    border-radius: 50%;
    border: 5px solid #b5cdbf;
  }

  .progress-challenge-in-progress {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #f8d6d6;
    border-radius: 50%;
    border: 5px solid #ff4d4d93;
  }

  .progress-challenge-not-started {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #e7e7e9;
    border-radius: 50%;
    border: 5px solid #c7c8cc;
  }

  .progress-sub-challenge-completed {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #b5cdbf;
    border-radius: 50%;
    border: 5px solid #c8e2d3;
  }

  .progress-sub-challenge-in-progress {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #ff4d4d93;
    border-radius: 50%;
    border: 5px solid #f8d6d6;
  }

  .progress-sub-challenge-not-started {
    display: inline-block;
    width: 20px;
    height: 20px;
    background-color: #c7c8cc;
    border-radius: 50%;
    border: 5px solid #e7e7e9;
  }
</style>
