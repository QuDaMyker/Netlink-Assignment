/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable } from '@nestjs/common';
import { SpeakingTopicsRepository } from './speaking_topics.repository';

@Injectable()
export class SpeakingTopicsService {
  constructor(
    private readonly speakingTopicsRepository: SpeakingTopicsRepository,
  ) {}

  async findAll() {
    return await this.speakingTopicsRepository.findAll();
  }

  async findById(id: string) {
    return await this.speakingTopicsRepository.findById(id);
  }
}
