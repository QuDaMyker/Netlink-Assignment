import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_assets.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:tool_core/models/summary_learning.dart';

class SummaryCardWidget extends StatelessWidget {
  final SummaryLearning? summary;

  const SummaryCardWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    final totalLessons = summary?.totalAnswers ?? 0;
    final accuracy =
        summary?.averageScore?.accuracyScore?.toStringAsFixed(1) ?? 'N/A';
    final pronunciation =
        summary?.averageScore?.pronunciationScore?.toStringAsFixed(1) ?? 'N/A';
    final fluency =
        summary?.averageScore?.fluencyScore?.toStringAsFixed(1) ?? 'N/A';
    final completenessScore =
        summary?.averageScore?.completenessScore?.toStringAsFixed(1) ?? 'N/A';

    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.snow.withAlpha(200),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: AppColors.macaw, width: 1),
          bottom: BorderSide(color: AppColors.macaw, width: 6),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.macaw.withAlpha(200),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Summary",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.humpback,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Total Questions: $totalLessons",
                    style: TextStyle(color: AppColors.humpback.withAlpha(200)),
                  ),
                  Text(
                    "Average Accuracy: $accuracy%",
                    style: TextStyle(color: AppColors.humpback.withAlpha(200)),
                  ),
                  Text(
                    "Average Pronunciation: $pronunciation",
                    style: TextStyle(color: AppColors.humpback.withAlpha(200)),
                  ),
                  Text(
                    "Average Fluency: $fluency",
                    style: TextStyle(color: AppColors.humpback.withAlpha(200)),
                  ),
                  Text(
                    "Average Completeness: $completenessScore",
                    style: TextStyle(color: AppColors.humpback.withAlpha(200)),
                  ),
                ],
              ),
            ),
            Lottie.asset(
              AppAssets.owlBirdLearning,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
