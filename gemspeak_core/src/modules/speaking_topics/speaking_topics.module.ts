import { Module } from '@nestjs/common';
import { SpeakingTopicsService } from './speaking_topics.service';
import { SpeakingTopicsController } from './speaking_topics.controller';
import { SpeakingTopicsRepository } from './speaking_topics.repository';

@Module({
  controllers: [SpeakingTopicsController],
  providers: [SpeakingTopicsService, SpeakingTopicsRepository],
})
export class SpeakingTopicsModule {}
