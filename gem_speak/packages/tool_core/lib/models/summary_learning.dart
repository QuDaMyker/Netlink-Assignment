class SummaryLearning {
  final int? totalAnswers;
  final AverageScore? averageScore;

  SummaryLearning({this.totalAnswers, this.averageScore});

  factory SummaryLearning.fromJson(Map<String, dynamic> json) {
    return SummaryLearning(
      totalAnswers: int.tryParse(json['total_answers'].toString()),
      averageScore:
          json['average_scores'] != null
              ? AverageScore.fromJson(json['average_scores'])
              : null,
    );
  }
}

class AverageScore {
  final double? pronunciationScore;
  final double? accuracyScore;
  final double? fluencyScore;
  final double? completenessScore;

  AverageScore({
    required this.pronunciationScore,
    required this.accuracyScore,
    required this.fluencyScore,
    required this.completenessScore,
  });

  factory AverageScore.fromJson(Map<String, dynamic> json) {
    return AverageScore(
      pronunciationScore: double.tryParse(
        json['pronunciation_score'].toString(),
      ),
      accuracyScore: double.tryParse(json['accuracy_score'].toString()),
      fluencyScore: double.tryParse(json['fluency_score'].toString()),
      completenessScore: double.tryParse(json['completeness_score'].toString()),
    );
  }
}
