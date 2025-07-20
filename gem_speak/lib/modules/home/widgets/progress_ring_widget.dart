import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vm;

class ProgressRingWidget extends StatelessWidget {
  final double progress;
  final double strokeWidth;
  final double height;
  const ProgressRingWidget({
    super.key,
    required this.progress,
    this.strokeWidth = 0.03,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
      child: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox.expand(
                child: CustomPaint(
                  painter: RingPainter(
                    strokeWidth: constraints.maxWidth * strokeWidth,
                    progress: progress / 100,
                  ),
                ),
              );
            },
          ),
          Center(
            child: Text(
              '${(progress).toStringAsFixed(1)}%',
              style: TextStyle(
                fontSize: height * 0.15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RingPainter extends CustomPainter {
  final double strokeWidth;
  final double progress;

  RingPainter({required this.strokeWidth, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final inset = size.width * 0.18;

    final rect = Rect.fromLTRB(
      inset,
      inset,
      size.width - inset,
      size.height - inset,
    );

    canvas.drawArc(
      rect,
      vm.radians(-90),
      vm.radians(360 * progress),
      false,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFf1da95), Color(0xFFfe948a), Color(0xFFb24fce)],
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(RingPainter oldDelegate) {
    if (oldDelegate.progress != progress ||
        oldDelegate.strokeWidth != strokeWidth) {
      return true;
    }
    return false;
  }
}
