<template>
  <div id="app">
    <!--img alt="Vue logo" src="./assets/logo.png"-->
    <puzzle-8 msg="Puzzle8 con A*"/>
  </div>
</template>

<script>
import puzzle8 from './components/puzzle8.vue'

export default {
  name: 'App',
  components: {
    puzzle8
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
