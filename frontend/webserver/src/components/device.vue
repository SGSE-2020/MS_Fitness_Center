<template>
  <div class="device">
    <div class="header">
      <h3> {{ devicename }} <img v-if="deleteBut" src="../assets/muell.svg" id="delete" v-on:click='deleteDevice'></h3>
    </div>
    <p> {{ devicedescription }} </p>
    <b>Muskeln:</b>
    <ul v-if="devicemuscle.length != 0">
      <li v-for="mus in devicemuscle" :key=mus.name> {{ mus.name }} </li>
    </ul>
    <p>Standort(e): <i><span v-for="loc in devicelocs" :key=loc.name>{{ loc.name }}<span v-if="loc.name != devicelocs[devicelocs.length-1].name">, </span> </span></i> </p>
    <hr v-if="devicedivider" class="divider">
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import Vue from 'vue'
          //Vue.forceUpdate();

export default {
  name: 'Device', //this is the name of the component
  props: {
    deviceid: Number,
    devicename: String,
    devicedescription: String,
    devicemuscle: Array,
    devicelocs: Array,
    devicedivider: Boolean,
    deleteBut: Boolean
  },
  methods: {
    deleteDevice: function() {
      if(confirm('Wollen Sie das Gerät wirklich löschen?')) {
        fetch(api_config.url.concat("/device/" + String(this.deviceid)), {
          method: "DELETE",
        }).then(res => {
          alert('Device gelöscht')
          this.$parent.removedevice(this.deviceid);
            // `event` is the native DOM event
        }) 
      }
    }
  }, 
}

</script>
<style scoped>
  #delete {
    width: 20px;
  }
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