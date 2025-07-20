import 'package:tool_core/models/pronunciation_assessment_azure_res.dart';
import 'package:tool_core/models/question.dart';

class UserAnswers {
  final String id;
  final String userId;
  final String questionId;
  final String? transcript;
  final DateTime? createdAt;
  final Question? question;
  final List<PronunciationAssessment>? assessments;

  UserAnswers({
    required this.id,
    required this.userId,
    required this.questionId,
    this.transcript,
    this.createdAt,
    this.question,
    this.assessments,
  });

  UserAnswers copyWith({
    String? id,
    String? userId,
    String? questionId,
    String? transcript,
    DateTime? createdAt,
    Question? question,
    List<PronunciationAssessment>? assessments,
  }) {
    return UserAnswers(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      transcript: transcript ?? this.transcript,
      createdAt: createdAt ?? this.createdAt,
      question: question ?? this.question,
      assessments: assessments ?? this.assessments,
    );
  }

  static List<UserAnswers> fromMapList(dynamic list) {
    if (list == null) return [];
    if (list is! List) {
      throw ArgumentError('Expected a List, got ${list.runtimeType}');
    }
    return list.map((item) => UserAnswers.fromJson(item)).toList();
  }

  factory UserAnswers.fromJson(Map<String, dynamic> map) {
    return UserAnswers(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      questionId: map['question_id'] as String,
      transcript:
          map['transcription'] != null ? map['transcription'] as String : null,
      createdAt:
          map['created_at'] != null
              ? DateTime.tryParse(map['created_at'] as String)
              : DateTime.now(),
      question:
          map['questions'] != null
              ? Question.fromMap(map['questions'] as Map<String, dynamic>)
              : null,
      assessments:
          map['audio_assessments'] != null
              ? List<PronunciationAssessment>.from(
                (map['audio_assessments'] as List<dynamic>)
                    .map<PronunciationAssessment?>(
                      (x) => PronunciationAssessment.fromJson(x),
                    ),
              )
              : <PronunciationAssessment>[],
    );
  }
}
