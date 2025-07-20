import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/modules/home/widgets/progress_ring_widget.dart';

class SummaryItemWidget extends StatelessWidget {
  final double progress;
  final String title;
  final double height;
  final Color backgroundColor;
  const SummaryItemWidget({
    super.key,
    required this.progress,
    required this.title,
    required this.height,
    this.backgroundColor = AppColors.snow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.snow.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(
            color: backgroundColor,
            width: 2,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
          bottom: BorderSide(
            color: backgroundColor,
            width: 6,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),

        boxShadow: [
          BoxShadow(
            color: backgroundColor.withValues(alpha: 0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProgressRingWidget(progress: progress, height: height * 0.5),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
