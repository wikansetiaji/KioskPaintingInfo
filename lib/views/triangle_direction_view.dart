import 'package:flutter/material.dart';

enum TriangleDirection { up, down, left, right }

class TrianglePainter extends CustomPainter {
  final Color color;
  final TriangleDirection direction;

  TrianglePainter({
    required this.color,
    this.direction = TriangleDirection.up,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    switch (direction) {
      case TriangleDirection.up:
        path.moveTo(0, size.height);
        path.lineTo(size.width / 2, 0);
        path.lineTo(size.width, size.height);
        break;

      case TriangleDirection.down:
        path.moveTo(0, 0);
        path.lineTo(size.width / 2, size.height);
        path.lineTo(size.width, 0);
        break;

      case TriangleDirection.left:
        path.moveTo(size.width, 0);
        path.lineTo(0, size.height / 2);
        path.lineTo(size.width, size.height);
        break;

      case TriangleDirection.right:
        path.moveTo(0, 0);
        path.lineTo(size.width, size.height / 2);
        path.lineTo(0, size.height);
        break;
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant TrianglePainter oldDelegate) {
    return color != oldDelegate.color || direction != oldDelegate.direction;
  }
}
