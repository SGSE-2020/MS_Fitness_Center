<template>
  <div>
    <h3> {{ devicename }}</h3>
    <p> {{ devicedescription }} </p>
    <b>Muskeln:</b>
    <ul>
      <li v-for="mus in devicemuscle" :key=mus.name> {{ mus.name }} </li>
    </ul>
    <p>Standort(e): <i><span v-for="loc in devicelocs" :key=loc.name>{{ loc.name }}<span v-if="loc.name != devicelocs[devicelocs.length-1].name">, </span> </span></i> </p>
    <hr v-if="devicedivider" class="divider">
  </div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'Device', //this is the name of the component
  props: {
      devicename: String,
      devicedescription: String,
      devicemuscle: Array,
      devicelocs: Array,
      devicedivider: Boolean
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
  ul {
      margin-top: 5px;
      margin-bottom: 5px;
  }
</style>