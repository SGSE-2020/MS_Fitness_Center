<template>
  <div class="contentdiv">
    <h1>Geräte</h1>
    <Device v-for="dev in alldevices" :key=dev.name 
      :devicename=dev.name 
      :devicedescription=dev.description 
      :devicemuscle=dev.muscles 
      :devicelocs=dev.locations 
      :devicedivider="(dev!=alldevices[alldevices.length-1])"/>
    <span v-if="alldevices.length === 0">
      Keine Geräte bekannt
    </span>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import Device from './device.vue'

export default {
  name: 'Devices',
  components: {
    'Device': Device
  },
  data() {
    return {alldevices: []}
  },
  created() {
    fetch(new String("http://").concat(api_config.url, ':', api_config.port, "/devices"))
      .then(response => response.json())
      .then(json => {
        this.alldevices = json
      })
  }
}
</script>
<style scoped>
</style>