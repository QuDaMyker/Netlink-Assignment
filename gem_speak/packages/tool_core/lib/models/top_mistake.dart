class TopMistake {
  final List<WordMistake>? wordMistakes;
  final List<PhonemeMistake>? phonemeMistakes;

  TopMistake({this.wordMistakes, this.phonemeMistakes});

  factory TopMistake.fromJson(Map<String, dynamic> json) {
    return TopMistake(
      wordMistakes: WordMistake.fromJsonList(json['top_words']),
      phonemeMistakes: PhonemeMistake.fromJsonList(json['top_phonemes']),
    );
  }
}

class WordMistake {
  final String word;
  final int mistakeCount;

  WordMistake({required this.word, required this.mistakeCount});

  factory WordMistake.fromJson(Map<String, dynamic> json) {
    return WordMistake(
      word: json['word'] as String,
      mistakeCount: json['mistake_count'] as int,
    );
  }

  static List<WordMistake> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => WordMistake.fromJson(item)).toList();
  }
}

class PhonemeMistake {
  final String phoneme;
  final int mistakeCount;

  PhonemeMistake({required this.phoneme, required this.mistakeCount});

  factory PhonemeMistake.fromJson(Map<String, dynamic> json) {
    return PhonemeMistake(
      phoneme: json['phoneme'] as String,
      mistakeCount: json['mistake_count'] as int,
    );
  }

  static List<PhonemeMistake> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => PhonemeMistake.fromJson(item)).toList();
  }
}
