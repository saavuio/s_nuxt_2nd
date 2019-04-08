<template>
  <div>
    <ChannelList />
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import ChannelList from '@/containers/features/ChannelList/ChannelList.vue';
// store
// import { getModule } from 'vuex-module-decorators';
// import DataFetcherStore from '@/store/helper/data-fetcher.ts';

@Component({
  layout: 'default',
  components: {
    ChannelList,
  },
  // { store }
  fetch() {
    console.log('index fetch');
    // in pages, set up stores in the fetch method
    // getModule(DataFetcherStore, store).toggleTrigger();
  },
})
export default class Index extends Vue {}
</script>
