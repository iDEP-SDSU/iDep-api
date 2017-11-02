<template>
  <div class="taskStatus code bg-washed-blue near-black">
    <div class="customFont mb2"> Logs: {{status.msg}}</div> 
    <div class="customFont mb2"> date: {{status.date}}</div>
    <div>
      <ul class="list" style="padding-left:2px;">
        <li class="customFont lh-copy" v-for="log in logs">{{log.title}}: {{log.desc}}</li>
      </ul>
    </div>
  </div>
</template>

<script>
  import { mapState } from 'vuex'
  
  export default {
    computed : mapState([
        "logs", "status"
    ]),
    
    data() {
      return{
      }
    },
    mounted() {

    }
  }
</script>

<style>
.taskStatus{
  padding: 8px;
}
.customFont {
  font-size: 11px;
}
</style>