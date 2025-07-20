import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  TtsService._();

  static final TtsService _instance = TtsService._();

  factory TtsService() {
    return _instance;
  }

  final flutterTts = FlutterTts();

  void speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.speak(text);
  }
}
