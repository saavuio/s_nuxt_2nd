const path = require('path');

export default {
  mode: 'universal',
  srcDir: 'src',
  buildDir: '.nuxt/build',
  plugins: ['@/plugins/vuetify'],
  build: {
    extend(config, ctx) {
      // Run ESLint on save
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue|ts)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  }
}
