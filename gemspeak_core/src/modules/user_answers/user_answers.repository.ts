import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserAnswersRepository {
  constructor(private readonly prisma: PrismaService) {}

  async findAllByUserId(
    userId: string,
    offset: number,
    limit: number,
    sort: string,
    order: 'asc' | 'desc',
  ) {
    return await this.prisma.$transaction([
      this.prisma.user_answers.findMany({
        where: { user_id: userId },
        include: {
          users: false,
          questions: true,
          audio_assessments: true,
        },
        skip: offset,
        take: limit,
        orderBy: {
          [sort]: order === 'desc' ? 'desc' : 'asc',
        },
      }),
      this.prisma.user_answers.count({
        where: { user_id: userId },
      }),
    ]);
  }

  async create(data: {
    userId: string;
    questionId: string;
    audioFilePath: string;
    transcription: string;
  }) {
    return await this.prisma.user_answers.create({
      data: {
        user_id: data.userId,
        question_id: data.questionId,
        audio_file_path: data.audioFilePath,
        transcription: data.transcription,
      },
      include: {
        users: true,
        questions: true,
      },
    });
  }

  async countAnswersByUserId(userId: string) {
    return await this.prisma.user_answers.count({
      where: { user_id: userId },
    });
  }
}
