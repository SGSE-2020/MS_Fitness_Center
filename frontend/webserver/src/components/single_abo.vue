<template>
  <div>
    <h3> {{ aboname }}</h3>
    <p> {{ abodescription }} </p>
    <p><i>Monatliche Kosten: {{ abocost }}€ </i></p>
    <p id="end"><i>Mindest Laufzeit: {{ aboterms }} Monat(e) </i></p>
    <hr v-if="abodivider" class="divider">
  </div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'SingleAbo',
  props: {
      aboname: String,
      abodescription: String,
      abocost: Number,
      aboterms: Number,
      abodivider: Boolean
  }
}

</script>
<style scoped>
  h3 {
      margin-bottom: 5px;
  }
  p {
      margin-top: 0;
      margin-bottom: 5px;
  }
  #end{
      margin-bottom: 18px;
  }
</style>