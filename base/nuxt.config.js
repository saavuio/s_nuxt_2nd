export default {
  mode: 'universal',
  srcDir: 'src',
  buildDir: '.nuxt/build',
  env: {
    NODE_ENV: process.env.NODE_ENV,
  },
  server: {
    host: '0.0.0.0',
  },
  // prettier-ignore
  plugins: [
    '@/plugins/vuetify-init',
  ],
  build: {
    extend(config, ctx) {
      // Run ESLint on save
      if (ctx.isDev && ctx.isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue|ts)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/,
        });
      }
    },
    transpile: [/^vuetify/],
  },
};
