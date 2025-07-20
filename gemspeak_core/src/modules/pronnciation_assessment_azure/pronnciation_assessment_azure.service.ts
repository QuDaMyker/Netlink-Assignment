/* eslint-disable @typescript-eslint/no-unsafe-argument */
/* eslint-disable @typescript-eslint/no-unsafe-call */
/* eslint-disable @typescript-eslint/no-unsafe-member-access */
/* eslint-disable @typescript-eslint/prefer-promise-reject-errors */
/* eslint-disable @typescript-eslint/no-unsafe-assignment */
// src/pronunciation-assessment/pronunciation-assessment.service.ts

import { Injectable, Logger } from '@nestjs/common';
import * as sdk from 'microsoft-cognitiveservices-speech-sdk';
import * as fs from 'fs';
import { PronunciationAssessmentResultDto } from './dto/pronunciation-assessment-result.dto';

@Injectable()
export class PronnciationAssessmentAzureService {
  private speechKey = process.env.AZURE_SPEECH_KEY || 'YOUR_SPEECH_KEY';
  private serviceRegion =
    process.env.AZURE_SPEECH_REGION || 'YOUR_SERVICE_REGION';

  private readonly logger = new Logger(PronnciationAssessmentAzureService.name);

  async assessPronunciation(
    filePath: string,
    referenceText: string,
  ): Promise<PronunciationAssessmentResultDto> {
    return new Promise((resolve, reject) => {
      const audioBuffer = fs.readFileSync(filePath);
      const audioConfig = sdk.AudioConfig.fromWavFileInput(audioBuffer);

      const speechConfig = sdk.SpeechConfig.fromSubscription(
        this.speechKey,
        this.serviceRegion,
      );
      speechConfig.speechRecognitionLanguage = 'en-US';

      const pronunciationConfig = new sdk.PronunciationAssessmentConfig(
        referenceText,
        sdk.PronunciationAssessmentGradingSystem.HundredMark,
        sdk.PronunciationAssessmentGranularity.Phoneme,
        true,
      );

      const recognizer = new sdk.SpeechRecognizer(speechConfig, audioConfig);
      pronunciationConfig.applyTo(recognizer);

      recognizer.recognizeOnceAsync(
        (result) => {
          console.log('Recognition result:', result);

          if (result.reason === sdk.ResultReason.RecognizedSpeech) {
            const json = JSON.parse(
              result.properties.getProperty(
                sdk.PropertyId.SpeechServiceResponse_JsonResult,
              ),
            );
            const pronunciationAssessment = this.convertDataResultToJson(json);
            // this.logger.log('Pronunciation assessment result:', res);
            resolve(pronunciationAssessment);
            // resolve(json);
          } else {
            console.error('Speech recognition failed:', result.errorDetails);
            reject(`Speech recognition failed. Reason: ${result.reason}`);
          }
        },
        (err) => reject(err),
      );
    });
  }

  private convertDataResultToJson(
    json: Record<string, any>,
  ): PronunciationAssessmentResultDto {
    const nBest = json.NBest?.[0];

    const assessment = nBest?.PronunciationAssessment ?? {};

    const resultDto: PronunciationAssessmentResultDto = {
      geminiFeedback: '',
      pronunciationScore: assessment.PronunciationScore ?? 0,
      accuracyScore: assessment.AccuracyScore ?? 0,
      fluencyScore: assessment.FluencyScore ?? 0,
      completenessScore: assessment.CompletenessScore ?? 0,
      words: (nBest?.Words ?? []).map((w) => ({
        word: w.Word,
        accuracyScore: w.PronunciationAssessment?.AccuracyScore ?? 0,
        errorType: w.PronunciationAssessment?.ErrorType ?? '',
        syllables: (w.Syllables ?? []).map((s) => ({
          syllable: s.Syllable,
          accuracyScore: s.PronunciationAssessment?.AccuracyScore ?? 0,
        })),
        phonemes: (w.Phonemes ?? []).map((p) => ({
          phoneme: p.Phoneme,
          accuracyScore: p.PronunciationAssessment?.AccuracyScore ?? 0,
          errorType: p.PronunciationAssessment?.ErrorType ?? '',
        })),
      })),
    };

    return resultDto;
  }
}
