<template>
<div id="overall">
  <div class="contentdiv">
    <div id="hold_buttons">
      <button v-on:click="requestTP">Neuer Trainingsplan</button>
      <button v-on:click="requestT">Behandlung</button>
    </div>
    <h1>Profil</h1>
    <h2>Persönliche Daten</h2>
    <i>Die folgenden persönlichen Daten stammen aus dem Bürgerbüro und können an dieser Stelle nicht gändert werden!</i>
    <table>
      <tr>
        <td>Name:</td><td>{{ userdata.personal_data.name }}</td>
      </tr>
      <tr>
        <td>Geburtstag:</td><td>{{ userdata.personal_data.birthday }}</td>
      </tr>
      <tr>
        <td>Tel.:</td><td>{{ userdata.personal_data.tel }}</td>
      </tr>
      <tr>
        <td>E-mail:</td><td>{{ userdata.personal_data.mail }}</td>
      </tr>
    </table>

    <h2>Physiologische Daten</h2>
    <table>
      <tr>
        <td>Größe:</td><td>{{ userdata.physical_data.height }}</td>
      </tr>
      <tr>
        <td>Gewicht:</td><td>{{ userdata.physical_data.weight }}</td>
      </tr>
      <tr>
        <td>Leistungsniveau:</td><td>{{ userdata.physical_data.performance_level }}</td>
      </tr>
      <tr>
        <td>Aktivitäten:</td><td>{{ userdata.physical_data.other_activitys }}</td>
      </tr>
      <tr>
        <td>Erkrankungen:</td><td>{{ userdata.physical_data.diseases }}</td>
      </tr>
      <tr>
        <td>Ziel:</td><td>{{ userdata.physical_data.goal }}</td>
      </tr>
      <tr>
        <td>Verfügbare Zeit:</td><td>{{ userdata.physical_data.aviable_time }}</td>
      </tr>
    </table>

    <h2>Abo Infotmationen</h2>
    <table>
      <tr>
        <td>Abo:</td><td>{{ userdata.abo_information.abo.name }}</td>
      </tr>
      <tr>
        <td>Startdatum:</td><td>{{ userdata.abo_information.abo_start }}</td>
      </tr>
      <tr>
        <td>Kosten:</td><td>{{ userdata.abo_information.abo.costs }}</td>
      </tr>
      <tr>
        <td>Laufzeit:</td><td>{{ userdata.abo_information.abo.term }}</td>
      </tr>
    </table>
    <router-link id="edit" to='/profile/edit'>
      <img src="../assets/bearbeiten.svg">
    </router-link>
    <br>
  </div>
</div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'

export default {
  name: 'Profile',
  data() {
    return {userdata: []}
  },
  created() {
    fetch(api_config.url.concat("/personal_data/1"))
      .then(response => response.json())
      .then(json => {
        this.userdata = json
      })
  },
  methods: {
    requestTP: function (event) {
      router.push('/trainingplan/request')
    },
    requestT: function (event) {
      router.push('/treatment/request')
    }
  }
}

</script>
<style scoped>
i {
  font-size: 10;
}
table {
  border-collapse: collapse;
  width: 100%;
  margin-top: 20px;
}
td {
  width: 50%;
}
tr {
  padding: 8px;
}
#overall {
    position: relative;
}
#edit {
  width: 50px;
  height: 50px;
  position: absolute; top:10px; right:15px;
}
#edit img {
  width: 50px;
  height: 50px;
} 
#hold_buttons {
  float: right;
}
#hold_buttons button {
  width: 170px;
}
</style>