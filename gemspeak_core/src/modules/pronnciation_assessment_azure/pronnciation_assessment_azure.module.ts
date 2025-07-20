import { Module } from '@nestjs/common';
import { PronnciationAssessmentAzureController } from './pronnciation_assessment_azure.controller';
import { UserAnswersModule } from '../user_answers/user_answers.module';
import { PronnciationAssessmentAzureService } from './pronnciation_assessment_azure.service';

@Module({
  imports: [UserAnswersModule],
  controllers: [PronnciationAssessmentAzureController],
  exports: [PronnciationAssessmentAzureService],
  providers: [PronnciationAssessmentAzureService],
})
export class PronnciationAssessmentAzureModule {}
