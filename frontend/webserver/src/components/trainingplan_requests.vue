<template>
<div id="overall">
  <div class="contentdiv">
    <h1> Trainingplananfragen </h1>
    <table>
      <tr>
        <th>Name</th><th>Tag</th><th class="rightelem">Erledigt</th>
      </tr>
      <tr class="bodytr" v-for="request in requests" :key="request.id">
        <td> {{ request.name }} </td><td> {{request.day}} </td><td class="rightelem"><img src="../assets/richtig.svg"></td>
      </tr>
    </table>
  </div>
</div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'TrainingplanRequest',
  data() {
    return {requests: []}
  },
  created() {
    console.log("right file")
    fetch(api_config.url.concat("/requests/trainingplan"))
      .then(response => response.json())
      .then(json => {
        this.requests = json
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

td, th {
  border: 1px solid #ddd;
  padding: 8px;
}

.rightelem {
    width: 10%;
    text-align: center;
}
img {
    height: 20px;
    width: 20px;
}

</style>