import 'package:tool_core/models/audio_word.dart';

class AudioAssessment {
  final String id;
  final String? userAnswerId;
  final String? originalText;
  final int? pronunciationScore;
  final int? accuracyScore;
  final int? fluencyScore;
  final int? completenessScore;
  final DateTime? createdAt;
  final String? geminiFeedback;
  final List<AudioWord>? audioWords;

  AudioAssessment({
    required this.id,
    this.userAnswerId,
    this.originalText,
    this.pronunciationScore,
    this.accuracyScore,
    this.fluencyScore,
    this.completenessScore,
    this.createdAt,
    this.geminiFeedback,
    this.audioWords,
  });

  factory AudioAssessment.fromJson(Map<String, dynamic> json) {
    final audioWords = AudioWord.fromJsonList(json['audio_words']);

    return AudioAssessment(
      id: json['id'] as String,
      userAnswerId: json['user_answer_id'] as String?,
      originalText: json['original_text'] as String?,
      pronunciationScore: json['pronunciation_score'] as int?,
      accuracyScore: json['accuracy_score'] as int?,
      fluencyScore: json['fluency_score'] as int?,
      completenessScore: json['completeness_score'] as int?,
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      geminiFeedback: json['gemini_feedback'] as String?,
      audioWords: audioWords,
    );
  }
}
