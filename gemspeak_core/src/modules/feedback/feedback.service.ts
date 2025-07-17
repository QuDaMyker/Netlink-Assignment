import { Injectable, NotFoundException } from '@nestjs/common';
import { GeminiService } from '../gemini/gemini.service';
import { transcribeAudio } from 'src/utils/stt.util';

@Injectable()
export class FeedbackService {
  constructor(private readonly gemini: GeminiService) {}

  async processText(text: string) {
    return this.gemini.sendPrompt(text);
  }

  async processAudio(file: Express.Multer.File) {
    if (!file) throw new NotFoundException('No audio file provided');
    const transcript = await transcribeAudio(file.path);
    return this.gemini.sendPrompt(transcript);
  }
}
