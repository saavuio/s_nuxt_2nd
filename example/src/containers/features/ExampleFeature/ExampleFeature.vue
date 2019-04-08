<template>
  <div>
    loading: {{ loading }}
    <ExampleItem />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
// components
import ExampleItem from '@/components/features/ExampleFeature/ExampleItem.vue';
// store
import { getModule } from 'vuex-module-decorators';
import ExampleFeatureStore from '@/store/feature/example-feature.ts';
import DataFetcherStore from '@/store/helper/data-fetcher.ts';

@Component({
  components: {
    ExampleItem,
  },
})
export default class ChannelList extends Vue {
  dataFetcherStore!: DataFetcherStore;

  exampleFeatureStore!: ExampleFeatureStore;

  get loading(): boolean {
    return this.exampleFeatureStore.getLoading;
  }

  beforeCreate() {
    console.log('beforeCreate ChannelList');
    // init stores
    this.exampleFeatureStore = getModule(ExampleFeatureStore, this.$store);
    this.dataFetcherStore = getModule(DataFetcherStore, this.$store);
    // add data needs
    this.dataFetcherStore.addDataNeeds({
      qs: ['allChannels.nodes'],
    });
  }

  created() {
    this.exampleFeatureStore.getCustomData();
  }
}
</script>
