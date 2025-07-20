/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Controller, Get, Param } from '@nestjs/common';
import { SpeakingTopicsService } from './speaking_topics.service';

@Controller('speaking-topics')
export class SpeakingTopicsController {
  constructor(private readonly speakingTopicsService: SpeakingTopicsService) {}

  @Get()
  async findAll() {
    return await this.speakingTopicsService.findAll();
  }

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.speakingTopicsService.findById(id);
  }
}
