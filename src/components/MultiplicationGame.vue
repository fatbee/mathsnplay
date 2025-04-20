<script setup>
import { ref, computed, onMounted } from 'vue';

// Game state
const score = ref(0);
const currentProblem = ref({ num1: 0, num2: 0 });
const userAnswer = ref('');
const feedback = ref('');
const showFeedback = ref(false);
const selectedTable = ref(0); // 0 means random tables
const gameMode = ref('practice'); // practice or quiz

// Generate a new multiplication problem
const generateProblem = () => {
  let num1, num2;
  
  if (selectedTable.value === 0) {
    // Random tables mode
    num1 = Math.floor(Math.random() * 10) + 1;
    num2 = Math.floor(Math.random() * 10) + 1;
  } else {
    // Specific table mode
    num1 = selectedTable.value;
    num2 = Math.floor(Math.random() * 10) + 1;
  }
  
  currentProblem.value = { num1, num2 };
  userAnswer.value = '';
  showFeedback.value = false;
};

// Check the user's answer
const checkAnswer = () => {
  const correctAnswer = currentProblem.value.num1 * currentProblem.value.num2;
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

// Change the multiplication table to practice
const changeTable = (table) => {
  selectedTable.value = table;
  score.value = 0;
  generateProblem();
};

// Switch game mode
const switchGameMode = (mode) => {
  gameMode.value = mode;
  score.value = 0;
  generateProblem();
};

// Initialize the game
onMounted(() => {
  generateProblem();
});

// Computed property for table buttons
const tables = computed(() => {
  return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
});
</script>

<template>
  <div class="game-container">
    <h2>Multiplication Mania</h2>
    
    <div class="mode-selector">
      <button 
        @click="switchGameMode('practice')" 
        :class="{ active: gameMode === 'practice' }"
      >
        Practice Mode
      </button>
      <button 
        @click="switchGameMode('quiz')" 
        :class="{ active: gameMode === 'quiz' }"
      >
        Quiz Mode
      </button>
    </div>
    
    <div class="table-selector">
      <p>Select a multiplication table to practice:</p>
      <div class="table-buttons">
        <button 
          v-for="table in tables" 
          :key="table" 
          @click="changeTable(table)"
          :class="{ active: selectedTable === table }"
        >
          {{ table === 0 ? 'Random' : table }}
        </button>
      </div>
    </div>
    
    <div class="score-display">Score: {{ score }}</div>
    
    <div class="problem-container">
      <div class="math-problem">
        {{ currentProblem.num1 }} × {{ currentProblem.num2 }} = ?
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

.mode-selector {
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 20px;
}

.mode-selector button {
  padding: 8px 15px;
  font-size: 0.9em;
  opacity: 0.7;
}

.mode-selector button.active {
  opacity: 1;
  transform: scale(1.05);
}

.table-selector {
  margin: 20px 0;
}

.table-buttons {
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  justify-content: center;
  margin-top: 10px;
}

.table-buttons button {
  width: 40px;
  height: 40px;
  padding: 0;
  font-size: 1em;
  border-radius: 50%;
  background-color: #4caf50;
  opacity: 0.7;
}

.table-buttons button.active {
  opacity: 1;
  transform: scale(1.1);
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
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
