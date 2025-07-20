import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/widgets/alert_dialog_widget.dart';
import 'package:gem_speak/common/widgets/animation_widget/circle_winner_widget.dart';
import 'package:gem_speak/common/widgets/common_button.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/modules/check_pronunciation/cubit/check_prounciation_cubit.dart';
import 'package:gem_speak/modules/check_pronunciation/widgets/circular_progress_assessment_widget.dart';
import 'package:tool_core/models/enum/difficulty_level.dart';
import 'package:tool_core/models/topic.dart';
import 'package:markdown/markdown.dart' as md;

class CheckPronunciationPage extends StatelessWidget {
  const CheckPronunciationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topic = context.watch<CheckProunciationCubit>().topic;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<CheckProunciationCubit>().onClickBack();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Check Pronunciation')),
        floatingActionButton: _buildNextQuestionButton(),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildQuestionAndActionRecord(
                      context,
                      topic: topic,
                      onTapReadQuestion: () {
                        context
                            .read<CheckProunciationCubit>()
                            .onClickReadQuestion();
                      },
                      onClickRecordAudio: () {
                        if (context
                                .read<CheckProunciationCubit>()
                                .state
                                .assessment !=
                            null) {
                          AlertDialogWidget.show(
                            context,
                            title: 'Notice',
                            content:
                                'You have already completed this question. Please proceed to the next question.',
                          );
                        } else {
                          context
                              .read<CheckProunciationCubit>()
                              .onClickRecordAudio();
                        }
                      },
                    ),
                    SizedBox(height: 32),
                    _buildActionsHandleFileRecord(),
                  ],
                ),
                SizedBox(height: 24),
                _buildResponseAsseessment(),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionsHandleFileRecord() {
    return BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
      builder: (context, state) {
        if (state.recordingPath == null) {
          return SizedBox.shrink();
        }
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 32),
          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.snow.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.maskGreen.withValues(alpha: 0.8),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(Icons.mic, color: AppColors.maskGreen),
                  Text(
                    state.recordingDuration != null
                        ? '${state.recordingDuration!.inMinutes}:${(state.recordingDuration!.inSeconds % 60).toString().padLeft(2, '0')}'
                        : '00:00',
                    style: TextStyle(color: AppColors.maskGreen),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
                    buildWhen:
                        (previous, current) =>
                            previous.isPlayingAudio != current.isPlayingAudio,
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () {
                          context
                              .read<CheckProunciationCubit>()
                              .onClickPlayAudio();
                        },
                        icon: Icon(
                          state.isPlayingAudio ? Icons.stop : Icons.play_arrow,
                          color: AppColors.beakInnter,
                        ),
                      );
                    },
                  ),
                  IconButton(
                    onPressed: () {
                      context
                          .read<CheckProunciationCubit>()
                          .onClickSendAudioToCheck();
                    },
                    icon: Icon(Icons.send, color: AppColors.featherGreen),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResponseAsseessment() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
          buildWhen:
              (previous, current) =>
                  previous.isCheckingPronunciation !=
                      current.isCheckingPronunciation ||
                  previous.assessment != current.assessment ||
                  previous.errorMessage != current.errorMessage,
          builder: (context, state) {
            if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      state.errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    CommonButton(
                      onPressed: () {
                        context
                            .read<CheckProunciationCubit>()
                            .onClickSendAudioToCheck();
                      },
                      text: 'Try Again',
                    ),
                  ],
                ),
              );
            }

            if (state.isCheckingPronunciation) {
              return Center(
                child: LoadingWidget(size: 80, backgroundColor: AppColors.snow),
              );
            }
            if (state.assessment != null) {
              final assessment = state.assessment!;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CircularProgressAssessmentWidget(
                          title: 'Overall Score',
                          value:
                              assessment
                                  .pronunciationAssessment
                                  .completenessScore!
                                  .toDouble() /
                              100,
                        ),
                      ),
                      Expanded(
                        child: CircularProgressAssessmentWidget(
                          title: 'Pronunciation',
                          value:
                              assessment
                                  .pronunciationAssessment
                                  .pronunciationScore!
                                  .toDouble() /
                              100,
                        ),
                      ),
                      Expanded(
                        child: CircularProgressAssessmentWidget(
                          title: 'Fluency',
                          value:
                              assessment.pronunciationAssessment.fluencyScore!
                                  .toDouble() /
                              100,
                        ),
                      ),
                      Expanded(
                        child: CircularProgressAssessmentWidget(
                          title: 'Accuracy',
                          value:
                              assessment.pronunciationAssessment.accuracyScore!
                                  .toDouble() /
                              100,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(height: 24),
        BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
          buildWhen:
              (previous, current) =>
                  previous.isSendingAudio != current.isSendingAudio,
          builder: (context, state) {
            if (state.isSendingAudio) {
              return Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.snow.withAlpha(200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.maskGreen.withAlpha(200),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  'Sending audio for assessment...',
                  style: TextStyle(fontSize: 16, color: AppColors.textColor),
                  textAlign: TextAlign.center,
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
        BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
          buildWhen:
              (previous, current) => previous.assessment != current.assessment,
          builder: (context, state) {
            if (state.assessment != null) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.snow.withAlpha(200),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.maskGreen.withAlpha(200),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: _buildGeminiFeedbackBox(
                  context,
                  state.assessment!.pronunciationAssessment.geminiFeedback ??
                      '',
                ),
              );
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Widget _buildGeminiFeedbackBox(BuildContext context, String feedback) {
    return ExpansionTile(
      initiallyExpanded: true,
      title: const Text('View Detailed Feedback'),
      children: [_buildHtml(context, feedback)],
    );
  }

  Widget _buildHtml(BuildContext context, String markdownContent) {
    final htmlContent = md.markdownToHtml(markdownContent);
    return Html(
      data: """
        ${htmlContent}
        """,
    );
  }

  Widget _buildNextQuestionButton() {
    return BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
      builder: (context, state) {
        if (state.isLastQuestion) {
          return SizedBox.shrink();
        }
        return InkWell(
          onTap: context.read<CheckProunciationCubit>().onClickNextQuestion,
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: AppColors.maskGreen.withValues(alpha: 0.8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.forward, color: AppColors.snow),
                SizedBox(width: 8),
                Text(
                  'Next',
                  style: TextStyle(
                    color: AppColors.snow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionAndActionRecord(
    BuildContext context, {
    required Topic topic,
    required Function()? onTapReadQuestion,
    required Function()? onClickRecordAudio,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 32),
        Text(
          '🗣️ Repeat this sentence',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: InkWell(
                onTap: onTapReadQuestion,
                borderRadius: BorderRadius.circular(24),
                splashColor: AppColors.maskGreen.withValues(alpha: 0.3),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 48),
                  decoration: BoxDecoration(
                    color: AppColors.snow.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.maskGreen.withValues(alpha: 0.8),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: BlocBuilder<
                    CheckProunciationCubit,
                    CheckProunciationState
                  >(
                    buildWhen:
                        (previous, current) =>
                            previous.currentIndexQuestion !=
                            current.currentIndexQuestion,
                    builder: (context, state) {
                      final Color questionColor = switch (topic
                          .questions?[state.currentIndexQuestion]
                          .difficultyLevel) {
                        DifficultyLevel.easy => AppColors.featherGreen,
                        DifficultyLevel.medium => AppColors.beakLower,
                        DifficultyLevel.hard => AppColors.cardinal,
                        null => throw UnimplementedError(),
                      };
                      return Text(
                        topic
                                .questions?[state.currentIndexQuestion]
                                .questionText ??
                            'No question available',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: questionColor,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              top: 4,
              left: 16,
              child: TextButton(
                onPressed: onTapReadQuestion,
                child: Text('📣', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
        SizedBox(height: 36),
        Text(
          'Press the mic button and repeat the sentence',
          style: TextStyle(fontSize: 16, color: AppColors.textColor),
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 12),
        BlocBuilder<CheckProunciationCubit, CheckProunciationState>(
          buildWhen:
              (previous, current) =>
                  previous.isRecording != current.isRecording,
          builder: (context, state) {
            final _micWidget = InkWell(
              onTap: onClickRecordAudio,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.bee,
                child: Icon(Icons.mic, size: 32, color: AppColors.snow),
              ),
            );
            if (state.isRecording) {
              return CircleWinnerWidget(
                colors: [
                  AppColors.maskGreen.withValues(alpha: .5),
                  AppColors.featherGreen,
                ],
                size: 80,
                thinness: 1,
                child: Padding(padding: EdgeInsets.all(2), child: _micWidget),
              );
            } else {
              return _micWidget;
            }
          },
        ),
      ],
    );
  }
}
