<template>
  <div>
    This is page 2. It has no containers for some weird reason...
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';

@Component({
  layout: 'default',
  fetch() {
    console.log('page 2 fetch');
  },
})
export default class Page2 extends Vue {}
</script>
