const path = require('path');

module.exports = {
  root: true,
  env: {
    node: true
  },
  parser: 'vue-eslint-parser',
  parserOptions: {
    parser: '@typescript-eslint/parser'
  },
  extends: [
    '@nuxtjs',
    'airbnb-base',
    'plugin:@typescript-eslint/recommended',
    'prettier',
    'prettier/vue',
    'prettier/@typescript-eslint',
    'plugin:prettier/recommended',
    'plugin:vue/recommended',
    '@vue/typescript'
  ],
  plugins: [
    '@typescript-eslint',
    'no-null',
    'prettier',
  ],
  rules: {
    'no-null/no-null': 2,
    'no-console': ['error', { 'allow': ['log', 'debug', 'warn', 'error'] }],
    '@typescript-eslint/explicit-member-accessibility': 'off',
    'vue/singleline-html-element-content-newline': ['error', {
      'ignoreWhenNoAttributes': true,
      'ignores': ['pre', 'textarea', 'nuxt-link']
    }],
    'vue/max-attributes-per-line': 'off',
    'vue/html-self-closing': 'off',
    'import/extensions': ['error', 'always', {
      js: 'never',
      ts: 'never', // NOTE: ts itself doesn't want .ts extensions with imports, so don't lint here
      vue: 'always', // NOTE: ts does not recognize vue files imported without extensions, so enforce this
    }],
  },
  settings: {
    'import/resolver': {
      node: {
        paths: ['src'],
        extensions: ['.js', '.ts', '.vue']
      },
      alias: {
        map: [
          ['@', path.resolve(__dirname, 'src')],
        ],
        extensions: ['.js', '.ts', '.vue'],
      },
    },
  },
}
