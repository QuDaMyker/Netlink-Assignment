import { Controller } from '@nestjs/common';
import { AudioPhonemesService } from './audio_phonemes.service';

@Controller('audio-phonemes')
export class AudioPhonemesController {
  constructor(private readonly audioPhonemesService: AudioPhonemesService) {}
}
