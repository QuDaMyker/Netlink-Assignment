import {
  Body,
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { PronnciationAssessmentAzureService } from './pronnciation_assessment_azure.service';
import { FileInterceptor } from '@nestjs/platform-express';

@Controller('pronnciation-assessment-azure')
export class PronnciationAssessmentAzureController {
  constructor(
    private readonly pronnciationAssessmentAzureService: PronnciationAssessmentAzureService,
  ) {}

  @Post()
  @UseInterceptors(FileInterceptor('file', { dest: './uploads' }))
  async assess(
    @UploadedFile() file: Express.Multer.File,
    @Body('text') text: string,
  ) {
    const filePath = file.path;
    return this.pronnciationAssessmentAzureService.assessPronunciation(
      filePath,
      text,
    );
  }
}
