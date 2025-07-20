class AudioPhonem {
  final String id;
  final String? wordId;
  final String? phoneme;
  final int? accuracyScore;
  final String? errorType;

  AudioPhonem({
    required this.id,
    this.wordId,
    this.phoneme,
    this.accuracyScore,
    this.errorType,
  });

  factory AudioPhonem.fromJson(Map<String, dynamic> json) {
    return AudioPhonem(
      id: json['id'] as String,
      wordId: json['word_id'] as String?,
      phoneme: json['phoneme'] as String?,
      accuracyScore: json['accuracy_score'] as int?,
      errorType: json['error_type'] as String?,
    );
  }

  static List<AudioPhonem> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map((item) => AudioPhonem.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
