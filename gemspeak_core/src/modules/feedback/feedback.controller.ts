import {
  BadRequestException,
  Body,
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { FeedbackService } from './feedback.service';

@Controller('feedback')
export class FeedbackController {
  constructor(private readonly feedbackService: FeedbackService) {}

  @Post('text')
  async getFeedbackFromText(@Body() text: { content: string }) {
    if (!text || !text.content) throw new BadRequestException('No text provided');
    return this.feedbackService.processText(text.content);
  }

  @Post('audio')
  @UseInterceptors(FileInterceptor('file', {
    dest: './uploads',
  })) 
  async getFeedbackFromAudio(@UploadedFile() file: Express.Multer.File) {
    return this.feedbackService.processAudio(file);
  }
}
