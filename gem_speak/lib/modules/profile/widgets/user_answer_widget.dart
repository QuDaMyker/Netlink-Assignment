import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/utils/extension/datetime_utils.dart';
import 'package:tool_core/models/user_answers.dart';

class UserAnswerWidget extends StatelessWidget {
  final UserAnswers userAnswer;
  final VoidCallback? onTap;
  const UserAnswerWidget({super.key, required this.userAnswer, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    final color =
        AppColors.topicColors[_random.nextInt(AppColors.topicColors.length)];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.snow.withAlpha(220),
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(color: color, width: 2),
              bottom: BorderSide(color: color, width: 5),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withAlpha(100),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userAnswer.question?.questionText ?? 'No Transcript',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _buildResultIcon(),
                  const SizedBox(width: 8),
                  Text(
                    resultLabel,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: resultColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Challenged at: ${userAnswer.createdAt?.ddMMyyyyHHmmss}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get resultLabel {
    final score = userAnswer.assessments?.firstOrNull?.completenessScore;
    if (score != null) {
      if (score > 0.8) return 'Correct';
      if (score < 0.5) return 'Incorrect';
      return 'Needs Review';
    }
    return 'Unknown';
  }

  Color get resultColor {
    switch (resultLabel) {
      case 'Correct':
        return Colors.green;
      case 'Incorrect':
        return Colors.red;
      case 'Needs Review':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Widget _buildResultIcon() {
    IconData icon;
    Color color = resultColor;

    switch (resultLabel) {
      case 'Correct':
        icon = Icons.check_circle;
        break;
      case 'Incorrect':
        icon = Icons.cancel;
        break;
      case 'Needs Review':
        icon = Icons.help_outline;
        break;
      default:
        icon = Icons.info_outline;
    }

    return Icon(icon, color: color, size: 20);
  }
}
