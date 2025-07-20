import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:tool_core/models/question.dart';

/// {
///   "id": "d454f839-d80e-47c1-8f66-d379d9375664",
///   "title": "Daily Life",
///   "description": "Everyday personal routines",
///   "created_at": "2025-07-19T01:10:54.292Z",
///   "questions": [
///     {
///       "id": "7fab155c-ee42-4b97-9128-3630086aae3f",
///       "question_text": "What time do you usually wake up?",
///       "language_code": "en-US",
///       "difficulty_level": "medium",
///       "topic": "d454f839-d80e-47c1-8f66-d379d9375664",
///       "created_at": "2025-07-19T01:23:44.426Z"
///     }
///   ]
/// }

class Topic {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final List<Question>? questions;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.questions,
  });

  Topic copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    List<Question>? questions,
  }) {
    return Topic(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'created_at': createdAt.millisecondsSinceEpoch,
      'questions': questions?.map((x) => x.toMap()).toList(),
    };
  }

  static List<Topic> fromMapList(dynamic list) {
    if (list == null) return [];
    if (list is! List) {
      throw ArgumentError('Expected a List, got ${list.runtimeType}');
    }
    return list.map((item) => Topic.fromMap(item)).toList();
  }

  factory Topic.fromMap(Map<String, dynamic> map) {
    return Topic(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt:
          DateTime.tryParse(map['created_at'] as String) ?? DateTime.now(),
      questions:
          map['questions'] != null
              ? Question.fromMapList(map['questions'])
              : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Topic.fromJson(String source) =>
      Topic.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Topic(id: $id, title: $title, description: $description, created_at: $createdAt, questions: $questions)';
  }

  @override
  bool operator ==(covariant Topic other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description &&
        other.createdAt == createdAt &&
        listEquals(other.questions, questions);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        createdAt.hashCode ^
        questions.hashCode;
  }
}
