<template>
  <div>
    <header-vue class="code" />
    
    <nuxt/>

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