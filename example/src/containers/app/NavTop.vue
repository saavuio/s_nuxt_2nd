<template>
  <div>
    <nuxt-link to="/">index</nuxt-link>
    <nuxt-link to="/page2">page2</nuxt-link>
    <nuxt-link to="/page3">page3</nuxt-link>
    <div style="float: right">
      {{ adminEmail }}
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
// store
import { getModule } from 'vuex-module-decorators';
import DataFetcherStore from '@/store/helper/data-fetcher.ts';
import AdminModelStore from '@/store/model/admin.ts';

@Component
export default class TopNav extends Vue {
  dataFetcherStore!: DataFetcherStore;

  adminModelStore!: AdminModelStore;

  get adminEmail() {
    return this.adminModelStore.getActiveAdminEmail;
  }

  beforeCreate() {
    console.log('beforeCreate TopNav');
    // init stores
    this.dataFetcherStore = getModule(DataFetcherStore, this.$store);
    this.adminModelStore = getModule(AdminModelStore, this.$store);
    // add data needs
    this.dataFetcherStore.addDataNeeds({
      qs: ['getAdminById.email'],
      opts: {
        // get from jwt
        args: { getAdminById: 1 },
      },
    });
    // NOTE: Mock data. This should come through the store when fetchers work correctly
    this.adminModelStore.setActiveAdmin({ id: 1, email: 'test@saavu.io' });
  }
}
</script>
