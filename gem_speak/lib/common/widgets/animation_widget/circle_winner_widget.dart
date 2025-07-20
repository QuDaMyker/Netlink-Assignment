import 'package:flutter/material.dart';

class CircleWinnerWidget extends StatefulWidget {
  const CircleWinnerWidget({
    super.key,
    required this.colors,
    required this.size,
    required this.thinness,
    required this.child,
  });

  final List<Color> colors;
  final double size;
  final double thinness;
  final Widget child;
  @override
  State<CircleWinnerWidget> createState() => _CircleWinnerWidgetState();
}

class _CircleWinnerWidgetState extends State<CircleWinnerWidget>
    with TickerProviderStateMixin {
  late final AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: animationController.value * 6.3,
                child: child,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: widget.colors,
                  stops: const [0.2, 1],
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: widget.colors.first.withValues(alpha: 0.1),
                  width: widget.thinness,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.colors.first.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.all(widget.thinness),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );
  }
}
