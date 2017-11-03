<template>
  <div>
    <header-vue class="code" style="position: fixed; width:100%; top:0" />
    <nuxt style="margin-top: 125px;" />
    <footer-vue class="code" />
  </div>
</template>

<script>
  // import axios from '~/plugins/axios' ss
  import FooterVue from '~/components/Footer.vue'
  import HeaderVue from '~/components/Header.vue'
  export default {
    components: {
      FooterVue: FooterVue,
      HeaderVue: HeaderVue
    }
  }
</script>