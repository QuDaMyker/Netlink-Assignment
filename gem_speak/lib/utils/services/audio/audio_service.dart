import 'package:just_audio/just_audio.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() {
    return _instance;
  }
  AudioService._internal();

  final player = AudioPlayer();
  Duration? duration;

  Future<void> init(String filePath) async {
    duration = await player.setAudioSource(AudioSource.uri(Uri.file(filePath)));
  }

  Future<void> playAudio(String filePath) async {
    await init(filePath);
    await player.play();
  }

  void pauseAudio() {
    player.pause();
  }

  void stopAudio() {
    player.stop();
  }
}
