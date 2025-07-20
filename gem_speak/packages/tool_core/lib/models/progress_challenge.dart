class ProgressChallenge {
  final DateTime? progressDate;
  final String? pronunciation;
  final String? accuracy;
  final String? fluency;
  final String? completeness;

  ProgressChallenge({
    this.progressDate,
    this.pronunciation,
    this.accuracy,
    this.fluency,
    this.completeness,
  });

  factory ProgressChallenge.fromJson(Map<String, dynamic> json) {
    return ProgressChallenge(
      progressDate:
          json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      pronunciation: json['pronunciation'] as String?,
      accuracy: json['accuracy'] as String?,
      fluency: json['fluency'] as String?,
      completeness: json['completeness'] as String?,
    );
  }

  static List<ProgressChallenge> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => ProgressChallenge.fromJson(item)).toList();
  }
}
