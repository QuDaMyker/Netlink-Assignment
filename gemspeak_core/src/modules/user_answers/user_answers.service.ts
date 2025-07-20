import { Injectable, Logger } from '@nestjs/common';
import { UserAnswersRepository } from './user_answers.repository';
import { AudioAssessmentsService } from '../audio_assessments/audio_assessments.service';

@Injectable()
export class UserAnswersService {
  constructor(
    private readonly userAnswersRepository: UserAnswersRepository,
    private readonly audioAssessmentsService: AudioAssessmentsService,
  ) {}
  private readonly logger = new Logger(UserAnswersService.name);

  async findAll(
    userId: string,
    page = 1,
    limit = 10,
    sort = 'created_at',
    order: 'asc' | 'desc' = 'desc',
  ) {
    const offset = (page - 1) * limit;

    const [data, total] = await this.userAnswersRepository.findAllByUserId(
      userId,
      offset,
      limit,
      sort,
      order,
    );

    return {
      data,
      total,
      page,
      limit,
      totalPages: Math.ceil(total / limit),
    };
  }

  async create(data: {
    userId: string;
    questionId: string;
    audioFilePath: string;
    transcription: string;
  }) {
    return await this.userAnswersRepository.create(data);
  }

  async countAnswersByUserId(userId: string) {
    return await this.userAnswersRepository.countAnswersByUserId(userId);
  }
}
