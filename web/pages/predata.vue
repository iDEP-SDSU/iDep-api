<template>
  <div class="cf ph3 ph5-ns pb5 bg-yellow black-70 code">
    <div class="mw9 center">
      <h1 class="fl w-100 mt5 f5 ttu tracked fw6">Step1: Pre Data Process </h1>
      <article class="sans-serif pv2 fl w-100 ">
        <h2 class="f4 f1-ns fw6 mb2">Pre-process dataset</h2>
        
        <div>Keep genes with minimal counts per million (CPM) in at least n libraries:</div>
      </article>
      <div class="cf">
        <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
          <p class="f5 f4-ns measure lh-copy mt0">
            Integrated Differential Expression and Pathway analysis (iDEP) of transcriptomic data. See documentation and manuscript. Based on annotation of 69 metazoa and 42 plant genomes in Ensembl BioMart as of 6/4/2017. Additional data from KEGG, Reactome, MSigDB (human), GSKB (mouse) and araPath (arabidopsis). For feedbacks or data contributions (genes and GO mapping of any species), please contact us, or visit our homepage. Send us suggestions or any error message to help improve iDEP.
          </p>
          <ul class="list">
            <li> Demo 1 </li>
            <li> Demo 2 </li>
            <li> Demo 3 </li>
          </ul>
          <a @click="loadData" class="btn btn-primary">Load Demo Data</a>
        </article>
        <article class="sans-serif pv2 fl w-100 w-50-l pr0 pr2-l">
          <section class="f5 f4-ns measure lh-copy mt0">
            <div>
              Users can upload a CSV or tab-delimited text file with the first column as gene IDs. For RNA-seq data, read count per gene is recommended. Also accepted are normalized expression data based on FPKM, RPKM, or DNA microarray data. iDEP can convert most types of common gene IDs to Ensembl gene IDs, which is used internally for enrichment and pathway analyses. iDEP parses column names to define sample groups. To define 3 biological samples (Control, TreatmentA, TreatmentB) with 2 replicates each, column names should be:
            </div>
            <div class="code">
              Ctrl_1, Ctrl_2, TrtA_1, TrtA_2, TrtB_1, TrtB_2.
            </div>
            <div>
            For factorial design, use underscore "_" to separate factors such as genetic background (wide type vs. mutant:WT vs. Mu) and experimental condition (Ctrl vs. Trt). Currently, only two factors are allowed. To define an 2x2 factorial design, use column names like:
            </div>
            <div class="code">
              WT_Ctrl_1, WT_Ctrl_2, WT_Trt_1, WT_Trt_2, Mu_Ctrl_1, Mu_Ctrl_2, Mu_Trt_1, Mu_Trt_2
            </div>
          </section>
        </article>
      </div>
      <!-- 
      <ul class="list">
          <li v-for="user in users" :key="user.id">
              {{user.login}}
          </li>
      </ul>
      -->
    </div>
    
  </div>
</template>

<script>
  // import axios from '~/plugins/axios' ss
  import { mapState } from "vuex"

  export default {
    computed : mapState(["users"]),
    methods: {
      loadData(){
        console.log("load Data")
        // update process status

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