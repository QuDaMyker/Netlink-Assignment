import { BadRequestException, Injectable, Logger } from '@nestjs/common';
import { AudioAssessmentsRepository } from './audio_assessments.repository';
import { CreateAudioAssessmentsDto } from './dto/create-audio-assessments.dto';

@Injectable()
export class AudioAssessmentsService {
  constructor(
    private readonly audioAssessmentsRepository: AudioAssessmentsRepository,
  ) {}
  private readonly logger = new Logger(AudioAssessmentsService.name);

  async create(dto: CreateAudioAssessmentsDto) {
    return await this.audioAssessmentsRepository.create(dto);
  }

  async findById(id: string) {
    const audioAssessment = await this.audioAssessmentsRepository.findById(id);
    if (!audioAssessment) {
      throw new BadRequestException(`Audio assessment with id ${id} not found`);
    }
    return audioAssessment;
  }

  async getAverageScoreByUserId(userId: string) {
    return await this.audioAssessmentsRepository.getAverageScoreByUserId(
      userId,
    );
  }
}
