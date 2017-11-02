<template>
  <section class="mt-7">
    <div class="cf center" style="max-width:1280px">
      <div class="sans-serif pv2 fl w-100 w-20-l pr0 pr2-l">
        <TaskStatus/>
        <CtrlFile/>
      </div>
      <div class="sans-serif pv2 fl w-100 w-80-l pr0 pr2-l">
        <h1 class="fl pa2 w-100 mt2 f5 ttu tracked fw6">Step0: Load Data </h1>
        <article class="bg-yellow sans-serif pv2 fl w-100 ">
          <h2 class="f4 pa2 f1-ns fw6 mb2">Load Dataset</h2>
          <!-- <div>Keep genes with minimal counts per million (CPM) in at least n libraries:</div> -->
        </article>

        <div class="cf">
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
            <p class="f6 pa3 f5-ns measure-wide lh-copy mt0">
              Integrated Differential Expression and Pathway analysis (iDEP) of transcriptomic data. See documentation and manuscript. Based on annotation of 69 metazoa and 42 plant genomes in Ensembl BioMart as of 6/4/2017. Additional data from KEGG, Reactome, MSigDB (human), GSKB (mouse) and araPath (arabidopsis). For feedbacks or data contributions (genes and GO mapping of any species), please contact us, or visit our homepage. Send us suggestions or any error message to help improve iDEP.
            </p>
            <!-- radio buttons -->
            <ul class="list">
              <li><input type="radio" name="picked" value="KEGG" v-model="picked"> KEGG </li>
              <li><input type="radio" name="picked" value="SAILFISH" v-model="picked"> SAILFISH</li>
            </ul>
            <div>{{picked}}</div>
            <div style="margin:8px;">
              <a @click="loadDataAll" class="btn btn-primary">Load Demo Data</a>
              <a @click="logData('log')" class="btn btn-primary">Load log transformed Data</a>
              <a @click="logData('log2')" class="btn btn-primary">Load log2 transformed Data</a>
              <a @click="logData('vst')" class="btn btn-primary">Load vst transformed Data</a>
            </div>
            
          </article>
          <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
            <section class="f6 f5-ns measure-wide lh-copy mt0">
              <div class="pa3">
                Users can upload a CSV or tab-delimited text file with the first column as gene IDs. For RNA-seq data, read count per gene is recommended. Also accepted are normalized expression data based on FPKM, RPKM, or DNA microarray data. iDEP can convert most types of common gene IDs to Ensembl gene IDs, which is used internally for enrichment and pathway analyses. iDEP parses column names to define sample groups. To define 3 biological samples (Control, TreatmentA, TreatmentB) with 2 replicates each, column names should be:
              </div>
              <div class="code f6 ba bw1 br4 ma1">
                <div style="padding:8px;">Ctrl_1, Ctrl_2, TrtA_1, TrtA_2, TrtB_1, TrtB_2.</div>
              </div>
              <hr class="bar" />
              <div class="pa3">
                For factorial design, use underscore "_" to separate factors such as genetic background (wide type vs. mutant:WT vs. Mu) and experimental condition (Ctrl vs. Trt). Currently, only two factors are allowed. To define an 2x2 factorial design, use column names like:
              </div>
              <div class="code f6 ba bw1 br4 ma1">
                <div style="padding:8px;">WT_Ctrl_1, WT_Ctrl_2, WT_Trt_1, WT_Trt_2, Mu_Ctrl_1, Mu_Ctrl_2, Mu_Trt_1, Mu_Trt_2</div>
              </div>
            </section>
          </article>
        </div>
        
        <div class="cf">
          <article class="sans-serif pv2 fl w-100 w-33-l pr0 pr2-l">
            <img class="imgCenter mw-100 ba b--dashed bw1" :src="'data:image/png;base64,' + plot1">  
          </article>
          <article class="sans-serif pv2 fl w-100 w-33-l pr0 pr2-l">
            <img class="imgCenter mw-100 ba b--dashed bw1" :src="'data:image/png;base64,' + plot2">  
          </article>
          <article class="sans-serif pv2 fl w-100 w-33-l pr0 pr2-l">
            <img class="imgCenter mw-100 ba b--dashed bw1" :src="'data:image/png;base64,' + plot3">  
          </article>
        </div>
        <Distribution/>
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
    // computed : mapState([
    //     // "users"
    // ]),
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
        picked   : 'one',
        plot1: "",
        plot2: "",
        plot3: "",
        target: {}
      }
    },
    methods: {
      async transForm(){
        axios.get("transform").then(res=>{
          console.log(res)
        })
      },
      async logData(type){
        this.$store.dispatch('GET_TRANS', type)
        var vm = this;
        axios.get("transform/"+type).then(res=>{
          vm.target = res.data
        })
      },
      async loadDataAll(){
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
pre {
  margin-top: 12px;
}
.bar {
  margin-top: 18px;
  margin-bottom: 18px;
}
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