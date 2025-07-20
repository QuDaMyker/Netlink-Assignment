import 'package:tool_core/models/audio_assessment.dart';
import 'package:tool_core/models/gemini_feedback.dart';
import 'package:tool_core/models/progress_challenge.dart';
import 'package:tool_core/models/pronunciation_assessment_azure_res.dart';
import 'package:tool_core/models/question.dart';
import 'package:tool_core/models/summary_learning.dart';
import 'package:tool_core/models/top_mistake.dart';
import 'package:tool_core/models/topic.dart';
import 'package:tool_core/models/user_answers.dart';
import 'package:tool_core/network/api_response.dart';

abstract class IUserRepository {
  Future<ApiResponse<List<Topic>>> getTopics({
    String? languageCode,
    String? difficultyLevel,
  });

  Future<ApiResponse<Topic>> getTopicById(
    String topicId, {
    String? languageCode,
  });

  Future<ApiResponse<List<Question>>> getQuestionsByTopicId(
    String topicId, {
    String? languageCode,
    String? difficultyLevel,
  });

  Future<ApiResponse<PronunciationAssessmentAzureRes>> checkPronunciation({
    required String audioFilePath,
    required String text,
  });

  Future<ApiResponse<GeminiFeedback>> gemeniFeedBackAndPronunciationAssessment({
    required String audioFilePath,
    required String questionId,
  });

  Future<ApiResponse<List<UserAnswers>>> getAllUserAnswers({
    required String userId,
  });

  Future<ApiResponse<AudioAssessment>> getAudioAssessmentById({
    required String audioAssessmentId,
  });

  Future<ApiResponse<SummaryLearning>> getSummary({required String userId});

  Future<ApiResponse<List<ProgressChallenge>>> getProgress({
    required String userId,
  });

  Future<ApiResponse<TopMistake>> getTopMistakes({required String userId});
}
