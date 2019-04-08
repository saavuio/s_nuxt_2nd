<template>
  <div>
    <div v-for="channel of channelModelStore.getChannelList" :key="channel.id">
      <ChannelPreview :channel="channel" />
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
// components
import ChannelPreview from '@/components/features/ChannelList/ChannelPreview.vue';
// store
import { getModule } from 'vuex-module-decorators';
import ChannelModelStore from '@/store/model/channel.ts';
import DataFetcherStore from '@/store/helper/data-fetcher.ts';

@Component({
  components: {
    ChannelPreview,
  },
})
export default class ChannelList extends Vue {
  channelModelStore!: ChannelModelStore;

  dataFetcherStore!: DataFetcherStore;

  beforeCreate() {
    console.log('beforeCreate ChannelList');
    // init stores
    this.channelModelStore = getModule(ChannelModelStore, this.$store);
    this.dataFetcherStore = getModule(DataFetcherStore, this.$store);
    // add data needs
    this.dataFetcherStore.addDataNeeds({
      qs: ['allChannels.nodes'],
    });
  }
}
</script>
