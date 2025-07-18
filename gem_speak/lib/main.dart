import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gem_speak/app_bloc_observer.dart';
import 'package:gem_speak/gem_speak_app.dart';
import 'package:gem_speak/locator.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await setUpRootDependencies();
  if (kDebugMode) {
    Bloc.observer = AppBlocObserver(getIt());
  }
  runApp(const GemSpeakApp());
}
