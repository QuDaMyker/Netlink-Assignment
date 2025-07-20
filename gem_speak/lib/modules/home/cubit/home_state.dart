// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

class HomeState extends Equatable {
  final SummaryLearning? summaryLearning;
  final List<ProgressChallenge>? progressChallenges;
  final TopMistake? topMistake;
  final bool isLoadingSummary;
  final bool isLoadingTopMistakes;
  final bool isLoadingProgressChallenges;
  final String? errorMessage;
  const HomeState({
    this.summaryLearning,
    this.progressChallenges,
    this.topMistake,
    this.isLoadingSummary = false,
    this.isLoadingTopMistakes = false,
    this.isLoadingProgressChallenges = false,
    this.errorMessage,
  });

  const HomeState.initial()
    : summaryLearning = null,
      progressChallenges = null,
      topMistake = null,
      isLoadingSummary = false,
      isLoadingTopMistakes = false,
      isLoadingProgressChallenges = false,
      errorMessage = null;

  @override
  List<Object?> get props => [
    summaryLearning,
    progressChallenges,
    topMistake,
    errorMessage,
    isLoadingSummary,
    isLoadingTopMistakes,
    isLoadingProgressChallenges,
  ];

  HomeState copyWith({
    SummaryLearning? summaryLearning,
    List<ProgressChallenge>? progressChallenges,
    TopMistake? topMistake,
    String? errorMessage,
    bool? isLoadingTopMistakes,
    bool? isLoadingProgressChallenges,
    bool? isLoadingSummary,
  }) {
    return HomeState(
      isLoadingTopMistakes: isLoadingTopMistakes ?? this.isLoadingTopMistakes,
      isLoadingProgressChallenges:
          isLoadingProgressChallenges ?? this.isLoadingProgressChallenges,
      isLoadingSummary: isLoadingSummary ?? this.isLoadingSummary,
      errorMessage: errorMessage ?? this.errorMessage,
      summaryLearning: summaryLearning ?? this.summaryLearning,
      progressChallenges: progressChallenges ?? this.progressChallenges,
      topMistake: topMistake ?? this.topMistake,
    );
  }
}
