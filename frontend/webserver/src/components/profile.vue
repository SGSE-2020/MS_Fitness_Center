<template>
<div id="overall">
  <div class="contentdiv">
    <div id="hold_buttons">
      <button v-if="ownUser" v-on:click="requestTP">Neuer Trainingsplan</button>
      <button v-if="ownUser" v-on:click="requestT">Behandlung</button>
      <button v-if="ownUser" v-on:click="logout">Abmelden</button>
    </div>
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

    <h2>Physiologische Daten</h2>
    <table>
      <tr>
        <td>Größe:</td><td>{{ userdata.physical_data.height }}</td>
      </tr>
      <tr>
        <td>Gewicht:</td><td>{{ userdata.physical_data.weight }}</td>
      </tr>
      <tr>
        <td>Leistungsniveau:</td><td>{{ userdata.physical_data.performance_level }}</td>
      </tr>
      <tr>
        <td>Aktivitäten:</td><td>{{ userdata.physical_data.other_activitys }}</td>
      </tr>
      <tr>
        <td>Erkrankungen:</td><td>{{ userdata.physical_data.diseases }}</td>
      </tr>
      <tr>
        <td>Ziel:</td><td>{{ userdata.physical_data.goal }}</td>
      </tr>
      <tr>
        <td>Verfügbare Zeit:</td><td>{{ userdata.physical_data.aviable_time }}</td>
      </tr>
    </table>

    <h2>Abo Informationen</h2>
    <table>
      <tr>
        <td>Abo:</td><td>{{ userdata.abo_information.abo.name }}</td>
      </tr>
      <tr>
        <td>Startdatum:</td><td>{{ userdata.abo_information.abo_start }}</td>
      </tr>
      <tr>
        <td>Kosten:</td><td>{{ userdata.abo_information.abo.costs }}</td>
      </tr>
      <tr>
        <td>Laufzeit:</td><td>{{ userdata.abo_information.abo.term }}</td>
      </tr>
    </table>
    <router-link v-if="ownUser" id="edit" to='/profile/edit'>
      <img src="../assets/bearbeiten.svg">
    </router-link>
      <img v-if="!ownUser" src="../assets/muell.svg" id="delete" v-on:click='deleteMember'>
    <br>
  </div>
</div>
</template>

<script>
import api_config from '../../config/api_config'
import router from '../router'
import firebase from 'firebase'
import firebase_config from '../../config/firebase_config'

export default {
  name: 'Profile',
  data() {
    return {
      userdata: {
        personal_data: {
          name: '-',
          birthday: '-',
          tel: 0,
          mail: '-'
        },
        physical_data: {
          height: 0,
          weight: 0,
          performance_level: 0,
          other_activitys: '-',
          diseases: '-',
          goal: '-',
          aviable_time: 0,
        },
        abo_information: {
          abo: { 
            name: '-',
            costs: 0,
            term: 0
          },
          abo_start: '-'
        }
      },
      id: -1,
      ownUser: false
    }
  },
  created() {
    this.getData()
  },
  methods: {
    getData() {
      if (this.$route.params.id == undefined) {
        if (firebase.auth().currentUser != null) {
          this.id = firebase.auth().currentUser.uid
          this.ownUser = true
        }
      } else {
        this.id = this.$route.params.id
        this.ownUser = false
      }
      fetch(api_config.url.concat('/personal_data/' + String(this.id)))
        .then(response => response.json())
        .then(json => {
          this.userdata = json
          var bday = this.userdata.personal_data.birthday
          this.userdata.personal_data.birthday = bday.substring(8, 11) + " " + bday.substring(4, 8) + " " + bday.substring(12, 17)
        })
    },
    requestTP: function (event) {
      router.push('/trainingplan/request')
    },
    requestT: function (event) {
      router.push('/treatment/request')
    },
    logout: function (event) {
      firebase.auth().signOut().then(function() {
        router.push('/home')
      })
    },
    deleteMember: function() {
      if(confirm('Wollen Sie den Nutzer wirklich löschen?')) {
        fetch(api_config.url.concat("/member/" + String(this.id)), {
          method: "DELETE",
        }).then(res => {
          alert('User gelöscht')
          router.push('/members')
            // `event` is the native DOM event
        }) 
      }
    }
  },  
  beforeRouteUpdate(to, from, next) {
    this.userdata = {
      personal_data: {
        name: '-',
        birthday: '-',
        tel: 0,
        mail: '-'
      },
      physical_data: {
        height: 0,
        weight: 0,
        performance_level: 0,
        other_activitys: '-',
        diseases: '-',
        goal: '-',
        aviable_time: 0,
      },
      abo_information: {
        abo: { 
          name: '-',
          costs: 0,
          term: 0
        },
        abo_start: '-'
      }
    }
    this.id = -1,
    this.ownUser = false
    if (this.$route.params.id == undefined) {
      if (firebase.auth().currentUser != null) {
        this.id = firebase.auth().currentUser.uid
        this.ownUser = true
      }
    } else {
      this.id = to.params.id
      this.ownUser = false
    }
    console.log("fetch the data", this.id)
    fetch(api_config.url.concat('/personal_data/' + String(this.id)))
      .then(response => response.json())
      .then(json => {
        this.userdata = json
        next()
      })
  },
  beforeRouteEnter (to, from, next) {
    next(vm => vm.getData())
  },
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
td {
  width: 50%;
}
tr {
  padding: 8px;
}
#overall {
    position: relative;
}
#edit {
  width: 50px;
  height: 50px;
  position: absolute; top:10px; right:15px;
}
#edit img {
  width: 50px;
  height: 50px;
} 
#hold_buttons {
  float: right;
}
#hold_buttons button {
  width: 170px;
}
#delete {
  width: 50px;
  height: 50px;
  position: absolute; top:10px; right:15px;
}
</style>