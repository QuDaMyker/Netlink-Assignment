import 'dart:async';

import 'package:tool_core/error/app_error.dart';

typedef AppCallBack<Q, R> = FutureOr<R> Function(Q message);
typedef TbCompute =
    Future<R> Function<Q, R>(AppCallBack<Q, R> callback, Q message);

typedef UserLoadedCallback = void Function();
typedef LoadStartedCallback = void Function();
typedef LoadFinishedCallback = void Function();
typedef MfaAuthCallback = void Function();
typedef ErrorCallback = void Function(AppError error);
