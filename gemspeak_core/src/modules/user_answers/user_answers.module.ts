import { Module } from '@nestjs/common';
import { UserAnswersService } from './user_answers.service';
import { UserAnswersController } from './user_answers.controller';
import { UserAnswersRepository } from './user_answers.repository';
import { AudioAssessmentsModule } from '../audio_assessments/audio_assessments.module';

@Module({
  imports: [AudioAssessmentsModule],
  controllers: [UserAnswersController],
  providers: [UserAnswersService, UserAnswersRepository],
  exports: [UserAnswersService],
})
export class UserAnswersModule {}
