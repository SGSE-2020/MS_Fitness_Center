<template>
  <div class="contentdiv">
    <h1>Mitglied einfügen</h1>
    <table>
      <tr>
        <td>UserID:</td>
        <td><input v-model="uuid" placeholder="UUID"> </td>
      </tr>
      <tr>
        <td>Rolle:</td>
        <td>
          <select v-model="role">
            <option value="" selected disabled>Please select one</option>
            <option value="1">Kunde</option>
            <option value="2">Trainer</option>
            <option value="3">Physiotherapeut</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>Abo:</td>
        <td>
          <select v-model="abo">
            <option value="" selected disabled>Please select one</option>
            <option v-for="single_abo in all_abos" :key="single_abo.id" :value="single_abo.id">{{ single_abo.name }}</option>
          </select>
        </td>
      </tr>
    </table>
    <button id="conf" v-on:click="confirm">Bestätigen</button>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'

export default {
  name: 'AddMember',
  data() {
    return {
      uuid: None,
      role: "",
      abo: "",
      all_abos: []
    }
  },
  created() {
    fetch(new String("http://").concat(api_config.url, "/abo"))
      .then(response => response.json())
      .then(json => {
        this.all_abos = json
        console.log(this.all_abos)
      })
  },
  methods: {
    confirm: function (event) {
      // add validation
      alert('Änderungen erfolgreich engefügt')
      // `event` is the native DOM event
      if (event) {
        router.push('/members')
      }
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
    padding-bottom: 16px;
}
input {
    width: 96%;
}
select {
    width: 100%;
}
#conf {
    float: right;
}
</style>