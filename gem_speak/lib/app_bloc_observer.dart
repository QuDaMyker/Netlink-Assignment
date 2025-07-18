
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/core/logger/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver(this.logger);

  final AppLogger logger;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    logger.info('AppBlocObserver::onCreate(${bloc.runtimeType})');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    logger.info('AppBlocObserver::onEvent(${bloc.runtimeType}, $event)');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    logger.error(
      'AppBlocObserver::onError(${bloc.runtimeType}, $error, $stackTrace)',
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    logger.info('AppBlocObserver::onClose(${bloc.runtimeType})');
  }
}
