/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Controller, Get, Param } from '@nestjs/common';
import { QuestionsService } from './questions.service';

@Controller('questions')
export class QuestionsController {
  constructor(private readonly questionsService: QuestionsService) {}

  @Get(':topicId')
  async findAllByTopicId(@Param('topicId') topicId: string) {
    return await this.questionsService.findAllByTopicId(topicId);
  }
}
