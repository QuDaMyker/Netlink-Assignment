import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/widgets/loading_widget.dart';
import 'package:gem_speak/modules/review_answer/cubit/review_answer_cubit.dart';
import 'package:tool_core/models/audio_assessment.dart';
import 'package:tool_core/models/audio_word.dart';
import 'package:markdown/markdown.dart' as md;

class ReviewAnswerPage extends StatelessWidget {
  const ReviewAnswerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Assessment Detail')),
      body: BlocBuilder<ReviewAnswerCubit, ReviewAnswerState>(
        builder: (context, state) {
          if (state is ReviewAnswerLoading) {
            return const Center(
              child: LoadingWidget(backgroundColor: AppColors.snow),
            );
          } else if (state is ReviewAnswerLoaded) {
            final AudioAssessment assessment = state.assessment;
            final List<AudioWord> words = assessment.audioWords ?? [];
            return SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '"${assessment.originalText}"',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Submitted at: ${assessment.createdAt?.toLocal().toString().split('.').first}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    _buildScoreBox(assessment),
                    const SizedBox(height: 20),
                    const Text(
                      'Word Assessment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(),
                    ...words.map(_buildWordItem),
                    const SizedBox(height: 20),
                    if (assessment.geminiFeedback?.isNotEmpty ?? false)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Gemini Feedback',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          _buildGeminiFeedbackBox(
                            context,
                            assessment.geminiFeedback!,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          } else if (state is ReviewAnswerError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('No assessment found'));
          }
        },
      ),
    );
  }

  Widget _buildScoreBox(AudioAssessment a) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _scoreCard('Pronunciation', a.pronunciationScore),
        _scoreCard('Accuracy', a.accuracyScore),
        _scoreCard('Fluency', a.fluencyScore),
        _scoreCard('Completeness', a.completenessScore),
      ],
    );
  }

  Widget _scoreCard(String label, int? score) {
    Color color =
        score == null
            ? AppColors.hare
            : score >= 90
            ? AppColors.featherGreen
            : score >= 70
            ? AppColors.beakLower
            : AppColors.cardinal;

    return IntrinsicHeight(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            score?.toString() ?? '--',
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWordItem(AudioWord word) {
    final Color wordColor = switch (word.accuracyScore) {
      null => AppColors.cardinal,
      > 85 => AppColors.featherGreen,
      > 70 => AppColors.beetle,
      > 50 => AppColors.cardinal,
      _ => AppColors.cardinal,
    };
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.snow.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: wordColor.withAlpha(200),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.word ?? '--',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text('Score: ${word.accuracyScore}'),
              const SizedBox(width: 12),
              if (word.errorType != null && word.errorType != "None")
                Text(
                  '❌ Error: ${word.errorType}',
                  style: const TextStyle(color: Colors.red),
                ),
            ],
          ),
          const SizedBox(height: 6),
          if (word.audioPhonemes?.isNotEmpty ?? false)
            Wrap(
              spacing: 8,
              children:
                  word.audioPhonemes!.map((p) {
                    return Chip(
                      label: Text('${p.phoneme} (${p.accuracyScore})'),
                      backgroundColor:
                          (p.accuracyScore ?? 0) >= 80
                              ? Colors.green[100]
                              : Colors.red[100],
                    );
                  }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildGeminiFeedbackBox(BuildContext context, String feedback) {
    return ExpansionTile(
      initiallyExpanded: false,
      title: const Text('View Detailed Feedback'),
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: _buildHtml(context, feedback),
        ),
      ],
    );
  }

  Widget _buildHtml(BuildContext context, String markdownContent) {
    final htmlContent = md.markdownToHtml(markdownContent);
    return Html(
      data: """
        ${htmlContent}
        """,
      extensions: [
        TagExtension(tagsToExtend: {"flutter"}, child: const FlutterLogo()),
      ],
      style: {
        "p.fancy": Style(
          textAlign: TextAlign.center,
          backgroundColor: Colors.grey,
          margin: Margins(left: Margin(50, Unit.px), right: Margin.auto()),
          width: Width(300, Unit.px),
          fontWeight: FontWeight.bold,
        ),
      },
    );
  }
}
