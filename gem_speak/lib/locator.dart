import 'package:gem_speak/core/auth/bloc/auth_bloc.dart';
import 'package:gem_speak/core/logger/app_logger.dart';
import 'package:gem_speak/utils/services/user/_app_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:tool_core/repositories/all.dart';
import 'package:tool_core/storage/app_storage.dart';

final getIt = GetIt.instance;

Future<void> setUpRootDependencies() async {
  final secureStorage = createAppStorage() as AppSecureStorage;
  await secureStorage.init();
  getIt
    ..registerLazySingleton(() => AppLogger())
    ..registerLazySingleton<AppStorage>(() => secureStorage)
    ..registerLazySingleton<IAuthRepository>(() => AuthRepository())
    ..registerLazySingleton<AuthBloc>(() => AuthBloc(getIt<IAuthRepository>()));
}
