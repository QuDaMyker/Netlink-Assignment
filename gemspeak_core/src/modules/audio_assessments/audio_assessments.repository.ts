import { Injectable, Logger } from '@nestjs/common';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateAudioAssessmentsDto } from './dto/create-audio-assessments.dto';

@Injectable()
export class AudioAssessmentsRepository {
  constructor(private readonly prisma: PrismaService) {}
  private readonly logger = new Logger(AudioAssessmentsRepository.name);

  async create(dto: CreateAudioAssessmentsDto) {
    return await this.prisma.audio_assessments.create({
      data: {
        user_answer_id: dto.userAnswerId,
        original_text: dto.originalText,
        pronunciation_score: dto.pronunciationAssessment.pronunciationScore,
        accuracy_score: dto.pronunciationAssessment.accuracyScore,
        fluency_score: dto.pronunciationAssessment.fluencyScore,
        completeness_score: dto.pronunciationAssessment.completenessScore,
        gemini_feedback: dto.pronunciationAssessment.geminiFeedback,
        audio_words: {
          create: dto.pronunciationAssessment.words?.map((word) => ({
            word: word.word,
            accuracy_score: word.accuracyScore,
            error_type: word.errorType,
            audio_phonemes: word.phonemes?.length
              ? {
                  create: word.phonemes?.map((p) => ({
                    phoneme: p.phoneme,
                    accuracy_score: p.accuracyScore,
                    error_type: p.errorType,
                  })),
                }
              : undefined,
            audio_syllables: word.syllables?.length
              ? {
                  create: word.syllables?.map((s) => ({
                    syllable: s.syllable,
                    accuracy_score: s.accuracyScore,
                  })),
                }
              : undefined,
          })),
        },
      },
    });
  }

  async findById(id: string) {
    return await this.prisma.audio_assessments.findUnique({
      where: { id },
      include: {
        audio_words: {
          include: {
            audio_phonemes: true,
            audio_syllables: true,
          },
        },
      },
    });
  }

  async getAverageScoreByUserId(userId: string) {
    const avg = await this.prisma.audio_assessments.aggregate({
      _avg: {
        pronunciation_score: true,
        accuracy_score: true,
        fluency_score: true,
        completeness_score: true,
      },
      where: { user_answers: { user_id: userId } },
    });
    return {
      pronunciation_score: avg._avg.pronunciation_score ?? 0,
      accuracy_score: avg._avg.accuracy_score ?? 0,
      fluency_score: avg._avg.fluency_score ?? 0,
      completeness_score: avg._avg.completeness_score ?? 0,
    };
  }
}
