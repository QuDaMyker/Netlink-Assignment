import { Module } from '@nestjs/common';
import { AudioSyllablesService } from './audio_syllables.service';

@Module({
  providers: [AudioSyllablesService],
})
export class AudioSyllablesModule {}
