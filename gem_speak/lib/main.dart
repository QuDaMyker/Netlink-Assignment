import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/app_bloc_observer.dart';
import 'package:gem_speak/core/env/env.dart';
import 'package:gem_speak/gem_speak_app.dart';
import 'package:gem_speak/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tool_core/network/api_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setUpRootDependencies();
  final apiClient = getIt<ApiClient>();
  // Server testing EC2 instance
  // apiClient.updateBaseUrl('https://gemspeak.builtlab.io.vn');
  // await apiClient.get('/hello-world'); // Test the API connection
  apiClient.updateBaseUrl(Env.baseUrl);
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver(getIt());
  }
  runApp(const GemSpeakApp());
}
