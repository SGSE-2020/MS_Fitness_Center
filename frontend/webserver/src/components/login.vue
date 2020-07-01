<template>
  <div class="contentdiv">
    <h1>Anmelden</h1>
    <tr>
    <input placeholder="E-Mail" v-model="name">
    </tr>
    <tr>
    <input type="password" placeholder="Password" v-model="pw">
    </tr>
    <button v-on:click="login">Anmelden</button>
  </div>
</template>

<script>
import firebase from 'firebase'
import firebase_config from '../../config/firebase_config'
import router from '../router'
import api_config from '../../config/api_config'

export default {
  name: "Login",
  data() {
    return {
      name: "",
      pw: "",
      email: null
    }
  },
  methods: {
    login: function (event) {
      if (this.name.length > 0 && this.pw.length > 0) {
        firebase.auth().signInWithEmailAndPassword(this.name, this.pw).then(function(user) {
          console.log(firebase.auth().currentUser);

          fetch(api_config.url.concat('/personal_data/' + String(firebase.auth().currentUser.uid)))
            .then(response => response.json()).then(res => {
              if (res.id != -1) {
                firebase.auth().currentUser.getIdToken(true).then(function(idToken) {
                    //Token zu Bürgerbüro senden -> Uid zurückbekommen -> Dann User validiert
                    //alert("Token ist:" + idToken);
                    fetch(api_config.url.concat("/role/" + firebase.auth().currentUser.uid))
                    .then(response => response.json())
                    .then(json => {
                      console.log("userrole:", json)
                    })

                    router.push('/home')
                }).catch(function(error) {
                    console.log(error);
                });
              } else {
                firebase.auth().signOut().then(function() {
                  alert("user nicht vorhanden")
                })
              }
            })
        }, function(error) {
            if(error.code == "auth/invalid-email" || error.code == "auth/wrong-password" || error.code == "auth/user-not-found"){
                alert("E-Mail oder Passwort falsch oder User existiert nicht");
            } else if(error.code == "auth/user-disabled"){
                alert("Dieser Nutzer ist deaktiviert");
            } else {
                alert(error);
            }
        })
      } else {
        alert("Alle daten eingeben");
      }

      // add validation
      // `event` is the native DOM event
      if (event && name.length > 0 && pw.length > 0 && !event) {
        router.push('/profile')
      }
    }
  }
}
</script>

<style scoped>
input {
    margin-bottom: 16px;
}
</style>