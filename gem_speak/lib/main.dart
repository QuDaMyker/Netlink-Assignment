import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/app_bloc_observer.dart';
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
  apiClient.updateBaseUrl('http://3.107.2.186:4040');
  await apiClient.get('/hello-world'); // Test the API connection
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver(getIt());
  }
  runApp(const GemSpeakApp());
}
