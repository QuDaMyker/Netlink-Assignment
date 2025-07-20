import 'package:flutter/material.dart';

class NeumorphicProgressBarWidget extends StatefulWidget {
  final double progress;
  final Color shadowColor;
  final Color backgroundColor;
  final Color highlightColor;
  const NeumorphicProgressBarWidget({
    super.key,
    required this.progress,
    required this.shadowColor,
    required this.backgroundColor,
    required this.highlightColor,
  });

  @override
  State<NeumorphicProgressBarWidget> createState() =>
      _NeumorphicProgressBarWidgetState();
}

class _NeumorphicProgressBarWidgetState
    extends State<NeumorphicProgressBarWidget> {
  final bevel = 10.0;
  final blurOffset = const Offset(20.0 / 2, 20.0 / 2);
  late final shadowColor = widget.shadowColor;
  late final backgroundColor = widget.backgroundColor;
  late final highlightColor = widget.highlightColor;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          NeumorphicCircle(
            shadowColor: shadowColor,
            backgroundColor: backgroundColor,
            highlightColor: highlightColor,
            innerShadow: true,
            outerShadow: false,
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth * 0.3,
                height: constraints.maxWidth * 0.3,
                child: NeumorphicCircle(
                  innerShadow: false,
                  outerShadow: true,
                  highlightColor: highlightColor,
                  shadowColor: shadowColor,
                  backgroundColor: backgroundColor,
                  child: SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          widget.progress.toStringAsFixed(1) * 100,
                          style: TextStyle(
                            color: Colors.white60,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class NeumorphicCircle extends StatelessWidget {
  final bool innerShadow;
  final bool outerShadow;
  final Color highlightColor;
  final Color shadowColor;
  final Color backgroundColor;
  final Widget? child;

  const NeumorphicCircle({
    super.key,
    required this.innerShadow,
    required this.outerShadow,
    required this.highlightColor,
    required this.shadowColor,
    required this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
            boxShadow:
                (outerShadow)
                    ? [
                      BoxShadow(
                        color: highlightColor,
                        offset: const Offset(-10, -10),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: shadowColor,
                        offset: const Offset(10, 10),
                        blurRadius: 20,
                        spreadRadius: 0,
                      ),
                    ]
                    : null,
          ),
        ),
        (innerShadow)
            ? ClipPath(
              clipper: HighlightClipper(),
              child: CircleInnerHighlight(
                highlightColor: highlightColor,
                backgroundColor: backgroundColor,
              ),
            )
            : const SizedBox.shrink(),
        (innerShadow)
            ? ClipPath(
              clipper: ShadowClipper(),
              child: CircleInnerShadow(
                shadowColor: shadowColor,
                backgroundColor: backgroundColor,
              ),
            )
            : const SizedBox.shrink(),
        (child != null) ? child! : const SizedBox.shrink(),
      ],
    );
  }
}

class CircleInnerShadow extends StatelessWidget {
  final Color shadowColor;
  final Color backgroundColor;

  const CircleInnerShadow({
    super.key,
    required this.shadowColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [backgroundColor, shadowColor],
          center: const AlignmentDirectional(0.05, 0.05),
          focal: const AlignmentDirectional(0, 0),
          radius: 0.5,
          focalRadius: 0,
          stops: const [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0, 0.45],
            colors: [backgroundColor.withValues(alpha: 0), backgroundColor],
          ),
        ),
      ),
    );
  }
}

class CircleInnerHighlight extends StatelessWidget {
  final Color highlightColor;
  final Color backgroundColor;

  const CircleInnerHighlight({
    super.key,
    required this.highlightColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [backgroundColor, highlightColor],
          center: const AlignmentDirectional(-0.05, -0.05),
          focal: const AlignmentDirectional(-0.05, -0.05),
          radius: 0.6,
          focalRadius: 0.1,
          stops: const [0.75, 1.0],
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.55, 1],
            colors: [backgroundColor, backgroundColor.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class ShadowClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }
}

class HighlightClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }
}
