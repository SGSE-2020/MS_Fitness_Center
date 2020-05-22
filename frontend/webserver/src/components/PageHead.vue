<template>
  <div id="header">
    <div id="container">
      <img id="img" alt="Banner" src="../assets/banner.png">
      <router-link id="multiusericon" to='/members'>
        <img src="../assets/maenner.svg">
      </router-link>
      <router-link id="usericon" to='/profile'>
        <img src="../assets/benutzer.svg">
      </router-link>
    </div>
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
        page: '/home'
      },
      {
        id: 1,
        text: 'Geräte',
        page: '/devices'
      },
      {
        id: 2,
        text: 'Kurse',
        page: '/courses'
      },
      {
        id: 3,
        text: 'Abos',
        page: '/abo'
       }
      ]
    }
  }
}
</script>

<style scoped>
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


  #container {
    position: relative;
  }
  #img {
    max-width:100%;
    height:auto;
    margin: 0;
    display: block; 
  }
  #multiusericon {
    width: 50px;
    height: 50px;
    position: absolute; bottom:10px; right:70px;
  }
  #usericon {
    width: 40px;
    height: 40px;
    position: absolute; bottom:15px; right:15px;
  }
</style>
