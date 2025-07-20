/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { BadRequestException, Injectable } from '@nestjs/common';
import { QuestionsRepository } from './questions.repository';

@Injectable()
export class QuestionsService {
  constructor(private readonly questionsRepository: QuestionsRepository) {}

  async findAllByTopicId(topicId: string) {
    const questions = await this.questionsRepository.findAllByTopicId(topicId);
    if (!questions || questions.length === 0) {
      return [];
    }
    // return {
    //   topicId,
    //   questions,
    // };
    return questions;
  }

  async findById(id: string) {
    return await this.questionsRepository.findById(id);
  }

  async findQuestionsById(id: string) {
    const question = await this.findById(id);
    if (!question) {
      throw new BadRequestException(`Question with ID ${id} not found`);
    }
    return question.question_text;
  }
}
