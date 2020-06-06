<template>
  <div class='contentdiv'>
    <h1> {{ title }}</h1>
    <p v-html='message'></p>
    <hr class='divider'>
    <h1>Standorte</h1>
    <Location v-for='loc in locations' :key=loc.id :locname=loc.name :locdescription=loc.description :locstreet=loc.street :locplace=loc.place />
    <span v-if='locations.length === 0'>
      Keine Standorte bekannt
    </span>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import Location from './location.vue'

export default {
  name: 'Home',
  components: {
    'Location': Location
  },
  data() {
    return {
      title: '',
      message: '',
      locations: []
    }
  },
  created() {
    fetch(new String('http://').concat(api_config.url, '/welcome'))
      .then(response => response.json())
      .then(json => {
        this.title = json.title
        this.message = json.text.split('\\n').join('<br />')
      })

    fetch(new String('http://').concat(api_config.url, '/locations'))
      .then(response => response.json())
      .then(json => {
        this.locations = json
      })
  }
}

</script>
<style scoped>

  p {
    margin-bottom: 20px;
  }
</style>
