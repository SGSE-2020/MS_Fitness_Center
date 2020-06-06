<template>
  <div class="contentdiv">
    <h1>Kurse</h1>
    <Course v-for="cou in allcourses" :key="cou.id" 
      :coursename="cou.name"
      :coursedescription="cou.description"
      :coursedays="cou.dates"
      :coursedivider="(cou!=allcourses[allcourses.length-1])"/>
    <span v-if="allcourses.length === 0">Keine Kurse bekannte</span>
  </div>
</template>

<script>
import api_config from '../../config/api_config'
import Course from './course.vue'

export default {
  name: 'Courses',
  components: {
    'Course': Course
  },
  data() {
    return {
      allcourses: []
    }
  },
  created() {
    fetch(new String("http://").concat(api_config.url, "/courses"))
      .then(response => response.json())
      .then(json => {
        this.allcourses = json
        console.log(json)
        for (var course = 0; course < this.allcourses.length; course++) {
          var days = []
          for (var i = 0; i < 7; i++) {
            days[i] = []
          }
          var current_curse = this.allcourses[course]
          for (var c = 0; c < current_curse.dates.length; c++) {
            days[current_curse.dates[c].day].push(current_curse.dates[c])
            days[current_curse.dates[c].day].id = current_curse.dates[c].day
            var minutes = days[current_curse.dates[c].day].minutes
            if (minutes < 10) {
              days[current_curse.dates[c].day].minutes = new String(minutes).padStart(2, '0')
            }
          }
          this.allcourses[course].dates = days
        }
      })
  }
}
</script>
<style>

</style>