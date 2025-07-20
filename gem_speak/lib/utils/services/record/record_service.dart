import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart' as path;
import 'package:record/record.dart';

class RecordService {
  RecordService._();
  static final RecordService _instance = RecordService._();
  factory RecordService() => _instance;

  final AudioRecorder _recorder = AudioRecorder();

  Stream<Uint8List>? _stream;
  StreamSubscription<Uint8List>? _streamSub;

  final StreamController<double> _volumeController =
      StreamController.broadcast();
  Stream<double> get volumeStream => _volumeController.stream;

  String? _currentFilePath;
  bool _isRecordingToStream = false;

  Future<void> startRecordingToFile() async {
    if (await _recorder.hasPermission()) {
      final dir = await path.getTemporaryDirectory();
      final filePath =
          '${dir.path}/my_recording_${DateTime.now().millisecondsSinceEpoch}.wav';

      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 48000,
          numChannels: 1,
        ),
        path: filePath,
      );

      _isRecordingToStream = false;
      _currentFilePath = filePath;
    }
  }

  Future<void> startRecordingToStream() async {
    if (await _recorder.hasPermission()) {
      _stream = await _recorder.startStream(
        const RecordConfig(encoder: AudioEncoder.pcm16bits, sampleRate: 44100),
      );

      _isRecordingToStream = true;

      _streamSub = _stream?.listen((buffer) {
        final amplitude = _calculateAmplitude(buffer);
        _volumeController.add(amplitude);
      });
    }
  }

  Future<String?> stopRecording() async {
    await _streamSub?.cancel();
    await _recorder.stop();

    if (_isRecordingToStream) return null;
    return _currentFilePath;
  }

  Future<void> cancelRecording() async {
    await _streamSub?.cancel();
    await _recorder.cancel();
    _currentFilePath = null;
  }

  Future<void> dispose() async {
    await _streamSub?.cancel();
    await _volumeController.close();
    await _recorder.dispose();
  }

  Future<bool> isRecording() => _recorder.isRecording();

  double _calculateAmplitude(Uint8List buffer) {
    final intList = Int16List.view(buffer.buffer);
    int maxAmp = 0;
    for (var sample in intList) {
      maxAmp = max(maxAmp, sample.abs());
    }
    return maxAmp / 32768.0;
  }
}
