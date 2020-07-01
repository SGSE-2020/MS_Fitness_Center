<template>
  <div class="contentdiv" :key="">
    <h1>Geräte</h1>
    <Device v-for="dev in alldevices" :key=dev.id
      :deviceid="dev.id"
      :devicename=dev.name 
      :devicedescription=dev.description 
      :devicemuscle=dev.muscles 
      :devicelocs=dev.locations 
      :devicedivider="(dev!=alldevices[alldevices.length-1])"
      :deleteBut="!customer"/>
    <span v-if="alldevices.length === 0">
      Keine Geräte bekannt
    </span>
  </div>
</template>

<script>
import firebase, { functions } from 'firebase'
import firebase_config from '../../config/firebase_config'
import api_config from '../../config/api_config'
import Device from './device.vue'

export default {
  name: 'Devices',
  components: {
    'Device': Device
  },
  data() {
    return {
      reload: 0,
      alldevices: [],
      customer: true
    }
  },
  created() {
    if (firebase.auth().currentUser == null) {
      this.customer = true
    } else {
      fetch(api_config.url.concat("/role/" + firebase.auth().currentUser.uid))
      .then(response => response.json())
      .then(json => {
        this.customer = 0 == json["role"]
      })
    }
    fetch(api_config.url.concat("/devices"))
      .then(response => response.json())
      .then(json => {
        this.alldevices = json
        this.reload = this.alldevices.length
      })
  },
  methods: {
    removedevice: function(id) {
      var idx = 0
      for (var i = 0; i < this.alldevices.length; i++) {
        if (this.alldevices[i].id == id) {
          idx = i
        }
      }
      this.alldevices.splice(idx, 1)
      this.reload = this.alldevices.length
    }
  }
}
</script>
<style scoped>
</style>