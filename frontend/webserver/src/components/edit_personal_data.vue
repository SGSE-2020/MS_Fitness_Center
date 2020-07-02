<template>
  <div class="contentdiv">
    <h1>Profil bearbeiten</h1>

    <h2>Physiologische Daten</h2>
    <table>
      <tr>
        <td>Größe:</td><td><input v-model="userdata.physical_data.height" :text="userdata.physical_data.height"></td>
      </tr>
      <tr>
        <td>Gewicht:</td><td><input v-model="userdata.physical_data.weight" :text="userdata.physical_data.weight"></td>
      </tr>
      <tr>
        <td>Leistungsniveau:</td><td><input v-model="userdata.physical_data.performance_level" :text="userdata.physical_data.performance_level"></td>
      </tr>
      <tr>
        <td>Aktivitäten:</td><td><input v-model="userdata.physical_data.other_activitys" :text="userdata.physical_data.other_activitys"></td>
      </tr>
      <tr>
        <td>Erkrankungen:</td><td><input v-model="userdata.physical_data.diseases" :text="userdata.physical_data.diseases"></td>
      </tr>
      <tr>
        <td>Ziel:</td><td><input v-model="userdata.physical_data.goal" :text="userdata.physical_data.goal"></td>
      </tr>
      <tr>
        <td>Verfügbare Zeit:</td><td><input v-model="userdata.physical_data.aviable_time" :text="userdata.physical_data.aviable_time"></td>
      </tr>
    </table>
    <button id="conf" v-on:click="confirm">Bestätigen</button>
    <br>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'
import firebase from 'firebase'
import firebase_config from '../../config/firebase_config'

export default {
  name: 'EditPersonalData',
  data() {
    return {
      userdata: {
        personal_data: {
          name: '-',
          birthday: '-',
          tel: 0,
          mail: '-'
        },
        physical_data: {
          height: 0,
          weight: 0,
          performance_level: 0,
          other_activitys: '-',
          diseases: '-',
          goal: '-',
          aviable_time: 0,
        },
        abo_information: {
          abo: { 
            name: '-',
            costs: 0,
            term: 0
          },
          abo_start: '-'
        }
      },
      id: -1,
      ownUser: false
    }
  },
  created() {
    var id = firebase.auth().currentUser.uid
    fetch(api_config.url.concat("/personal_data/" + id))
      .then(response => response.json())
      .then(json => {
        this.userdata = json
      })
  },
  methods: {
    confirm: function (event) {
      firebase.auth().currentUser.getIdToken(true).then(idToken => {
        fetch(api_config.url.concat("/personal_data"), {
            method: "POST",
            body: JSON.stringify({
              height: this.userdata.physical_data.height,
              weight: this.userdata.physical_data.weight,
              performance_level: this.userdata.physical_data.performance_level,
              other_activitys: this.userdata.physical_data.other_activitys,
              diseases: this.userdata.physical_data.diseases,
              goal: this.userdata.physical_data.goal,
              time_aviability: this.userdata.physical_data.aviable_time,
              token: idToken, // TODO: token for authentification
              id: firebase.auth().currentUser.uid //TODO get id
            })}).then(res => {
            alert('Antrag erfolgreich abgeschickt')
            router.push('/profile')
              // `event` is the native DOM event
          }).catch(function() {
            alert('There was a problem')
        })
    });
    }
  }
}

</script>
<style scoped>
table {
  border-collapse: collapse;
  width: 100%;
  margin-top: 20px;
}
td {
  width: 50%;
  border-width: 2px;
}
tr {
  padding-top: 8px;
  padding-bottom: 8px;
}
#conf {
    float: right;
}
input {
    width: 96%;
}
</style>