import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';

class CommonButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? fontSize;
  final Color? textColor;
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.borderRadius,
    this.padding,
    this.fontSize,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.snow,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize ?? 16,
          color: textColor ?? AppColors.textColor,
        ),
      ),
    );
  }
}
