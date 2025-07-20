import { Module } from '@nestjs/common';
import { AudioPhonemesService } from './audio_phonemes.service';

@Module({
  providers: [AudioPhonemesService],
})
export class AudioPhonemesModule {}
