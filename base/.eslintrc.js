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
    '@typescript-eslint/indent': ['error', 2],
    '@typescript-eslint/explicit-member-accessibility': 'off',
    'vue/singleline-html-element-content-newline': ['error', {
      'ignoreWhenNoAttributes': true,
      'ignores': ['pre', 'textarea', 'nuxt-link']
    }],
    'vue/max-attributes-per-line': 'off',
    'vue/html-self-closing': 'off',
  },
  settings: {
    'import/resolver': {
      node: {
        paths: ['src'],
      },
      alias: [
        ['@', path.resolve(__dirname, 'src')],
      ],
    },
  },
}
