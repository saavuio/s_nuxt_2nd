<template>
  <v-app>
    <v-content>
      <v-container>
        <NavTop />
        <nuxt />
      </v-container>
    </v-content>
    <v-footer :fixed="true" app>
      <span>&nbsp; &copy; 2019 {{ ddf }}</span>
    </v-footer>
  </v-app>
</template>

<script lang="ts">
import { Component, Vue, Watch } from 'vue-property-decorator';
import { get } from 'lodash';
// containers
import NavTop from '@/containers/app/NavTop.vue';
// store
import { getModule } from 'vuex-module-decorators';
import DataFetcherStore from '@/store/helper/data-fetcher.ts';

@Component({
  components: {
    NavTop,
  },
})
export default class DefaultLayout extends Vue {
  dataFetcherStore!: DataFetcherStore;

  firstDataFetchDone: boolean = false;

  get ddf() {
    return get(this.dataFetcherStore, 'getTrigger', '');
  }

  beforeCreate() {
    console.log('beforeCreate layout');
    // in general, set up stores in the beforeCreate hook
    this.dataFetcherStore = getModule(DataFetcherStore, this.$store);
    this.dataFetcherStore.resetDataNeeds();
  }

  mounted() {
    this.$nextTick(() => {
      // done with all containers, do actual data fetching...
      console.log('containers up, get data');
      this.dataFetcherStore.setFirstFetchDone();
      console.log(JSON.stringify(this.dataFetcherStore.getDataNeeds, undefined, 2));
    });
  }

  @Watch('ddf', { immediate: true, deep: true })
  onDataChange() {
    if (this.dataFetcherStore.getFirstFetchDone) {
      console.log('check if we need to update...');
    }
  }
}
</script>
