<template>
  <div>
    <h3> {{ coursename }} </h3>
    <p> {{ coursedescription }} </p>
    <div id="table">
        <span class="header">Montag</span><span class="header">Dienstag</span><span class="header">Mittwoch</span><span class="header">Donnerstag</span><span class="header">Freitag</span><span class="header">Samstag</span><span class="header">Sonntag</span>
    </div>
    <div id=table_content>
        <span class="dateelem" v-for="c in coursedays" :key="c.id"> 
            <div class="singleentry" v-for="date in c" :key="date.id">
                <p class="singletext">{{ date.hour }}:{{ date.minutes }} Uhr,<br> {{ date.duration }} Min, </p>
                <p class="singletext" v-for="loc in date.locations" :key="loc.id"><i>{{ loc.name }}<span v-if="loc !== date.locations[date.locations.length-1]">, </span></i></p>
                <hr class="divider" v-if="date !== c[c.length-1]">
            </div>
        </span>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Course', 
  props: {
      coursename: String,
      coursedescription: String,
      coursedays: Array,
      coursedivider: Boolean,
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
  #table {
    width: 100%;
    background-color: rgb(170, 170, 170);
    overflow: auto;
    position: sticky;
  }
  #table_content {
    width: 100%;
    background-color: rgb(200, 200, 200);
    overflow: auto;
    position: sticky;
    margin-bottom: 12px;
    
  }
  .header {
    float: left;
    padding-top: 12px;
    padding-bottom: 12px;
    color: black;
    text-decoration: none;
    font-size: 17px;
    width: 14.2857%; 
    text-align: center; /* If you want the text to be centered */
  }
  .dateelem {
    float: left;
    padding-top: 0;
    padding-bottom: 0;
    color: black;
    text-decoration: none;
    font-size: 17px;
    width: 14.2857%; 
    border-top-style: solid;
    border-width: 2px;
    text-align: center; /* If you want the text to be centered */
  }
  .singletext {
    padding: 0;
    margin: 0;
  }
  .singleentry {
      margin-top: 8px;
      margin-bottom: 8px;
  }
</style>