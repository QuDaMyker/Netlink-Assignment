import { Module } from '@nestjs/common';
import { AudioWordsService } from './audio_words.service';
import { AudioWordsController } from './audio_words.controller';

@Module({
  controllers: [AudioWordsController],
  providers: [AudioWordsService],
})
export class AudioWordsModule {}
