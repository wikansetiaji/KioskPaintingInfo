import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class POINudgeView extends StatefulWidget {
  const POINudgeView({
    super.key,
    required this.selectedPoint,
    required this.height,
    required this.width,
  });

  final PointOfInterest? selectedPoint;
  final double width;
  final double height;

  @override
  State<POINudgeView> createState() => _POINudgeViewState();
}

class _POINudgeViewState extends State<POINudgeView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final point = widget.selectedPoint;
    if (point == null) return const SizedBox.shrink();

    return Positioned(
      left: widget.width * point.x - 60.sc,
      top: widget.height * point.y + 20.sc,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) {
          return Transform.scale(
            scale: _scale.value,
            child: child,
          );
        },
        child: Column(
          children: [
            CustomPaint(
              size: Size(20.sc, 10.sc),
              painter: TrianglePainter(color: const Color(0xBBFFFAF1)),
            ),
            Container(
              width: 100.sc,
              padding: EdgeInsets.symmetric(horizontal: 10.sc, vertical: 6.sc),
              decoration: BoxDecoration(
                color: const Color(0xBBFFFAF1),
                borderRadius: BorderRadius.circular(8.sc),
                border: Border.all(
                  color: const Color(0xFFFFFFFF),
                  width: 3.sc,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Open",
                    style: TextStyle(fontSize: 16.sc, color: const Color(0xFF212121)),
                  ),
                  SizedBox(width: 4.sc),
                  Icon(
                    Icons.touch_app_outlined,
                    color: const Color(0xFF212121),
                    size: 20.sc,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path =
        Path()
          ..moveTo(0, size.height)
          ..lineTo(size.width / 2, 0)
          ..lineTo(size.width, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
