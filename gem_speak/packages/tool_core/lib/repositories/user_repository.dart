import 'package:dio/dio.dart';
import 'package:tool_core/models/audio_assessment.dart';
import 'package:tool_core/models/gemini_feedback.dart';
import 'package:tool_core/models/progress_challenge.dart';
import 'package:tool_core/models/pronunciation_assessment_azure_res.dart';
import 'package:tool_core/models/question.dart';
import 'package:tool_core/models/summary_learning.dart';
import 'package:tool_core/models/top_mistake.dart';
import 'package:tool_core/models/topic.dart';
import 'package:tool_core/models/user_answers.dart';
import 'package:tool_core/network/api_client.dart';
import 'package:tool_core/network/api_enpoints.dart';
import 'package:tool_core/network/api_response.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

class UserRepository implements IUserRepository {
  final ApiClient _apiClient;

  UserRepository(this._apiClient);

  @override
  Future<ApiResponse<Topic>> getTopicById(
    String topicId, {
    String? languageCode,
  }) {
    // TODO: implement getTopicById
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<List<Topic>>> getTopics({
    String? languageCode,
    String? difficultyLevel,
  }) async {
    try {
      final response = await _apiClient.get(ApiEnpoints.speakingTopics);
      final topics = Topic.fromMapList(response.data['data']);
      return ApiResponse.success(topics, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<List<Question>>> getQuestionsByTopicId(
    String topicId, {
    String? languageCode,
    String? difficultyLevel,
  }) {
    // TODO: implement getQuestionsByTopicId
    throw UnimplementedError();
  }

  @override
  Future<ApiResponse<PronunciationAssessmentAzureRes>> checkPronunciation({
    required String audioFilePath,
    required String text,
  }) async {
    try {
      final data = FormData.fromMap({
        'file': await MultipartFile.fromFile(audioFilePath),
        'text': text,
      });
      final response = await _apiClient.post(
        ApiEnpoints.pronunciationAssessment,
        data: data,
      );
      final assessment = PronunciationAssessmentAzureRes.fromJson(
        response.data['data'],
      );
      return ApiResponse.success(assessment, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<GeminiFeedback>> gemeniFeedBackAndPronunciationAssessment({
    required String audioFilePath,
    required String questionId,
  }) async {
    try {
      final data = FormData.fromMap({
        'file': await MultipartFile.fromFile(audioFilePath),
        'questionId': questionId,
      });
      final response = await _apiClient.post(
        ApiEnpoints.gemeniFeedback,
        data: data,
      );
      final geminiFeedback = GeminiFeedback.fromJson(response.data['data']);

      return ApiResponse.success(geminiFeedback, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<List<UserAnswers>>> getAllUserAnswers({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEnpoints.userAnswers,
        queryParameters: {'userId': userId},
      );
      final userAnswers = UserAnswers.fromMapList(
        response.data['data']['data'],
      );
      return ApiResponse.success(userAnswers, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<AudioAssessment>> getAudioAssessmentById({
    required String audioAssessmentId,
  }) async {
    try {
      final response = await _apiClient.get(
        '${ApiEnpoints.audioAssessments}/$audioAssessmentId',
      );
      final audioAssessment = AudioAssessment.fromJson(response.data['data']);
      return ApiResponse.success(audioAssessment, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<List<ProgressChallenge>>> getProgress({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEnpoints.progress.replaceAll('@userId', userId),
      );
      final progress = ProgressChallenge.fromJsonList(response.data['data']);
      return ApiResponse.success(progress, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<SummaryLearning>> getSummary({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEnpoints.summary.replaceAll('@userId', userId),
      );
      final progress = SummaryLearning.fromJson(response.data['data']);
      return ApiResponse.success(progress, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }

  @override
  Future<ApiResponse<TopMistake>> getTopMistakes({
    required String userId,
  }) async {
    try {
      final response = await _apiClient.get(
        ApiEnpoints.topMistakes.replaceAll('@userId', userId),
      );
      final progress = TopMistake.fromJson(response.data['data']);
      return ApiResponse.success(progress, response.data);
    } catch (e) {
      return ApiResponse.failed(e);
    }
  }
}
