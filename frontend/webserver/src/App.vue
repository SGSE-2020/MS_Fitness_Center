<template>
  <div id="app">
    <PageHead />
    <router-view />
  </div>
</template>

<script>
import PageHead from './components/PageHead.vue'

export default {
  name: 'App',
  components: {
    'PageHead': PageHead
  }
}
</script>

<style>

#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  width: 100%;
  margin: 0 auto
}
body {
  margin: 0;
}
.contentdiv {
  width: 40%;
  text-align: left;
  margin: 0 auto
}
.divider{
  border: 0;
  height: 1px;
  background-image: linear-gradient(to right, rgba(0, 0, 0, 0), rgba(0, 0, 0, 0.75), rgba(0, 0, 0, 0));
}

</style>
