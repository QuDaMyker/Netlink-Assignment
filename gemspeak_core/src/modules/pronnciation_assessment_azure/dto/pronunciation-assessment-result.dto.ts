import { Expose } from 'class-transformer';

export class PhonemeDto {
  phoneme: string;
  @Expose({ name: 'accuracy_score' })
  accuracyScore: number;
  @Expose({ name: 'error_type' })
  errorType: string;

  constructor(partial: Partial<PhonemeDto>) {
    Object.assign(this, partial);
  }
}

export class SyllableDto {
  syllable: string;
  @Expose({ name: 'accuracy_score' })
  accuracyScore: number;

  constructor(partial: Partial<SyllableDto>) {
    Object.assign(this, partial);
  }
}

export class WordAssessmentDto {
  word: string;
  @Expose({ name: 'accuracy_score' })
  accuracyScore: number;
  @Expose({ name: 'error_type' })
  errorType: string;
  syllables?: SyllableDto[];
  phonemes?: PhonemeDto[];

  constructor(partial: Partial<WordAssessmentDto>) {
    Object.assign(this, partial);

    this.syllables = partial.syllables?.map((s) => new SyllableDto(s)) ?? [];

    this.phonemes = partial.phonemes?.map((p) => new PhonemeDto(p)) ?? [];
  }
}

export class PronunciationAssessmentResultDto {
  @Expose({ name: 'gemini_feedback' })
  geminiFeedback: string;
  @Expose({ name: 'pronunciation_score' })
  pronunciationScore: number;
  @Expose({ name: 'accuracy_score' })
  accuracyScore: number;
  @Expose({ name: 'fluency_score' })
  fluencyScore: number;
  @Expose({ name: 'completeness_score' })
  completenessScore: number;
  words: WordAssessmentDto[];

  constructor(partial: Partial<PronunciationAssessmentResultDto>) {
    Object.assign(this, partial);

    this.words = partial.words?.map((w) => new WordAssessmentDto(w)) ?? [];
  }
}
