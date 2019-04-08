import { Module, VuexModule, Mutation } from 'vuex-module-decorators';

interface DataNeed {
  qs: string[];
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  opts?: { args: Record<string, any> };
}

@Module({
  namespaced: true,
  name: 'helper/data-fetcher',
  stateFactory: true,
})
export default class DataFetcherStore extends VuexModule {
  public dataNeeds: DataNeed[] = [];

  firstFetchDone: boolean = false;

  // @TODO: cache individual values & allow reset individual values or all

  @Mutation
  addDataNeeds(newDataNeeds: DataNeed): void {
    this.dataNeeds.push(newDataNeeds);
  }

  @Mutation
  resetDataNeeds(): void {
    this.dataNeeds = [];
  }

  @Mutation
  setFirstFetchDone(): void {
    this.firstFetchDone = true;
  }

  get getDataNeeds(): DataNeed[] {
    return this.dataNeeds;
  }

  get getFirstFetchDone(): boolean {
    return this.firstFetchDone;
  }
}
