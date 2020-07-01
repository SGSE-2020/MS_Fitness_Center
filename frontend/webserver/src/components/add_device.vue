<template>
  <div class="contentdiv">
    <h1>Gerät einfügen</h1>
    <table>
      <tr>
        <td>Name:</td>
        <td><input v-model="name" placeholder="Name"> </td>
      </tr>
      <tr>
        <td>Beschreibung:</td>
        <td><input v-model="description" placeholder="Beschreibung"> </td>
      </tr>
    </table>
    <button id="conf" v-on:click="confirm">Bestätigen</button>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'

export default {
  name: 'AddDevice',
  data() {
    return {
      name: null,
      description: null
    }
  },
  created() {
    // fetch muscles
    /*fetch(api_config.url.concat("/abo"))
      .then(response => response.json())
      .then(json => {
        this.all_abos = json
        console.log(this.all_abos)
      })*/
  },
  methods: {
    confirm: function (event) {
      // add validation
      console.log(event)
      if (this.name != null && this.description != null) {
        console.log(JSON.stringify({name: this.name, description: this.description}))
        /*fetch(api_config.url.concat("/members/add"), {
          method: "POST",
          body: JSON.stringify({uid: this.uuid, role: this.role, abo_id: this.abo, abo_start: this.date})
        }).then(res => res.json()).then(data => {
          alert('Antrag erfolgreich abgeschickt: ' + data.message)
          router.push('/members')
            // `event` is the native DOM event
        }).catch((error) => {
          console.error(error)
          alert('Ein Problem ist aufgetreten')
        })*/
      } else {
        alert('Name und Beschreibung eingeben!')
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