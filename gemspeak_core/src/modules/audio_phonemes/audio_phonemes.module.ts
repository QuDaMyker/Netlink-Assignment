import { Module } from '@nestjs/common';
import { AudioPhonemesService } from './audio_phonemes.service';
import { AudioPhonemesController } from './audio_phonemes.controller';

@Module({
  controllers: [AudioPhonemesController],
  providers: [AudioPhonemesService],
})
export class AudioPhonemesModule {}
