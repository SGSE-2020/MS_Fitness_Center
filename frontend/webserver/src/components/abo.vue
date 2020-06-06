<template>
  <div class="contentdiv">
    <h1>Abonnement</h1>
    <SingleAbo v-for="abo in abos" :key=abo.name 
      :aboname=abo.name
      :abodescription=abo.description
      :abocost=abo.costs
      :aboterms=abo.terms
      :abodivider="(abo!=abos[abos.length-1])"/>
    <span v-if="abos.length === 0">
      Keine Geräte bekannt
    </span>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import SingleAbo from './single_abo.vue'

export default {
  name: 'Abo',
  components: {
    'SingleAbo': SingleAbo
  },
  data() {
    return {
      abos: []
    }
  },
  created() {
    fetch(new String("http://").concat(api_config.url, "/abo"))
      .then(response => response.json())
      .then(json => {
        this.abos = json
      })
  }
}
</script>
<style scoped>
</style>