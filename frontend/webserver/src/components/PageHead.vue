<template>
  <div id="header">
    <div id="container">
      <img id="img" alt="Banner" src="../assets/banner.png">
      <span id="dName" v-if="displayName != ''"> Angemeldet als {{ displayName }} </span>
      <router-link v-if="!customer" id="multiusericon" to='/members'>
        <img src="../assets/maenner.svg">
      </router-link>
      <router-link id="usericon" :to='profile_route'>
        <img src="../assets/benutzer.svg">
      </router-link>
    </div>
    <nav class="navigation">
      <router-link class="elems" v-for="routes in links" v-bind:key="routes.id" :to="`${routes.page}`">{{routes.text}}</router-link>
    </nav>
    </div>
</template>

<script>
import firebase from 'firebase'
import firebase_config from '../../config/firebase_config'
import api_config from '../../config/api_config'

export default {
  name: 'PageHead',
  data() {
    return {
      profile_route: '/login',
      displayName: '',
      customer: true,
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
      ],
    }
  },
  created() {

    firebase.auth().onAuthStateChanged((user) => {
      if (user == null) {
        this.profile_route = '/login'
        this.displayName = ''
        this.customer = true
      } else {
        this.profile_route = '/profile'
        this.displayName = user.displayName

        fetch(api_config.url.concat("/role/" + firebase.auth().currentUser.uid))
        .then(response => response.json())
        .then(json => {
          this.customer = 0 == json["role"]
          console.log("userrole:", this.customer )
        })
      }
    })
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
  #dName {
    float: right;
    position: absolute; bottom:15px; right:140px;
    color: white
  }
</style>
