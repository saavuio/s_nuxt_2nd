import { Module, VuexModule, Mutation, Action } from 'vuex-module-decorators';

@Module({
  namespaced: true,
  name: 'feature/example-feature',
  stateFactory: true,
})
export default class ExampleFeatureStore extends VuexModule {
  loading: boolean = false;

  @Mutation
  setLoading(newState: boolean): void {
    this.loading = newState;
  }

  @Action
  // eslint-disable-next-line class-methods-use-this
  async getCustomData(): Promise<void> {
    this.context.commit('setLoading', true);
    await new Promise((resolve): number => setTimeout(resolve, 1000));
    this.context.commit('setLoading', false);
  }

  // prettier-ignore
  get getLoading(): boolean { return this.loading; }
}
