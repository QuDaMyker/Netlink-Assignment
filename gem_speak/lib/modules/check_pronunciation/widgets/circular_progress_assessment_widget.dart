import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';

class CircularProgressAssessmentWidget extends StatelessWidget {
  final String title;
  final double? value;
  const CircularProgressAssessmentWidget({
    super.key,
    required this.title,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    Color? valueColor;
    if (value == null) {
      valueColor = null;
    } else if (value! < 0.5) {
      valueColor = AppColors.cardinal;
    } else if (value! < 0.8) {
      valueColor = AppColors.bee;
    } else {
      valueColor = AppColors.featherGreen;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 60,
              width: 60,
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(
                  valueColor ?? Theme.of(context).colorScheme.primary,
                ),
                strokeCap: StrokeCap.round,
                value: value,
              ),
            ),
            Positioned.fill(
              child: SizedBox(
                height: 50,
                width: 50,
                child: Center(
                  child: Text(
                    '${(value ?? 0) * 100}%',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
