export default {
  mode: 'universal',
  srcDir: 'src',
  // NOTE: nuxt/now-builder will fail with a custom buildDir, but is require for s_base to work correctly.
  buildDir: process.env.NODE_ENV === 'development' ? '.nuxt/build' : '.nuxt',
  // uncomment to test production build on development
  // buildDir: '.nuxt/build',
  generate: {
    dir: '.nuxt/generated',
  },
  env: {
    NODE_ENV: process.env.NODE_ENV,
  },
  server: {
    host: '0.0.0.0',
  },
  head: {
    meta: [{ charset: 'utf-8' }, { name: 'viewport', content: 'width=device-width, initial-scale=1' }],
  },
  // prettier-ignore
  buildModules: [
    '@nuxt/typescript-build'
  ],
  // prettier-ignore
  build: {
    parallel: process.env.NODE_ENV === 'development',
    cache: process.env.NODE_ENV === 'development',
    hardSource: process.env.NODE_ENV === 'development',
    extend(config, ctx) {
      const isDev = process.env.NODE_ENV === 'development';
      // eslint-disable-next-line global-require, @typescript-eslint/no-var-requires, import/no-extraneous-dependencies
      const HardSourceWebpackPlugin = isDev && require('hard-source-webpack-plugin');
      // NOTE: s_nuxt_2nd specific. Normally HardSource doesn't need to be configured.
      // eslint-disable-next-line global-require, @typescript-eslint/no-var-requires, import/no-extraneous-dependencies
      if (isDev) {
        // eslint-disable-next-line no-param-reassign
        config.plugins = config.plugins.filter(plugin => {
          return plugin.constructor.name !== 'HardSourceWebpackPlugin';
        });
        config.plugins.push(
          new HardSourceWebpackPlugin({
            cacheDirectory: '/s_nuxt_2nd/.webpack-cache/hard-source/[confighash]',
          }),
        );
      }

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
  }
};
