import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/locator.dart';
import 'package:gem_speak/modules/check_pronunciation/check_pronunciation_page.dart';
import 'package:gem_speak/modules/check_pronunciation/cubit/check_prounciation_cubit.dart';
import 'package:gem_speak/modules/login/login_page.dart';
import 'package:gem_speak/modules/not_found/not_found_page.dart';
import 'package:gem_speak/modules/review_answer/cubit/review_answer_cubit.dart';
import 'package:gem_speak/modules/review_answer/review_answer_page.dart';
import 'package:gem_speak/modules/root/root_page.dart';
import 'package:gem_speak/modules/splash/view/splash_page.dart';
import 'package:go_router/go_router.dart';
import 'package:tool_core/models/topic.dart';
import 'package:tool_core/models/user_answers.dart';
import 'package:tool_core/repositories/i_user_repository.dart';

class BlocNotifier<B extends StateStreamable<S>, S> extends ChangeNotifier {
  late final B _bloc;
  late final StreamSubscription<S> _subscription;

  BlocNotifier(B bloc) : _bloc = bloc {
    _subscription = _bloc.stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRouter {
  static GoRouter createRouter(
    AuthBloc authBloc,
    BlocNotifier<AuthBloc, AuthState> authBlocNotifier,
  ) {
    return GoRouter(
      initialLocation: RoutePaths.splash,
      routes: _routes(),
      errorPageBuilder: (context, state) => MaterialPage(child: NotFoundPage()),
      refreshListenable: authBlocNotifier,
      redirect: (context, state) {
        final isLoggedIn = authBloc.state is AuthAuthenticated;
        final isSplash = state.uri.path == RoutePaths.splash;
        final isLogin = authBloc.state is AuthUnauthenticated;

        if (isLogin) {
          return RoutePaths.login;
        }

        if (isLoggedIn && (state.uri.path == RoutePaths.login || isSplash)) {
          return RoutePaths.root;
        }

        return null;
      },
    );
  }

  static List<RouteBase> _routes() {
    return [
      GoRoute(
        path: RoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RoutePaths.root,
        builder: (context, state) => const RootPage(),
      ),
      GoRoute(
        path: RoutePaths.checkPronunciation,
        builder: (context, state) {
          final userRepository = getIt<IUserRepository>();
          final topic = state.extra;
          if (topic is! Topic) return const NotFoundPage();
          return BlocProvider(
            create:
                (_) => CheckProunciationCubit(
                  topic: topic,
                  userRepository: userRepository,
                ),
            child: CheckPronunciationPage(),
          );
        },
      ),
      GoRoute(
        path: RoutePaths.reviewAnswer,
        builder: (context, state) {
          final userRepository = getIt<IUserRepository>();
          final userAnswers = state.extra;
          if (userAnswers is! UserAnswers) return const NotFoundPage();

          final reviewAnswerCubit = ReviewAnswerCubit(userRepository)
            ..fetchAudioAssessment(userAnswers.assessments?.first.id ?? '');
          print('Extra nhận được: $userAnswers');
          print(
            'Reviewing answer for assessment: ${userAnswers.assessments?.first.id}',
          );
          return BlocProvider(
            create: (_) => reviewAnswerCubit,
            child: ReviewAnswerPage(),
          );
        },
      ),
    ];
  }
}

class RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String root = '/root';
  static const String checkPronunciation = '/check-pronunciation';
  static const String reviewAnswer = '/review-answer';
}
