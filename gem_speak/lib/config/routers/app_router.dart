import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/modules/login/login_page.dart';
import 'package:gem_speak/modules/not_found/not_found_page.dart';
import 'package:gem_speak/modules/root/root_page.dart';
import 'package:gem_speak/modules/splash/view/splash_page.dart';
import 'package:go_router/go_router.dart';

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
  static GoRouter createRouter(AuthBloc authBloc) {
    return GoRouter(
      initialLocation: _RoutePaths.splash,
      routes: _routes(),
      errorPageBuilder: (context, state) => MaterialPage(child: NotFoundPage()),
      refreshListenable: BlocNotifier<AuthBloc, AuthState>(authBloc),
      redirect: (context, state) {
        final authState = authBloc.state;
        if (authState is AuthAuthenticated) {
          return _RoutePaths.root;
        }

        if (authState is AuthUnauthenticated) {
          return _RoutePaths.login;
        }

        return null;
      },
    );
  }

  static List<RouteBase> _routes() {
    return [
      GoRoute(
        path: _RoutePaths.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: _RoutePaths.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: _RoutePaths.root,
        builder: (context, state) => const RootPage(),
      ),
    ];
  }
}

class _RoutePaths {
  static const String splash = '/';
  static const String login = '/login';
  static const String root = '/root';
}
