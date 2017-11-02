<template>
  <div class="cf mt7 ph3 ph5-ns pb5 bg-yellow black-70 code">
    <div class="mw9 center">
      <h1 class="fl w-100 mt5 f5 ttu tracked fw6">K-means</h1>
      <article class="sans-serif pv2 fl w-100 ">
        <h2 class="f5 f2-ns fw6 mb2">K-means</h2>
        <div>....</div>
      </article>
      <div class="cf">
        <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
          <p class="f5 f4-ns measure lh-copy mt0"></p>
          <button @click="heatmap" class="btn btn-primary">Draw Heatmap</button>
          <button @click="loadHeatMatData" class="btn btn-primary">Load heatmap Data</button>
        </article>
        <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
        </article>
      </div>

      <div class="cf">
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
            <img class="imgCenter mw-100 ba b--dashed bw1" 
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
</template>
<script>
import axios from "~/plugins/axios"

export default {
  
  components: {},
  async fetch({store}){
    //await store.dispatch("LOAD_STATUS", "topstories.json")
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
        paper_bgcolor: 'gold',
        plot_bgcolor: 'white'
      };
      Plotly.newPlot('myDiv', vm.heatmapData, layout);
      
    }
  }
}
</script>