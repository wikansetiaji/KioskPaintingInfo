import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/triangle_direction_view.dart';

class SliderNudgeView extends StatefulWidget {
  const SliderNudgeView({
    super.key,
    required this.handleX,
    required this.isOnRight,
    required this.onClose,
  });

  final double handleX;
  final bool isOnRight;
  final VoidCallback onClose;

  @override
  State<SliderNudgeView> createState() => _SliderNudgeViewState();
}

class _SliderNudgeViewState extends State<SliderNudgeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 1.0,
      end: 1.08,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.isOnRight ? widget.handleX + 40.sc : widget.handleX - 190.sc,
      top: 0.5 * MediaQuery.of(context).size.height - 30.sc,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: Row(
          children: [
            if (widget.isOnRight)
              CustomPaint(
                size: Size(10.sc, 20.sc),
                painter: TrianglePainter(
                  color: const Color(0xBBFFFAF1),
                  direction: TriangleDirection.left,
                ),
              ),
            Container(
              width: 140.sc,
              padding: EdgeInsets.symmetric(horizontal: 10.sc, vertical: 6.sc),
              decoration: BoxDecoration(
                color: const Color(0xBBFFFAF1),
                borderRadius: BorderRadius.circular(8.sc),
                border: Border.all(color: const Color(0xFFFFFFFF), width: 3.sc),
              ),
              child: Row(
                spacing: 10.sc,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => widget.onClose(),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFF212121),
                      size: 20.sc,
                    ),
                  ),
                  Text(
                    "Slide to see \ncomparison",
                    style: TextStyle(
                      fontSize: 14.sc,
                      color: const Color(0xFF212121),
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.isOnRight)
              CustomPaint(
                size: Size(10.sc, 20.sc),
                painter: TrianglePainter(
                  color: const Color(0xBBFFFAF1),
                  direction: TriangleDirection.right,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
