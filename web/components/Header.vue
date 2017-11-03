<template>
<nav class="nav-bar bg-washed-blue pv2 ph2 ph2-m ph3-l mid-gray">
    <nuxt-link to="/" class="f5 f4-m f3-l ttu tracked dib ph2 link mt0 mid-gray dim">iDEP 0.4</nuxt-link>
    <nuxt-link to="/loaddata" class="center bg-light-green pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Load Data </nuxt-link>
    <nuxt-link to="/predata" class="center bg-lightest-blue pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Pre-Process </nuxt-link>
    <nuxt-link to="/heatmap" class="center bg-washed-yellow pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Heatmap </nuxt-link>
    <nuxt-link to="/kmean" class="center bg-washed-green pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> k-means </nuxt-link>
    <nuxt-link to="/pca" class="center bg-washed-red pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> PCA </nuxt-link>
    <nuxt-link to="/degs" class="center bg-moon-gray pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> DEGs </nuxt-link>
    <nuxt-link to="/pathways" class="center bg-light-red pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Pathways </nuxt-link>
    <nuxt-link to="/chromosome" class="center bg-light-purple pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Chromosome </nuxt-link>
    <nuxt-link to="/r" class="center bg-light-yellow pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> R </nuxt-link>
    <nuxt-link to="/" class="center bg-washed-green pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Github </nuxt-link>
    <nuxt-link to="/login" class="center bg-white pa3 menu underline-hover f5 dib ph2 link mid-gray dim"> Login </nuxt-link>
</nav>
</template>
<style>
.nav-bar{
  z-index: 99;
}
.nuxt-link-exact-active{
    font-weight: bold; 
    text-decoration: underline;
}
@media (min-width: 400px) {
  /* hundreds of lines later */
  .menu {
    text-align: center;
    min-width: 120px;
    font-size:12px !important;
  }
}
</style>