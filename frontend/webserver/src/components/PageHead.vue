<template>
  <div id="header">
      <img id="img" alt="Banner" src="../assets/banner.png">
      <nav class="navigation">
        <router-link class="elems" v-for="routes in links" v-bind:key="routes.id" :to="`${routes.page}`">{{routes.text}}</router-link>
      </nav>
    </div>
</template>

<script>
export default {
  name: 'PageHead',
  data() {
      return {
      links: [
        {
          id: 0,
          text: 'Home',
          page:'/home'
        },
        {
          id: 1,
          text: 'Geräte',
          page:'/devices'
        },
        {
          id: 2,
          text: 'Kurse',
          page:'/courses'
        },
        {
          id: 3,
          text: 'Abos',
          page:'/abo'
        }
      ]
    }
  }
}
</script>

<style scoped>
  #img {
    max-width:100%;
    height:auto;
    margin: 0;
  }
  .navigation {
    margin-top: -4px;
    width: 100%;
    background-color: #555;
    overflow: auto;
    position: sticky;
  }
  .navigation .elems {
    float: left;
    padding-top: 12px;
    padding-bottom: 12px;
    color: white;
    text-decoration: none;
    font-size: 17px;
    width: 25%; /* Four equal-width links. If you have two links, use 50%, and 33.33% for three links, etc.. */
    text-align: center; /* If you want the text to be centered */
  }
  .navigation .elems:hover {
    background-color: #000;
  }
  .navigation .elems.router-link-active {
    background-color: #4CAF50;
  }

</style>
