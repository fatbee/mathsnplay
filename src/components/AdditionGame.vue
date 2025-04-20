<script setup>
import { ref, computed, onMounted } from 'vue';

// Game state
const score = ref(0);
const currentProblem = ref({ num1: 0, num2: 0 });
const userAnswer = ref('');
const feedback = ref('');
const showFeedback = ref(false);
const difficultyLevel = ref('easy');
const maxNumber = computed(() => {
  if (difficultyLevel.value === 'easy') return 10;
  if (difficultyLevel.value === 'medium') return 20;
  return 50;
});

// Generate a new addition problem
const generateProblem = () => {
  const max = maxNumber.value;
  currentProblem.value = {
    num1: Math.floor(Math.random() * max) + 1,
    num2: Math.floor(Math.random() * max) + 1
  };
  userAnswer.value = '';
  showFeedback.value = false;
};

// Check the user's answer
const checkAnswer = () => {
  const correctAnswer = currentProblem.value.num1 + currentProblem.value.num2;
  const userGuess = parseInt(userAnswer.value);
  
  if (isNaN(userGuess)) {
    feedback.value = 'Please enter a number!';
  } else if (userGuess === correctAnswer) {
    feedback.value = 'Correct! Great job! 🎉';
    score.value += 1;
    setTimeout(generateProblem, 1500);
  } else {
    feedback.value = `Not quite. The correct answer is ${correctAnswer}. Try again!`;
  }
  
  showFeedback.value = true;
};

// Change difficulty level
const changeDifficulty = (level) => {
  difficultyLevel.value = level;
  score.value = 0;
  generateProblem();
};

// Initialize the game
onMounted(() => {
  generateProblem();
});
</script>

<template>
  <div class="game-container">
    <h2>Addition Adventure</h2>
    
    <div class="difficulty-selector">
      <button 
        @click="changeDifficulty('easy')" 
        :class="{ active: difficultyLevel === 'easy' }"
      >
        Easy (1-10)
      </button>
      <button 
        @click="changeDifficulty('medium')" 
        :class="{ active: difficultyLevel === 'medium' }"
      >
        Medium (1-20)
      </button>
      <button 
        @click="changeDifficulty('hard')" 
        :class="{ active: difficultyLevel === 'hard' }"
      >
        Hard (1-50)
      </button>
    </div>
    
    <div class="score-display">Score: {{ score }}</div>
    
    <div class="problem-container">
      <div class="math-problem">
        {{ currentProblem.num1 }} + {{ currentProblem.num2 }} = ?
      </div>
      
      <div class="answer-input">
        <input 
          type="number" 
          v-model="userAnswer" 
          placeholder="Your answer"
          @keyup.enter="checkAnswer"
        />
        <button @click="checkAnswer">Check</button>
      </div>
      
      <div v-if="showFeedback" class="feedback" :class="{ 'correct': feedback.includes('Correct') }">
        {{ feedback }}
      </div>
    </div>
    
    <button class="new-problem-btn" @click="generateProblem">New Problem</button>
  </div>
</template>

<style scoped>
.game-container {
  max-width: 600px;
  margin: 0 auto;
  text-align: center;
}

.difficulty-selector {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 20px;
}

.difficulty-selector button {
  padding: 8px 15px;
  font-size: 0.9em;
  opacity: 0.7;
}

.difficulty-selector button.active {
  opacity: 1;
  transform: scale(1.05);
}

.score-display {
  font-size: 1.5em;
  font-weight: bold;
  margin: 15px 0;
  color: #ff6b6b;
}

.problem-container {
  background-color: white;
  padding: 30px;
  border-radius: 16px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  margin: 20px 0;
  border: 4px solid #ffcc00;
}

.answer-input {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin: 20px 0;
}

.answer-input input {
  padding: 10px;
  font-size: 1.2em;
  border: 2px solid #ccc;
  border-radius: 8px;
  width: 100px;
  text-align: center;
}

.feedback {
  margin: 15px 0;
  padding: 10px;
  border-radius: 8px;
  background-color: #ff6b6b;
  color: white;
  font-weight: bold;
}

.feedback.correct {
  background-color: #4caf50;
}

.new-problem-btn {
  margin-top: 20px;
}
</style>
