import 'package:flutter/material.dart';
import 'package:gem_speak/common/constant/app_colors.dart';
import 'package:gem_speak/common/constant/app_constants.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<AuthBloc>().add(AppStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppConstants.appName,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: AppColors.featherGreen,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.cardinal,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
