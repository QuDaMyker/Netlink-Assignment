import { Module } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { FeedbackController } from './feedback.controller';
import { GeminiService } from '../gemini/gemini.service';

@Module({
  controllers: [FeedbackController],
  providers: [FeedbackService, GeminiService],
})
export class FeedbackModule {}
