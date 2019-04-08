import { Module, VuexModule } from 'vuex-module-decorators';
import Channel from '@/models/Channel.ts';

@Module({
  namespaced: true,
  name: 'model/channel',
  stateFactory: true,
})
export default class ChannelModelStore extends VuexModule {
  channelList: Channel[] = [
    { id: 1, name: 'channel 1', description: 'desc 1' },
    { id: 2, name: 'channel 2', description: 'desc 2' },
  ];

  activeChannel: Channel | undefined = undefined;

  get getChannelList(): Channel[] {
    return this.channelList;
  }
}
