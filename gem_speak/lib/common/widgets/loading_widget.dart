import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_assets.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final double? size;
  final Color? backgroundColor;
  const LoadingWidget({super.key, this.size = 160, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.maskGreen.withValues(alpha: .5),
      child: Center(
        child: ClipOval(
          child: Container(
            width: size,
            height: size,
            color: AppColors.snow,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  AppAssets.owlBirdLoading,
                  width: size! / 2,
                  height: size! / 2,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 5),
                LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.cardinal,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
