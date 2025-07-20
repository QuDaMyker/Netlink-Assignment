import { Injectable } from '@nestjs/common';
import { AudioAssessmentsService } from '../audio_assessments/audio_assessments.service';
import { UserAnswersService } from '../user_answers/user_answers.service';
import { UserStatsRepository } from './user_stats.repository';

@Injectable()
export class UserStatsService {
  constructor(
    private readonly userStatsRepository: UserStatsRepository,
    private readonly audioAssessmentsService: AudioAssessmentsService,
    private readonly userAnswersService: UserAnswersService,
  ) {}

  async getSummaryByUserId(userId: string) {
    const totalAnswers =
      await this.userAnswersService.countAnswersByUserId(userId);
    const avg =
      await this.audioAssessmentsService.getAverageScoreByUserId(userId);

    return {
      total_answers: totalAnswers,
      average_scores: avg,
    };
  }

  async getScoreAverageDayByUserId(userId: string) {
    return await this.userStatsRepository.getScoreAverageDayByUserId(userId);
  }

  async getTopMistakesByUserId(userId: string) {
    return await this.userStatsRepository.getTopMistakesListByUserId(userId);
  }
}
