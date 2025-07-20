import { Module } from '@nestjs/common';
import { UserStatsController } from './user_stats.controller';
import { UserStatsService } from './user_stats.service';
import { AudioAssessmentsModule } from '../audio_assessments/audio_assessments.module';
import { UserAnswersModule } from '../user_answers/user_answers.module';
import { UserStatsRepository } from './user_stats.repository';

@Module({
  imports: [AudioAssessmentsModule, UserAnswersModule],
  controllers: [UserStatsController],
  providers: [UserStatsService, UserStatsRepository],
})
export class UserStatsModule {}
