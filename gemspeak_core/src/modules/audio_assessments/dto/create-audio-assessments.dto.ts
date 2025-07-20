import { Expose } from 'class-transformer';
import { PronunciationAssessmentResultDto } from 'src/modules/pronnciation_assessment_azure/dto/pronunciation-assessment-result.dto';

export class CreateAudioAssessmentsDto {
  userAnswerId: string;
  originalText: string;
  @Expose({ name: 'pronunciation_assessment' })
  pronunciationAssessment: PronunciationAssessmentResultDto;

  constructor(partial: Partial<CreateAudioAssessmentsDto>) {
    Object.assign(this, partial);
  }
}
