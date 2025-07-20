import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class UserStatsRepository {
  constructor(private readonly prisma: PrismaService) {}

  async getScoreAverageDayByUserId(userId: string) {
    const rawData = await this.prisma.$queryRaw`
    SELECT DATE(a."created_at") as date,
      AVG(a.pronunciation_score) as pronunciation,
      AVG(a.accuracy_score) as accuracy,
      AVG(a.fluency_score) as fluency,
      AVG(a.completeness_score) as completeness
    FROM audio_assessments a
    JOIN user_answers ua ON ua.id = a.user_answer_id
    WHERE ua.user_id = ${userId}::uuid
    GROUP BY DATE(a."created_at")
    ORDER BY DATE(a."created_at") ASC
  `;
    return rawData;
  }

  async getTopMistakesListByUserId(userId: string) {
    const words = await this.prisma.$queryRaw`
    SELECT w.word, COUNT(*)::int AS mistake_count
    FROM audio_words w
    JOIN audio_assessments a ON a.id = w.assessment_id
    JOIN user_answers ua ON ua.id = a.user_answer_id
    WHERE ua.user_id = ${userId}::uuid AND w.error_type IS NOT NULL
    GROUP BY w.word
    ORDER BY mistake_count DESC
    LIMIT 5
  `;

    const phonemes = await this.prisma.$queryRaw`
    SELECT p.phoneme, COUNT(*)::int AS mistake_count
    FROM audio_phonemes p
    JOIN audio_words w ON w.id = p.word_id
    JOIN audio_assessments a ON a.id = w.assessment_id
    JOIN user_answers ua ON ua.id = a.user_answer_id
    WHERE ua.user_id = ${userId}::uuid AND p.error_type IS NOT NULL
    GROUP BY p.phoneme
    ORDER BY mistake_count DESC
    LIMIT 5
  `;

    return { top_words: words, top_phonemes: phonemes };
  }
}
