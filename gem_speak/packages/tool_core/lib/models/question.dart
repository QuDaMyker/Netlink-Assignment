import 'dart:convert';

import 'package:tool_core/models/enum/difficulty_level.dart';

/// {
///                "id": "7fab155c-ee42-4b97-9128-3630086aae3f",
///                "question_text": "What time do you usually wake up?",
///                "language_code": "en-US",
///                "difficulty_level": "medium",
///                "topic": "d454f839-d80e-47c1-8f66-d379d9375664",
///                "created_at": "2025-07-19T01:23:44.426Z"
///            },
///            "created_at": "2025-07-19T01:23:44.426Z"
///        },

class Question {
  final String id;
  final String? questionText;
  final String? languageCode;
  final DifficultyLevel? difficultyLevel;
  final String? topic;
  final DateTime? createdAt;

  Question({
    required this.id,
    required this.questionText,
    required this.languageCode,
    required this.difficultyLevel,
    required this.topic,
    required this.createdAt,
  });

  Question copyWith({
    String? id,
    String? questionText,
    String? languageCode,
    DifficultyLevel? difficultyLevel,
    String? topic,
    DateTime? createdAt,
  }) {
    return Question(
      id: id ?? this.id,
      questionText: questionText ?? this.questionText,
      languageCode: languageCode ?? this.languageCode,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      topic: topic ?? this.topic,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static List<Question> fromMapList(dynamic list) {
    if (list == null) return [];
    if (list is! List) {
      throw ArgumentError('Expected a List, got ${list.runtimeType}');
    }
    return list.map((item) => Question.fromMap(item)).toList();
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_text': questionText,
      'language_code': languageCode,
      'difficulty_level': difficultyLevel,
      'topic': topic,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      questionText: map['question_text'] as String,
      languageCode: map['language_code'] as String,
      difficultyLevel: DifficultyLevelExtension.fromString(
        map['difficulty_level'] as String,
      ),
      topic: map['topic'] as String,
      createdAt:
          DateTime.tryParse(map['created_at'] as String) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question_text: $questionText, language_code: $languageCode, difficulty_level: $difficultyLevel, topic: $topic, created_at: $createdAt)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.questionText == questionText &&
        other.languageCode == languageCode &&
        other.difficultyLevel == difficultyLevel &&
        other.topic == topic &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        questionText.hashCode ^
        languageCode.hashCode ^
        difficultyLevel.hashCode ^
        topic.hashCode ^
        createdAt.hashCode;
  }
}
