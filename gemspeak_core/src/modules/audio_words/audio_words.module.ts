import { Module } from '@nestjs/common';
import { AudioWordsService } from './audio_words.service';

@Module({
  providers: [AudioWordsService],
})
export class AudioWordsModule {}
