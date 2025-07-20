import { Module } from '@nestjs/common';
import { FeedbackService } from './feedback.service';
import { FeedbackController } from './feedback.controller';
import { GeminiService } from '../gemini/gemini.service';
import { UserAnswersModule } from '../user_answers/user_answers.module';
import { QuestionsModule } from '../questions/questions.module';
import { PronnciationAssessmentAzureModule } from '../pronnciation_assessment_azure/pronnciation_assessment_azure.module';
import { AudioAssessmentsModule } from '../audio_assessments/audio_assessments.module';

@Module({
  imports: [
    UserAnswersModule,
    QuestionsModule,
    PronnciationAssessmentAzureModule,
    AudioAssessmentsModule,
  ],
  controllers: [FeedbackController],
  providers: [FeedbackService, GeminiService],
  exports: [FeedbackService],
})
export class FeedbackModule {}
