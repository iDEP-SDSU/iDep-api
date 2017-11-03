<template>
  <section>
    <div class="cf center" style="max-width:1280px">
      <div class="sans-serif pv2 fl w-100 w-20-l pr0 pr2-l">
        <TaskStatus/>
        <CtrlFile/>
      </div>
      <div class="sans-serif pv2 fl w-100 w-80-l pr0 pr2-l">
        <!-- 
        <h1 class="fl pa2 w-100 mt2 f5 ttu tracked fw6">Step 0: Load Data </h1>
        -->
        <article class="bg-yellow sans-serif pv2 fl w-100 ">
          <h2 class="f5 pa2 f5-ns fw6 mb2">K-means</h2>
          <!-- <div>Keep genes with minimal counts per million (CPM) in at least n libraries:</div> -->
        </article>
        <div class="cf">
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
            <button @click="heatmap" class="btn btn-primary">Draw Heatmap</button>
            <button @click="loadHeatMatData" class="btn btn-primary">Load heatmap Data</button>
          </article>
        </div>
        <div class="cf">
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
            <img v-if="plot1" class="imgCenter mw-100 ba b--dashed bw1" 
              :src="'data:image/png;base64,' + plot1" />  
            <div id="myDiv"></div>
          </article>
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
           <!-- {{heatmapData}} -->
            <div v-for="row in heatmapData"> 
              <span class="ma1" v-for="col in row">{{col}}</span>
            </div>
          </article>
        </div>
      </div>
    </div>
  </section>
</template>
<script>
import { mapState } from "vuex"
import axios from "~/plugins/axios"
import TaskStatus from '~/components/TaskStatus.vue'
import CtrlFile from '~/components/CtrlFile.vue'
import Distribution from '~/components/Distribution.vue'

export default {
  
  components: {
      Distribution: Distribution,
      TaskStatus: TaskStatus,
      CtrlFile: CtrlFile
  },
  async fetch({store}){
      await store.dispatch("LOAD_STATUS", "topstories.json")
  },
  data() {
    return{
      plot1:"",
      heatmapData: [{
        z: [],
        type: 'heatmap'
      }]
    }
  },
  mounted() {
  },
  methods: {
    async heatmap(){
      var vm = this;
      await axios.get("heatmap", {
          responseType: 'arraybuffer'
        }).then(res =>{
          vm.plot1 = new Buffer(res.data, 'binary').toString('base64')
      })
    },

    async loadHeatMatData(){
      var vm = this;
      var response = await axios.get("heatmapdata")
      vm.heatmapData = [
        {
          z: response.data,
          type: 'heatmap'
        }
      ]
      var layout = {
        autosize: false,
        width: 500,
        height: 700,
        margin: {
          l: 50,
          r: 50,
          b: 100,
          t: 100,
          pad: 4
        },
        // paper_bgcolor: 'gold',
        plot_bgcolor: 'white'
      };
      Plotly.newPlot('myDiv', vm.heatmapData, layout);
    }
  }
}
</script>
<style scoped>
  .modebar {display:none}
  .modebar--hover {display: none;}
</style>