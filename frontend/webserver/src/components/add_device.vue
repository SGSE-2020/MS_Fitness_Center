<template>
  <div class="contentdiv">
    <h1>Gerät einfügen</h1>
    <table>
      <tr>
        <td>Name:</td>
        <td><input class="textIn" v-model="name" placeholder="Name"> </td>
      </tr>
      <tr>
        <td>Beschreibung:</td>
        <td><input class="textIn" v-model="description" placeholder="Beschreibung"> </td>
      </tr>
    </table>
    <p>Muskeln</p>
    <div v-for="muscle in muscles" :key="muscle.id*179">
        <input type="checkbox" :id="muscle.id" :value="muscle.id" v-model="checkedMuscles">
        <label :for="muscle.id"> {{muscle.name}} </label>
    </div>
    <p>Standorte</p>
    <div v-for="location in locations" :key="location.id*181">
        <input type="checkbox" :id="location.id" :value="location.id" v-model="checkedLocations">
        <label :for="location.id"> {{location.name}} </label>
    </div>   
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
      description: null,
      checkedMuscles: [],
      checkedLocations: [],
      muscles: null,
      locations: null
    }
  },
  created() {
    // fetch muscles
    fetch(api_config.url.concat("/muscles"))
      .then(response => response.json())
      .then(json => {
        this.muscles = json
      })

    fetch(api_config.url.concat("/locations"))
      .then(response => response.json())
      .then(json => {
        this.locations = json
      })
  },
  methods: {
    confirm: function (event) {
      // add validation
      console.log(event)
      if (this.name != null && this.description != null) {
        console.log(JSON.stringify({name: this.name, description: this.description, muscles: this.checkedMuscles, locations: this.checkedLocations}))
        fetch(api_config.url.concat("/device"), {
          method: "POST",
          body: JSON.stringify({name: this.name, description: this.description, muscles: this.checkedMuscles, locations: this.checkedLocations})
        }).then(res => res.json()).then(data => {
          alert('Gerät erfolgreich eingefügt: ' + data.message)
          router.push('/devices')
            // `event` is the native DOM event
        }).catch((error) => {
          console.error(error)
          alert('Ein Problem ist aufgetreten')
        })
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
.textIn {
    width: 96%;
}
.checkbox {
    width: 50%;
}
select {
    width: 100%;
}
#conf {
    float: right;
}
</style>