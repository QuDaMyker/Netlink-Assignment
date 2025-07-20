import { Module } from '@nestjs/common';
import { AudioSyllablesService } from './audio_syllables.service';
import { AudioSyllablesController } from './audio_syllables.controller';

@Module({
  controllers: [AudioSyllablesController],
  providers: [AudioSyllablesService],
})
export class AudioSyllablesModule {}
