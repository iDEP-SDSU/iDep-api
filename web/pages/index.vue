<template>
  <div class="code">
    <article class="cf ph3 ph5-ns pv5">
      <header class="fn fl-ns w-50-ns pr4-ns">
        <h1 class="mb3 mt0 lh-title">
          Integrated 
          Differential 
          Expression and 
          Pathway analysis</h1>
        <time class="f6 ttu tracked gray">Ge-Lab</time>
      </header>
      <div class="fn fl-ns w-50-ns">
        <p class="lh-copy measure mt4 mt0-ns">
          Integrated Differential Expression and Pathway analysis (iDEP) of transcriptomic data. See documentation and manuscript. 
          Based on annotation of 69 metazoa and 42 plant genomes in Ensembl BioMart as of 6/4/2017. 
          Additional data from KEGG, Reactome, MSigDB (human), GSKB (mouse) and araPath (arabidopsis). 
          For feedbacks or data contributions (genes and GO mapping of any species), 
          please contact us, or visit our homepage. Send us suggestions or any error message to help improve iDEP.
        </p>
        <p class="lh-copy measure">
          Users can upload a CSV or tab-delimited text file with the first column as gene IDs. For RNA-seq data, read count per gene is recommended. Also accepted are normalized expression data based on FPKM, RPKM, or DNA microarray data. iDEP can convert most types of common gene IDs to Ensembl gene IDs, which is used internally for enrichment and pathway analyses. iDEP parses column names to define sample groups. To define 3 biological samples (Control, TreatmentA, TreatmentB) with 2 replicates each, column names should be:
          Ctrl_1, Ctrl_2, TrtA_1, TrtA_2, TrtB_1, TrtB_2.
          For factorial design, use underscore "_" to separate factors such as genetic background (wide type vs. mutant:WT vs. Mu) and experimental condition (Ctrl vs. Trt). Currently, only two factors are allowed. To define an 2x2 factorial design, use column names like:
          WT_Ctrl_1, WT_Ctrl_2, WT_Trt_1, WT_Trt_2, Mu_Ctrl_1, Mu_Ctrl_2, Mu_Trt_1, Mu_Trt_2
        </p>
      </div>
    </article>
    <ul class="list">
      <li v-for="user in users" :key="user.id">
        {{user.login}}
      </li>
    </ul>
  </div>
</template>
<script>
  // import axios from '~/plugins/axios' ss
  import { mapState } from "vuex"

  export default {
    computed : mapState(["users"])
  } 
</script>

<style>
  .cf:before, .cf:after {
      content: " ";
      display: table;
  }

  .cf:after {
      clear: both;
  }

  .cf {
      *zoom: 1;
  }

  .fn {
      float: none;
  }

  .tracked {
      letter-spacing: .1em;
  }

  .lh-title {
      line-height: 1.25;
  }

  .lh-copy {
      line-height: 1.5;
  }

  .gray {
      color: #777;
  }

  .pv5 {
      padding-top: 4rem;
      padding-bottom: 4rem;
  }

  .ph3 {
      padding-left: 1rem;
      padding-right: 1rem;
  }

  .mb3 {
      margin-bottom: 1rem;
  }

  .mt0 {
      margin-top: 0;
  }

  .mt4 {
      margin-top: 2rem;
  }

  .ttu {
      text-transform: uppercase;
  }

  .f6 {
      font-size: .875rem;
  }

  .measure {
      max-width: 30em;
  }

  @media screen and (min-width: 30em) {
      .fl-ns {
          float: left;
          display: inline;
      }
      .w-50-ns {
          width: 50%;
      }
      .pr4-ns {
          padding-right: 2rem;
      }
      .ph5-ns {
          padding-left: 4rem;
          padding-right: 4rem;
      }
      .mt0-ns {
          margin-top: 0;
      }
  }
</style>