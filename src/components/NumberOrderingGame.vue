<script setup>
import { ref, computed, onMounted } from 'vue';

// Game state
const score = ref(0);
const numbers = ref([]);
const userOrder = ref([]);
const feedback = ref('');
const showFeedback = ref(false);
const difficultyLevel = ref('easy');

// Computed properties for difficulty settings
const numberCount = computed(() => {
  if (difficultyLevel.value === 'easy') return 5;
  if (difficultyLevel.value === 'medium') return 7;
  return 10;
});

const maxNumber = computed(() => {
  if (difficultyLevel.value === 'easy') return 20;
  if (difficultyLevel.value === 'medium') return 50;
  return 100;
});

// Generate a new set of numbers to order
const generateNumbers = () => {
  const count = numberCount.value;
  const max = maxNumber.value;
  const newNumbers = [];
  
  // Generate random unique numbers
  while (newNumbers.length < count) {
    const num = Math.floor(Math.random() * max) + 1;
    if (!newNumbers.includes(num)) {
      newNumbers.push(num);
    }
  }
  
  numbers.value = [...newNumbers];
  userOrder.value = [];
  showFeedback.value = false;
};

// Add a number to the user's ordering
const selectNumber = (num) => {
  if (!userOrder.value.includes(num)) {
    userOrder.value.push(num);
  }
};

// Remove a number from the user's ordering
const removeNumber = (index) => {
  userOrder.value.splice(index, 1);
};

// Check if the user's ordering is correct
const checkOrder = () => {
  if (userOrder.value.length !== numbers.value.length) {
    feedback.value = 'Please order all the numbers!';
    showFeedback.value = true;
    return;
  }
  
  const correctOrder = [...numbers.value].sort((a, b) => a - b);
  const isCorrect = userOrder.value.every((num, index) => num === correctOrder[index]);
  
  if (isCorrect) {
    feedback.value = 'Correct! The numbers are in the right order! 🎉';
    score.value += 1;
    setTimeout(generateNumbers, 2000);
  } else {
    feedback.value = 'Not quite right. Try again!';
  }
  
  showFeedback.value = true;
};

// Reset the current ordering
const resetOrder = () => {
  userOrder.value = [];
  showFeedback.value = false;
};

// Change difficulty level
const changeDifficulty = (level) => {
  difficultyLevel.value = level;
  score.value = 0;
  generateNumbers();
};

// Initialize the game
onMounted(() => {
  generateNumbers();
});

// Computed property for remaining numbers
const remainingNumbers = computed(() => {
  return numbers.value.filter(num => !userOrder.value.includes(num));
});
</script>

<template>
  <div class="game-container">
    <h2>Number Ordering</h2>
    
    <div class="difficulty-selector">
      <button 
        @click="changeDifficulty('easy')" 
        :class="{ active: difficultyLevel === 'easy' }"
      >
        Easy (5 numbers, 1-20)
      </button>
      <button 
        @click="changeDifficulty('medium')" 
        :class="{ active: difficultyLevel === 'medium' }"
      >
        Medium (7 numbers, 1-50)
      </button>
      <button 
        @click="changeDifficulty('hard')" 
        :class="{ active: difficultyLevel === 'hard' }"
      >
        Hard (10 numbers, 1-100)
      </button>
    </div>
    
    <div class="score-display">Score: {{ score }}</div>
    
    <div class="game-instructions">
      <p>Order these numbers from smallest to largest:</p>
    </div>
    
    <div class="problem-container">
      <div class="number-pool">
        <button 
          v-for="num in remainingNumbers" 
          :key="num"
          @click="selectNumber(num)"
          class="number-button"
        >
          {{ num }}
        </button>
      </div>
      
      <div class="user-order">
        <div 
          v-for="(num, index) in userOrder" 
          :key="index"
          class="ordered-number"
          @click="removeNumber(index)"
        >
          {{ num }}
        </div>
        <div v-for="i in (numberCount - userOrder.length)" :key="i" class="empty-slot">
          ?
        </div>
      </div>
      
      <div v-if="showFeedback" class="feedback" :class="{ 'correct': feedback.includes('Correct') }">
        {{ feedback }}
      </div>
      
      <div class="action-buttons">
        <button @click="resetOrder" class="reset-btn">Reset</button>
        <button @click="checkOrder" class="check-btn">Check Order</button>
      </div>
    </div>
    
    <button class="new-problem-btn" @click="generateNumbers">New Numbers</button>
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
  flex-wrap: wrap;
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

.game-instructions {
  margin: 15px 0;
  font-size: 1.2em;
}

.problem-container {
  background-color: white;
  padding: 30px;
  border-radius: 16px;
  box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
  margin: 20px 0;
  border: 4px solid #ffcc00;
}

.number-pool {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: center;
  margin-bottom: 20px;
}

.number-button {
  width: 50px;
  height: 50px;
  border-radius: 50%;
  font-size: 1.2em;
  display: flex;
  align-items: center;
  justify-content: center;
  background-color: #4caf50;
  color: white;
  cursor: pointer;
  transition: transform 0.2s;
}

.number-button:hover {
  transform: scale(1.1);
}

.user-order {
  display: flex;
  gap: 10px;
  justify-content: center;
  margin: 20px 0;
  flex-wrap: wrap;
}

.ordered-number, .empty-slot {
  width: 50px;
  height: 50px;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2em;
  font-weight: bold;
}

.ordered-number {
  background-color: #ff6b6b;
  color: white;
  cursor: pointer;
  transition: transform 0.2s;
}

.ordered-number:hover {
  transform: scale(1.1);
}

.empty-slot {
  border: 2px dashed #ccc;
  color: #ccc;
}

.action-buttons {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

.reset-btn {
  background-color: #ff6b6b;
}

.check-btn {
  background-color: #4caf50;
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
