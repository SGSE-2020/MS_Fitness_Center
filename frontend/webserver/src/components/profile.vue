<template>
  <div class="contentdiv">
    <h1>Profil</h1>
    <h2>Persönliche Daten</h2>
    <i>Die folgenden persönlichen Daten stammen aus dem Bürgerbüro und können an dieser Stelle nicht gändert werden!</i>
    <table>
      <tr>
        <td>Name:</td><td>{{ userdata.personal_data.name }}</td>
      </tr>
      <tr>
        <td>Geburtstag:</td><td>{{ userdata.personal_data.birthday }}</td>
      </tr>
      <tr>
        <td>Tel.:</td><td>{{ userdata.personal_data.tel }}</td>
      </tr>
      <tr>
        <td>E-mail:</td><td>{{ userdata.personal_data.mail }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import api_config from '../../config/api_config'

export default {
  name: 'Profile',
  data() {
    return {userdata: []}
  },
  created() {
    fetch(new String("http://").concat(api_config.url, ':', api_config.port, "/personal_data/1"))
      .then(response => response.json())
      .then(json => {
        this.userdata = json
      })
  }
}

</script>
<style scoped>
i {
  font-size: 10;
}
table {
  border-collapse: collapse;
  width: 100%;
  margin-top: 20px;
}
tr {
  padding: 8px;
}
</style>