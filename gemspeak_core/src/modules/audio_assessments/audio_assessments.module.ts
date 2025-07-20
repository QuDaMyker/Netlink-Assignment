import { Module } from '@nestjs/common';
import { AudioAssessmentsService } from './audio_assessments.service';
import { AudioAssessmentsController } from './audio_assessments.controller';
import { AudioAssessmentsRepository } from './audio_assessments.repository';

@Module({
  controllers: [AudioAssessmentsController],
  providers: [AudioAssessmentsService, AudioAssessmentsRepository],
  exports: [AudioAssessmentsService],
})
export class AudioAssessmentsModule {}
