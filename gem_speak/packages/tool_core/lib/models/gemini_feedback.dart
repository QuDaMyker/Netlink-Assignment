import 'package:tool_core/models/pronunciation_assessment_azure_res.dart';

class GeminiFeedback {
  final String transcript;
  final PronunciationAssessmentAzureRes pronunciationAssessment;

  GeminiFeedback({
    required this.transcript,
    required this.pronunciationAssessment,
  });

  factory GeminiFeedback.fromJson(Map<String, dynamic> json) {
    return GeminiFeedback(
      transcript: json['transcript'] as String,
      pronunciationAssessment: PronunciationAssessmentAzureRes.fromJson(
        json['pronunciation_assessment'],
      ),
    );
  }
}
