<template>
  <div
    class="main-container"
    :class="
      isSubChallengeSelected
        ? 'main-container-esg-list-small-padding'
        : 'main-container-esg-list-big-padding'
    "
  >
    <div class="progress-bar-container">
      <div class="progress-bar">
        <div class="bar" :style="{ width: progress + '%' }"></div>
        <span class="progress-text">{{ Math.round(progress * 10) / 10 }}%</span>
      </div>
    </div>

    <div class="title-form">
      <h1 class="title">Formulaire ESG</h1>
    </div>

    <div class="form-container">
      <div
        v-for="(challenge, challengeIndex) in questions.challenges"
        :key="challengeIndex"
        class="category"
      >
        <div
          class="category-header"
          :style="`background-color: #${challenge.color};`"
          @click="toggleCategory(challengeIndex)"
        >
          <h3>{{ challenge.value }}</h3>
          <div class="category-right-content">
            <div class="category-progress">
              <ChallengeProgress
                type="challenge"
                :responses="responses"
                :questions="
                  challenge.sub_challenges.flatMap(
                    (subChallenge: SubChallenge) => subChallenge.questions,
                  )
                "
              />
            </div>
            <div class="separator"></div>
            <i
              class="fas fa-chevron-down toggle-arrow"
              :class="{ open: categoryState[challengeIndex] }"
            ></i>
          </div>
        </div>

        <div v-show="categoryState[challengeIndex]" class="subcategories">
          <div
            v-for="(subChallenge, subChallengeIndex) in challenge.sub_challenges"
            :key="subChallengeIndex"
            class="subcategory"
            @click="onSubChallengeSelected(subChallenge.questions, challenge.id, subChallenge.id)"
          >
            <h4>{{ subChallenge.value }}</h4>
            <ChallengeProgress
              type="subchallenge"
              :responses="responses"
              :questions="subChallenge.questions"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
  import { ref, computed } from 'vue'
  import ChallengeProgress from './ChallengeProgress.vue'
  import type { SubChallenge } from '@/types/SubChallenge.ts'

  const { questions, responses, isSubChallengeSelected, onSubChallengeSelected } = defineProps({
    questions: {
      type: Object,
      default: () => ({}),
    },
    responses: {
      type: Object,
      default: () => ({}),
    },
    isSubChallengeSelected: {
      type: Boolean,
      default: () => false,
    },
    onSubChallengeSelected: {
      type: Function,
      default: () => {},
    },
  })

  const progress = computed(() => {
    if (!questions.challenges) return 0
    if (progress.value === 100) return 100

    let totalQuestions = 0

    for (const challenge of questions.challenges) {
      for (const subChallenge of challenge.sub_challenges) {
        totalQuestions += subChallenge.questions.length
      }
    }

    return (responses.length / totalQuestions) * 100
  })

  const categoryState = ref<Record<string, boolean>>({})

  const toggleCategory = (challenge: number) => {
    categoryState.value[challenge] = !categoryState.value[challenge]
  }
</script>

<style scoped>
  * {
    font-family: 'Arial', sans-serif;
    box-sizing: border-box;
  }

  body {
    margin: 0;
    padding: 0;
    overflow: hidden;
  }

  .main-container {
    height: 100vh;
    box-sizing: border-box;
    display: flex;
    flex-direction: column;
    align-items: stretch;
    padding-top: 2%;
    padding-bottom: 2%;
  }

  .main-container-esg-list-small-padding {
    padding-left: 2%;
    padding-right: 2%;
    width: 45%;
  }

  .main-container-esg-list-big-padding {
    padding-left: 10%;
    padding-right: 10%;
  }

  .title-form {
    padding: 0;
    margin-bottom: 0px;
    background-color: #e7e7e9;
    text-align: center;
    border-radius: 5px 5px 0 0;
    border-bottom: 2px solid #cccccc;
  }

  .title {
    margin: 0;
    padding: 1%;
    font-size: 30px;
    font-weight: 600;
    color: #013238;
  }

  .form-container {
    background-color: #e7e7e9;
    border-radius: 0 0 5px 5px;
    padding: 30px;
    height: 100%;
    overflow-y: auto;
    box-sizing: border-box;
  }

  .progress-bar-container {
    margin-bottom: 30px;
  }

  .progress-bar {
    background: #e7e7e9;
    border-radius: 5px;
    position: relative;
    height: 30px;
    width: 100%;
    overflow: hidden;
  }

  .bar {
    background: #b5cdbf;
    height: 100%;
    border-radius: 5px;
    transition: width 0.5s ease-in-out;
  }

  .progress-text {
    position: absolute;
    color: #013238;
    font-weight: 600;
    font-size: 25px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 2;
    user-select: none;
  }

  /* Categories and subcategories */
  .category {
    margin-bottom: 15px;
    border-radius: 5px;
  }

  .category-header {
    cursor: pointer;
    font-weight: 600;
    height: 80px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    color: #ffffff;
    padding: 10px 20px;
    border-radius: 5px;
    box-sizing: border-box;
    user-select: none;
  }

  .category-header:hover {
    transform: scale(1.005);
    transition: transform 0.3s ease;
  }

  .category-header .toggle-arrow {
    font-size: 20px;
    transition: transform 0.3s;
  }

  .category-header .toggle-arrow.open {
    transform: rotate(180deg);
  }

  .category-right-content {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100px;
    height: 100%;
    box-sizing: border-box;
  }

  .category-progress {
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .subcategory {
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #ffffff;
    padding: 0% 2% 0% 2%;
    border-radius: 5px;
    user-select: none;
  }

  .subcategory:hover {
    background-color: #f1f1f1;
    transform: scale(1.005);
    transition: transform 0.3s ease;
  }

  .subcategories {
    display: flex;
    flex-direction: column;

    margin: 0 10px 0 10px;

    border-end-start-radius: 5px;
    border-end-end-radius: 5px;
    background-color: #ffffff;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }

  .navbar-no-side-popup {
    background-color: #f0f0f0;
    border: 1px solid #ccc;
    padding: 10px;
    border-radius: 5px;
  }

  .separator {
    border-left: 2px solid #e0e0e0;
    margin: 0 20px 0 20px;
    height: 100%;
  }
</style>
