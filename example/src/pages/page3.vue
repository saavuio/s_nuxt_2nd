<template>
  <div>
    This is page 3. It has the ExampleFeature container.
    <ExampleFeature />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import ExampleFeature from '@/containers/features/ExampleFeature/ExampleFeature.vue';

@Component({
  layout: 'default',
  components: {
    ExampleFeature,
  },
  fetch() {
    console.log('page 3 fetch');
  },
})
export default class Page3 extends Vue {}
</script>
