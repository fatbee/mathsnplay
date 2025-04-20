<script setup>
import { defineEmits } from 'vue';

const emit = defineEmits(['navigate']);

const navigateToGame = (game) => {
  emit('navigate', game);
};
</script>

<template>
  <div class="home-container">
    <h2>Welcome to Math Playground!</h2>
    <p class="intro-text">
      A fun place to learn and practice math for primary school students.
      Choose a game below to start playing and learning!
    </p>

    <div class="math-container">
      <div class="game-card" @click="navigateToGame('addition')">
        <h3 class="game-title">Addition Adventure</h3>
        <p class="game-description">
          Practice your addition skills with fun problems!
        </p>
        <div class="game-preview">2 + 3 = ?</div>
        <button>Play Now</button>
      </div>

      <div class="game-card" @click="navigateToGame('multiplication')">
        <h3 class="game-title">Multiplication Mania</h3>
        <p class="game-description">
          Master your multiplication tables with exciting challenges!
        </p>
        <div class="game-preview">5 × 6 = ?</div>
        <button>Play Now</button>
      </div>

      <div class="game-card" @click="navigateToGame('ordering')">
        <h3 class="game-title">Number Ordering</h3>
        <p class="game-description">
          Put numbers in the correct order from smallest to largest!
        </p>
        <div class="game-preview">7, 2, 9, 4, 1</div>
        <button>Play Now</button>
      </div>
    </div>
  </div>
</template>

<style scoped>
.home-container {
  text-align: center;
}

.intro-text {
  max-width: 600px;
  margin: 0 auto 30px;
  font-size: 1.2em;
  color: #555;
}

.game-preview {
  font-size: 1.5em;
  font-weight: bold;
  margin: 15px 0;
  padding: 10px;
  background-color: rgba(255, 255, 255, 0.7);
  border-radius: 10px;
}
</style>
