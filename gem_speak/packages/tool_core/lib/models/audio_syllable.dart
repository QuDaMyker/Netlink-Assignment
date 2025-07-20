class AudioSyllable {
  final String id;
  final String? wordId;
  final String? syllable;
  final int? accuracyScore;

  AudioSyllable({
    required this.id,
    required this.wordId,
    required this.syllable,
    required this.accuracyScore,
  });

  factory AudioSyllable.fromJson(Map<String, dynamic> json) {
    return AudioSyllable(
      id: json['id'] as String,
      wordId: json['word_id'] as String?,
      syllable: json['syllable'] as String?,
      accuracyScore: json['accuracy_score'] as int?,
    );
  }

  static List<AudioSyllable> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map((item) => AudioSyllable.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
