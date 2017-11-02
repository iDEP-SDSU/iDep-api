module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'idep-web',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' }
    ],
    link: [
      { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' }
    ],
    script: [
      { src: 'https://cdn.plot.ly/plotly-latest.min.js' }
    ]
  },
  /*
  ** Customize the progress bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Build configuration
  */
  css:[
    "tachyons/css/tachyons.min.css",
    "~/assets/main.css"
    // "tachyons-debug/css/tachyons-debug.min.css"
  ],
  build:{
    vendor: ["axios"]
  },
  plugins: [
    "~/plugins/filters"
  ]

  
}
