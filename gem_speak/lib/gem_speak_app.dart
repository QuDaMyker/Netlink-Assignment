import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/common/constant/app_constants.dart';
import 'package:gem_speak/config/routers/app_router.dart';
import 'package:gem_speak/config/themes/app_theme.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:go_router/go_router.dart';

class GemSpeakApp extends StatefulWidget {
  const GemSpeakApp({super.key});

  @override
  State<GemSpeakApp> createState() => _GemSpeakAppState();
}

class _GemSpeakAppState extends State<GemSpeakApp> {
  late final authBloc = getIt<AuthBloc>();
  late final BlocNotifier<AuthBloc, AuthState> authBlocNotifier;
  late final GoRouter router;

  @override
  void initState() {
    super.initState();
    authBlocNotifier = BlocNotifier<AuthBloc, AuthState>(authBloc);
    router = AppRouter.createRouter(authBloc, authBlocNotifier);
  }

  @override
  void dispose() {
    authBlocNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthBloc>(),
      child: MaterialApp.router(
        routerConfig: router,
        themeMode: ThemeMode.light,
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: appTheme,
      ),
    );
  }
}
