import 'package:tool_core/models/audio_phonem.dart';
import 'package:tool_core/models/audio_syllable.dart';

class AudioWord {
  final String id;
  final String? assessmentId;
  final String? word;
  final int? accuracyScore;
  final String? errorType;
  final List<AudioSyllable>? audioSyllables;
  final List<AudioPhonem>? audioPhonemes;

  AudioWord({
    required this.id,
    this.assessmentId,
    this.word,
    this.accuracyScore,
    this.errorType,
    this.audioSyllables,
    this.audioPhonemes,
  });

  factory AudioWord.fromJson(Map<String, dynamic> json) {
    final syllablesJson = json['syllables'] as List?;
    final phonemesJson = json['phonemes'] as List?;

    return AudioWord(
      id: json['id'] as String,
      assessmentId: json['assessment_id'] as String?,
      word: json['word'] as String?,
      accuracyScore: json['accuracy_score'] as int?,
      errorType: json['error_type'] as String?,
      audioSyllables: AudioSyllable.fromJsonList(syllablesJson),
      audioPhonemes: AudioPhonem.fromJsonList(phonemesJson),
    );
  }

  static List<AudioWord> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map((item) => AudioWord.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
