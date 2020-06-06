<template>
<div id="overall">
  <div class="contentdiv">
    <h1> Mitglieder </h1>
    <table>
      <tr>
        <th>Name</th><th>Rolle</th>
      </tr>
      <tr class="bodytr" v-for="member in members" :key="member.id">
        <td> {{ member.name }} </td><td> {{ roles[parseInt(member.role)] }} </td>
      </tr>
    </table>
    
    <router-link id="adduser" to='/members/add'>
      <img src="../assets/kontakt.svg">
    </router-link>
    <router-link id="trainingplan" to='/requests/trainingplan'>
      <img src="../assets/ausbildung.svg">
    </router-link>
    <router-link id="treatment" to='/requests/treatment'>
      <img src="../assets/stethoskop.svg">
    </router-link>
  </div>
</div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'Members',
  data() {
    return {
      members: [],
      roles: ['Kunde', 'Trainer', 'Physio']
    }
  },
  created() {
    fetch(new String("http://").concat(api_config.url, "/members"))
      .then(response => response.json())
      .then(json => {
        this.members = json
      })
  }
}

</script>
<style scoped>

table {
  border-collapse: collapse;
  width: 100%;
}

tr:nth-child(odd){
  background-color: #f2f2f2;
}

.bodytr:hover {
  background-color: #ddd;
}

td, th {
  border: 1px solid #ddd;
  padding: 8px;
}
#adduser {
  width: 50px;
  height: 50px;
  position: absolute; top:10px; right:15px;
}
#trainingplan {
  width: 50px;
  height: 50px;
  position: absolute; top:70px; right:18px;
}
#treatment {
  width: 50px;
  height: 50px;
  position: absolute; top:130px; right:15px;
}
img {
  width: 50px;
  height: 50px;
}
#overall {
    position: relative;
}

</style>