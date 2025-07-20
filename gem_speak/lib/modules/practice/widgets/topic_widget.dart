import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/widgets/common_button.dart';
import 'package:tool_core/models/topic.dart';

final _random = Random();

class TopicWidget extends StatelessWidget {
  final Topic topic;
  final Function() onTap;
  const TopicWidget({super.key, required this.topic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color =
        AppColors.topicColors[_random.nextInt(AppColors.topicColors.length)];
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      splashColor: color.withValues(alpha: 0.3),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border(
            bottom: BorderSide(
              color: color,
              width: 4,
              strokeAlign: BorderSide.strokeAlignInside,
              style: BorderStyle.solid,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.maskGreen.withValues(alpha: .3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              topic.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.polar,
              ),
            ),
            SizedBox(height: 4),
            Text(
              topic.description,
              style: TextStyle(fontSize: 14, color: AppColors.polar),
            ),
            Row(
              children: [
                Text(
                  '${topic.questions?.length ?? 0} Questions',
                  style: TextStyle(fontSize: 14, color: AppColors.polar),
                ),
                Spacer(),
                CommonButton(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  fontSize: 12,
                  onPressed: onTap,
                  text: 'Practice Now',
                  borderRadius: BorderRadius.circular(100),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
