<template>
  <section class="sans-serif">
    <div class="cf">
      <TaskStatus/>
      <div class="pv2 fl w-100 w-20-l pr0 pr2-l">
        <hr/>
        <CtrlFile/>
      </div>
      <div class="pv2 fl w-100 w-80-l pr0 pr2-l">
        <h1 class="fl w-100 mt5 f5 ttu tracked fw6">APIs </h1>

        <article class="pv2 fl w-100 ">
          <div class="f6 f5-ns">Keep genes with minimal counts per million (CPM) in at least n libraries:</div>
        </article>

        <article v-for="item in items" class="pv2 fl w-100 ">
          <h2 class="f5 f4-ns fw6 mb2">{{item.title}}</h2>
          <div class="f6 f5-ns">{{item.desc}}</div>
        </article>

      </div>
    </div>
  </section>
</template>

<script>
  // import { mapState } from "vuex"
  import axios from "~/plugins/axios"
  import CtrlFile from '~/components/CtrlFile.vue'
  import TaskStatus from '~/components/TaskStatus.vue'
  
  export default {
    components: {
      CtrlFile: CtrlFile,
      TaskStatus: TaskStatus
    },
    data() {
      return{
        items:[]
      }
    },
    created(){
      var vm = this;
      vm.items = [
        {title: 'Load Dataset', desc:' Load input datafile into severside'},
        {title: 'Pre-Process', desc:' Load input datafile into severside'},
        {title: 'Heatmap', desc:' Load input datafile into severside'},
        {title: 'K-means', desc:' Load input datafile into severside'},
      ]
    },
    methods: {
      // async transForm(){
      //   axios.get("transform").then(res=>{
      //     console.log(res)
      //   })
      // },
      async logData(type){
        var vm = this;
        axios.get("transform/"+type).then(res=>{
          vm.target = res.data
        })
      },
      async loadData(){
        var vm = this;
        console.log("load Data")
        // update process status
        await axios.get("plot1", {
          responseType: 'arraybuffer'
        }).then(res =>{
          vm.plot1 = new Buffer(res.data, 'binary').toString('base64')
        })
        await axios.get("plot2", {
          responseType: 'arraybuffer'
        }).then(res =>{
          vm.plot2 = new Buffer(res.data, 'binary').toString('base64')
        })
        await axios.get("plot3", {
          responseType: 'arraybuffer'
        }).then(res =>{
          vm.plot3 = new Buffer(res.data, 'binary').toString('base64')
        })
      }
    }
  }
</script>

<style>
.imgCenter {
  display: -webkit-box;
  margin: 0 auto;
}
.btn{
  background: red;
  color: #fff7f7;
  font-weight: 400;
  border-radius: 20px;
  padding: 7px 26px 8px 26px;
  font-size: 18px;
  display: inline-block;
  margin-bottom: 0;
  font-weight: 400;
  text-align: center;
  vertical-align: middle;
  -ms-touch-action: manipulation;
  touch-action: manipulation;
  cursor: pointer;
  background-image: none;
  border: 1px solid transparent;
  white-space: nowrap;
  padding: 8px 20px;
  font-size: 16px;
  line-height: 1.35;
  border-radius: 20px;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
}
</style>