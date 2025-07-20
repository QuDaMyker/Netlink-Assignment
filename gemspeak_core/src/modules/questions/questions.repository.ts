/* eslint-disable @typescript-eslint/no-unsafe-return */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class QuestionsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAllByTopicId(topicId: string) {
    return await this.prisma.questions.findMany({
      where: { speaking_topics: { id: topicId } },
    });
  }

  async findById(id: string) {
    return await this.prisma.questions.findUnique({
      where: { id },
    });
  }
}
