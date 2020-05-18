<template>
  <div>
    <h3> {{ locname }}</h3>
    <p> {{ locdescription }} </p>
    <p> <i>{{ locstreet }}<br />{{ locplace }}</i></p>
  </div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'Home', //this is the name of the component
  props: {
      locname: String,
      locdescription: String,
      locstreet: String,
      locplace: String,
  }
}

</script>
<style scoped>
  h3 {
      margin-bottom: 10px;
  }
  p {
      margin-bottom: 10px;
  }
</style>