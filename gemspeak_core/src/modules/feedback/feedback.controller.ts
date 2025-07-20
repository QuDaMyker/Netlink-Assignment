/* eslint-disable @typescript-eslint/no-unsafe-return */
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
import { UserAccess } from '../auth/decorator/public.decorator';

@Controller('feedback')
export class FeedbackController {
  constructor(private readonly feedbackService: FeedbackService) {}

  @Post('text')
  async getFeedbackFromText(@Body() text: { content: string }) {
    if (!text || !text.content)
      throw new BadRequestException('No text provided');
    return this.feedbackService.processText(text.content);
  }

  @Post('audio')
  @UseInterceptors(
    FileInterceptor('file', {
      dest: './uploads',
    }),
  )
  async getFeedbackFromAudio(
    @UserAccess('userId') userId: string,
    @UploadedFile() file: Express.Multer.File,
    @Body('questionId') questionId: string,
  ) {
    return this.feedbackService.processAudio(userId, file, questionId);
  }
}
