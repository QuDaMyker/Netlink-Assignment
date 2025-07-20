import { Controller } from '@nestjs/common';
import { AudioSyllablesService } from './audio_syllables.service';

@Controller('audio-syllables')
export class AudioSyllablesController {
  constructor(private readonly audioSyllablesService: AudioSyllablesService) {}
}
