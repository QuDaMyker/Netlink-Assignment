import { Controller } from '@nestjs/common';
import { AudioWordsService } from './audio_words.service';

@Controller('audio-words')
export class AudioWordsController {
  constructor(private readonly audioWordsService: AudioWordsService) {}
}
