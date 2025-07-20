/* eslint-disable @typescript-eslint/no-unsafe-assignment */
/* eslint-disable @typescript-eslint/no-unsafe-return */
import { BadRequestException, Injectable } from '@nestjs/common';
import { GeminiService } from '../gemini/gemini.service';
import { transcribeAudio } from 'src/utils/stt.util';
import { UserAnswersService } from '../user_answers/user_answers.service';
import { QuestionsService } from '../questions/questions.service';
import { PronnciationAssessmentAzureService } from '../pronnciation_assessment_azure/pronnciation_assessment_azure.service';
import { CreateAudioAssessmentsDto } from '../audio_assessments/dto/create-audio-assessments.dto';
import { PronunciationAssessmentResultDto } from '../pronnciation_assessment_azure/dto/pronunciation-assessment-result.dto';
import { AudioAssessmentsService } from '../audio_assessments/audio_assessments.service';
import { instanceToPlain } from 'class-transformer';

@Injectable()
export class FeedbackService {
  constructor(
    private readonly gemini: GeminiService,
    private readonly userAnswersService: UserAnswersService,
    private readonly questionsService: QuestionsService,
    private readonly pronnciationAssessmentAzureService: PronnciationAssessmentAzureService,
    private readonly audioAssessmentsService: AudioAssessmentsService,
  ) {}

  async processText(text: string, question?: string) {
    return this.gemini.sendPrompt(text, question ? question : '');
  }

  async processAudio(
    userId: string,
    file: Express.Multer.File,
    questionId: string,
  ) {
    if (!file) throw new BadRequestException('No audio file provided');
    if (!questionId) throw new BadRequestException('No question ID provided');
    const question = await this.questionsService.findQuestionsById(questionId);
    const transcript = await transcribeAudio(file.path);
    const feedback = await this.gemini.sendPrompt(transcript, question);
    const pronunciationAssessment =
      await this.pronnciationAssessmentAzureService.assessPronunciation(
        file.path,
        transcript,
      );
    const userAnswer = await this.userAnswersService.create({
      userId: userId,
      questionId,
      audioFilePath: file.path,
      transcription: transcript,
    });

    const pronunciationAssessmentDto = new PronunciationAssessmentResultDto({
      accuracyScore: pronunciationAssessment?.accuracyScore ?? 0,
      fluencyScore: pronunciationAssessment?.fluencyScore ?? 0,
      completenessScore: pronunciationAssessment?.completenessScore ?? 0,
      pronunciationScore: pronunciationAssessment?.pronunciationScore ?? 0,
      words: pronunciationAssessment?.words ?? [],
      geminiFeedback: feedback,
    });
    const createAudioAssessmentsDto = new CreateAudioAssessmentsDto({
      userAnswerId: userAnswer.id,
      originalText: transcript,
      pronunciationAssessment: pronunciationAssessmentDto,
    });

    await this.audioAssessmentsService.create(createAudioAssessmentsDto);

    return {
      transcript,
      // feedback,
      pronunciation_assessment: instanceToPlain(pronunciationAssessmentDto),
    };
  }
}
