import { GuildQueue, GuildQueueEvent, Track } from 'discord-player';
import { EmbedGenerator } from '#bot/utils/EmbedGenerator';
import { PlayerEvent } from '../common/types.js';
import { PlayerMetadata } from '../PlayerMetadata.js';
import { io } from '#bot/web/index';
import { DeleteEmbedTime, ExitTime } from '#bot/utils/constants';

export default class TrackFinishEvent
  implements PlayerEvent<typeof GuildQueueEvent.playerFinish>
{
  public name = GuildQueueEvent.playerFinish;

  public async execute(
    queue: GuildQueue<PlayerMetadata>,
    track: Track<unknown>
  ) {
    io.to(queue.guild.id).emit('playerFinish', track.serialize());

    const embed = EmbedGenerator.Success({
      description: `[${track.title}](${track.url})`,
      title: 'Canción finalizada',
      footer: {
        text: `Pedida por ${track.requestedBy?.tag}`,
        iconURL: track.requestedBy?.displayAvatarURL(),
      },
    });

    queue.metadata.channel.send({ embeds: [embed] });

    setTimeout(async () => {
      if(queue.currentTrack == null){
        queue.connection?.disconnect();
        const embed = EmbedGenerator.Info({
          description: `Canal <#${queue.metadata.channel.id}> abandonado por inactividad :man_dancing:`,
          title: 'Canal Abandonado',
        });
        let message = queue.metadata.channel.send({ embeds: [embed] });
        setTimeout(async () => {
          (await message).delete();
        }, DeleteEmbedTime);
      }
    }, ExitTime);

    /*
    setTimeout(async () => {
      (await message).delete();
    }, DeleteEmbedTime);
    */
  }
}
