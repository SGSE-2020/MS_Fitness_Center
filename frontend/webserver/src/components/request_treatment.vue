<template>
  <div class="contentdiv">
    <h1>Behandlungsantrag</h1>
      <table>
      <tr>
        <td>Datum:</td><td><input type="date" v-model="date"></td>
      </tr>
      <tr>
        <td>Note:</td><td><input v-model="note" :placeholder="Notiz"></td>
      </tr>
    </table>
    <button id="conf" v-on:click="confirm">Bestätigen</button>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'

export default {
  name: "RequestTreatment",
  data() {
    return {
      date: null,
      note: null
    }
  },
  methods: {
    confirm: function (event) {
      // add validation
      console.log(event)
      if (this.date != null) {
        fetch(api_config.url.concat("/requests/treatment"), {
          method: "POST",
          body: JSON.stringify({id: 1, note: this.note, date: this.date})
        }).then(res => {
          alert('Antrag erfolgreich abgeschickt')
            // `event` is the native DOM event
        })
      } else {
          alert('Datum eingeben!')
      }
      if (event && this.date != null) {
        router.push('/profile')
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