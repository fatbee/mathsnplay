<script setup>
import { ref } from 'vue';
import HomePage from './components/HomePage.vue';
import AdditionGame from './components/AdditionGame.vue';
import MultiplicationGame from './components/MultiplicationGame.vue';
import NumberOrderingGame from './components/NumberOrderingGame.vue';

const currentPage = ref('home');

const navigateTo = (page) => {
  currentPage.value = page;
};
</script>

<template>
  <header>
    <h1 class="app-title">Math Playground</h1>
    <nav>
      <button @click="navigateTo('home')">Home</button>
      <button @click="navigateTo('addition')">Addition Game</button>
      <button @click="navigateTo('multiplication')">Multiplication Game</button>
      <button @click="navigateTo('ordering')">Number Ordering</button>
    </nav>
  </header>

  <main>
    <HomePage v-if="currentPage === 'home'" @navigate="navigateTo" />
    <AdditionGame v-if="currentPage === 'addition'" />
    <MultiplicationGame v-if="currentPage === 'multiplication'" />
    <NumberOrderingGame v-if="currentPage === 'ordering'" />
  </main>

  <footer>
    <p>Math Playground - Fun Math for Primary School Students</p>
  </footer>
</template>

<style scoped>
header {
  padding: 1rem;
  background-color: #ffcc00;
  border-radius: 0 0 20px 20px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-bottom: 2rem;
}

.app-title {
  color: #ff6b6b;
  text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
  font-size: 2.5rem;
  margin-bottom: 1rem;
}

nav {
  display: flex;
  gap: 10px;
  flex-wrap: wrap;
  justify-content: center;
}

main {
  padding: 1rem;
  min-height: 60vh;
}

footer {
  margin-top: 2rem;
  padding: 1rem;
  background-color: #ffcc00;
  border-radius: 20px 20px 0 0;
  color: #333;
  font-weight: bold;
}
</style>
