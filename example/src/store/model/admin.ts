import { Module, VuexModule, Mutation } from 'vuex-module-decorators';
import Admin from '@/models/Admin.ts';

@Module({
  namespaced: true,
  name: 'model/admin',
  stateFactory: true,
})
export default class AdminModelStore extends VuexModule {
  activeAdmin: Admin | undefined = undefined;

  @Mutation
  setActiveAdmin(newActiveAdmin: Admin): void {
    this.activeAdmin = newActiveAdmin;
  }

  get getActiveAdminEmail(): string | undefined {
    return this.activeAdmin && this.activeAdmin.email;
  }
}
