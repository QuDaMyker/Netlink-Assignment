class PronunciationAssessmentAzureRes {
  final PronunciationAssessment pronunciationAssessment;

  PronunciationAssessmentAzureRes({required this.pronunciationAssessment});

  factory PronunciationAssessmentAzureRes.fromJson(Map<String, dynamic> json) {
    return PronunciationAssessmentAzureRes(
      pronunciationAssessment: PronunciationAssessment.fromJson(json),
    );
  }
}

class PronunciationAssessment {
  final String? id;
  final String? geminiFeedback;
  final int? pronunciationScore;
  final int? accuracyScore;
  final int? fluencyScore;
  final int? completenessScore;
  final List<WordAssessment>? wordAssessments;

  PronunciationAssessment({
    this.id,
    this.geminiFeedback,
    this.pronunciationScore,
    this.accuracyScore,
    this.fluencyScore,
    this.completenessScore,
    this.wordAssessments,
  });

  factory PronunciationAssessment.fromJson(Map<String, dynamic> json) {
    final wordAssessmentsJson = json['words'] as List<dynamic>? ?? [];
    final wordAssessments =
        wordAssessmentsJson
            .map<WordAssessment>((word) => WordAssessment.fromJson(word))
            .toList();

    return PronunciationAssessment(
      id: json['id'] as String?,
      geminiFeedback: json['gemini_feedback'] as String?,
      pronunciationScore: json['pronunciation_score'] as int?,
      accuracyScore: json['accuracy_score'] as int?,
      fluencyScore: json['fluency_score'] as int?,
      completenessScore: json['completeness_score'] as int?,
      wordAssessments: wordAssessments,
    );
  }
}

class WordAssessment {
  final String word;
  final int accuracyScore;
  final String? errorType;
  final List<Syllable>? syllables;
  final List<Phoneme>? phonemes;

  WordAssessment({
    required this.word,
    required this.accuracyScore,
    this.errorType,
    this.syllables,
    this.phonemes,
  });

  factory WordAssessment.fromJson(Map<String, dynamic> json) {
    final syllablesJson = json['syllables'];
    final phonemesJson = json['phonemes'];

    return WordAssessment(
      word: json['word'] as String,
      accuracyScore: json['accuracy_score'] as int,
      errorType: json['error_type'] as String?,
      syllables:
          syllablesJson?.map<Syllable>((s) => Syllable.fromJson(s)).toList(),
      phonemes: phonemesJson?.map<Phoneme>((p) => Phoneme.fromJson(p)).toList(),
    );
  }
}

class Syllable {
  final String syllable;
  final int accuracyScore;
  final String? errorType;

  Syllable({
    required this.syllable,
    required this.accuracyScore,
    this.errorType,
  });

  factory Syllable.fromJson(Map<String, dynamic> json) {
    return Syllable(
      syllable: json['syllable'] as String,
      accuracyScore: json['accuracy_score'] as int,
      errorType: json['error_type'] as String?,
    );
  }
}

class Phoneme {
  final String phoneme;
  final int accuracyScore;
  final String? errorType;

  Phoneme({required this.phoneme, required this.accuracyScore, this.errorType});

  factory Phoneme.fromJson(Map<String, dynamic> json) {
    return Phoneme(
      phoneme: json['phoneme'] as String,
      accuracyScore: json['accuracy_score'] as int,
      errorType: json['error_type'] as String?,
    );
  }
}
