<template>
<nav class="nav-bar bg-washed-blue pv4 ph3 ph2-m ph3-l mid-gray">
    <nuxt-link to="/" class="f5 f4-m f3-l ttu tracked dib ph2 link mt0 mid-gray dim">iDEP 0.4</nuxt-link>
    <br>
    <nuxt-link to="/loaddata" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Load Data </nuxt-link>
    <nuxt-link to="/predata" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Pre-Process </nuxt-link>
    <nuxt-link to="/heatmap" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Heatmap </nuxt-link>
    <nuxt-link to="/kmean" class="menu underline-hover f6 dib ph2 link mid-gray dim"> k-means </nuxt-link>
    <nuxt-link to="/pca" class="menu underline-hover f6 dib ph2 link mid-gray dim"> PCA </nuxt-link>
    <nuxt-link to="/degs" class="menu underline-hover f6 dib ph2 link mid-gray dim"> DEGs </nuxt-link>
    <nuxt-link to="/pathways" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Pathways </nuxt-link>
    <nuxt-link to="/chromosome" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Chromosome </nuxt-link>
    <nuxt-link to="/r" class="menu underline-hover f6 dib ph2 link mid-gray dim"> R </nuxt-link>
    <nuxt-link to="/" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Github </nuxt-link>
    <nuxt-link to="/login" class="menu underline-hover f6 dib ph2 link mid-gray dim"> Login </nuxt-link>
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

    font-size:12px !important;
  }
}
</style>