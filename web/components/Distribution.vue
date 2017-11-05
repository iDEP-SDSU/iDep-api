<!-- 
  Density Plot Component 
  TODO: connect state data 
  connect Log view
-->
<template>
  <div>
    <section id="dist"></section>
    <button class="btn" @click="allDensityData()">Draw Log Density</button>
    <button v-if="available" class="btn" @click="drawDensity('log')">draw density(log) </button>
    <button v-if="available" class="btn" @click="drawDensity('vst')">draw density(vst) </button>
    <button v-if="available" class="btn" @click="drawDensity('log2')">draw density(log2) </button>
    <svg width="960" height="500"></svg>
  </div>
</template>
<script>
  import * as d3 from "d3"
  // import * as jStat from "jStat"
  import { mapState } from "vuex"
  import axios from "~/plugins/axios"
  export default {
    data() {
      return{
        available: false
      }
    },
    computed : mapState([
        "transData"
    ]),
    methods: {
      async allDensityData(){
        var vm = this;
        axios.get("transform").then(res=>{
          console.log("transform is ready!")
          this.$store.dispatch('GET_TRANS', 'log')
          this.$store.dispatch('GET_TRANS', 'log2')
          this.$store.dispatch('GET_TRANS', 'vst')
          vm.available = true
        })
      },
      drawDensity(type){
        var vm = this;
        var svg = d3.select("svg"),
        width = +svg.attr("width"),
        height = +svg.attr("height"),
        margin = {top: 20, right: 30, bottom: 30, left: 40};

        var x = d3.scaleLinear()
            .domain([0, 20])
            .range([margin.left, width - margin.right]);

        var y = d3.scaleLinear()
            .domain([0, 0.45])
            .range([height - margin.bottom, margin.top]);
        svg.append("g")
            .attr("class", "axis axis--x")
            .attr("transform", "translate(0," + (height - margin.bottom) + ")")
            .call(d3.axisBottom(x))
          .append("text")
            .attr("x", width - margin.right)
            .attr("y", -6)
            .attr("fill", "#000")
            .attr("text-anchor", "end")
            .attr("font-weight", "bold")
            .text("Ge-Lab");

        svg.append("g")
            .attr("class", "axis axis--y")
            .attr("transform", "translate(" + margin.left + ",0)")
            .call(d3.axisLeft(y).ticks(null, "%"));

        Object.keys(vm.transData[type]).forEach(name=>{
          var density = vm.transData[type][name];
          var tData = []
          density.x.forEach(function(x, i){
              var temp = {x:x, y:density.y[i]}
              tData.push(temp)
            }
          )
          svg.append("path")
            .datum(tData)
            .attr("fill", "none")
            .attr("stroke", "#000")
            .attr("stroke-width", 1.5)
            .attr("stroke-linejoin", "round")
            .attr("d",  d3.line()
              .curve(d3.curveBasis)
              .x(function(d) { return x(d.x); })
              .y(function(d) { return y(d.y); }));
        })
      }
    },
    mounted(){
    }
}
</script>
<style>

  /* 13. Basic Styling with CSS */

/* Style the lines by removing the fill and applying a stroke */
.line {
    fill: none;
    stroke: #ffab00;
    stroke-width: 3;
}

/* Style the dots by assigning a fill and stroke */
.dot {
    fill: #ffab00;
    stroke: #fff;
}
</style>