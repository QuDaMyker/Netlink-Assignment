import 'package:flutter/material.dart';
import 'package:gem_speak/utils/services/record/record_service.dart';

class WaveformWidget extends StatefulWidget {
  const WaveformWidget({super.key});

  @override
  State<WaveformWidget> createState() => _WaveformWidgetState();
}

class _WaveformWidgetState extends State<WaveformWidget> {
  double _volume = 0.0;

  @override
  void initState() {
    super.initState();
    RecordService().volumeStream.listen((amp) {
      setState(() {
        _volume = amp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      alignment: Alignment.center,
      child: Container(
        width: _volume * 200,
        height: 20,
        color: Colors.blueAccent,
      ),
    );
  }
}
