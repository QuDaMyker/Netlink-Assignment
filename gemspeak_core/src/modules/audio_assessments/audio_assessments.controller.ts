/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Controller, Get, Param } from '@nestjs/common';
import { AudioAssessmentsService } from './audio_assessments.service';

@Controller('audio-assessments')
export class AudioAssessmentsController {
  constructor(
    private readonly audioAssessmentsService: AudioAssessmentsService,
  ) {}

  @Get(':id')
  async findById(@Param('id') id: string) {
    return await this.audioAssessmentsService.findById(id);
  }
}
