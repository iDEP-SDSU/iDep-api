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
          <h2 class="f5 pa2 f5-ns fw6 mb2">Heatmap</h2>
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
            <img v-if="plot1" class="imgCenter mw-100 ba b--dashed bw1" :src="'data:image/png;base64,' + plot1" />  
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
  // import axios from '~/plugins/axios' ss
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
    methods: {
      loadData(){
        console.log("load Data")
      }
    }
  }

</script>

<style>
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