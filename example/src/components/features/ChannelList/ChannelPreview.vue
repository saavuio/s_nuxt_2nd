<template>
  <div>
    {{ channel.name }}
  </div>
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator';
import Channel from '@/models/Channel.ts';

@Component
export default class ChannelPreview extends Vue {
  @Prop() channel!: Channel;
}
</script>
