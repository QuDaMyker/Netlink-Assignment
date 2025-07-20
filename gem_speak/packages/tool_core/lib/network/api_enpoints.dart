abstract class ApiEnpoints {
  static const String login = '/auth/sign-in';
  static const String refreshToken = '/auth/refresh-tokens';
  static const String validateToken = '/auth/validate-token';

  static const String speakingTopics = '/speaking-topics';
  static const String pronunciationAssessment =
      '/pronnciation-assessment-azure';
  static const String gemeniFeedback = '/feedback/audio';
  static const String userAnswers = '/user-answers';
  static const String audioAssessments = '/audio-assessments';
  static const String summary = '/user-stats/@userId/summary';
  static const String progress = '/user-stats/@userId/progress';
  static const String topMistakes = '/user-stats/@userId/top-mistakes';
}
