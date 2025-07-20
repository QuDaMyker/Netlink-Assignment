/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class SpeakingTopicsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAll() {
    return await this.prisma.speaking_topics.findMany({
      include: {
        questions: true,
      },
    });
  }

  async findById(id: string) {
    return await this.prisma.speaking_topics.findUnique({
      where: { id },
      include: {
        questions: true,
      },
    });
  }
}
