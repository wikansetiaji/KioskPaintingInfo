import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/triangle_direction_view.dart';
import 'package:provider/provider.dart';

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
      left: widget.isOnRight ? widget.handleX + 180.sc : widget.handleX - (context.watch<LanguageProvider>().isEnglish ? 460.sc : 560.sc),
      top: 0.5 * MediaQuery.of(context).size.height - 80.sc,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: Row(
          children: [
            if (widget.isOnRight)
              CustomPaint(
                size: Size(14.sc, 35.sc),
                painter: TrianglePainter(
                  color: const Color(0xBBFFFAF1),
                  direction: TriangleDirection.left,
                ),
              ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.sc, vertical: 12.sc),
              decoration: BoxDecoration(
                color: const Color(0xBBFFFAF1),
                borderRadius: BorderRadius.circular(12.sc),
                border: Border.all(color: const Color(0xFFFFFFFF), width: 4.sc),
              ),
              child: Row(
                spacing: 20.sc,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => widget.onClose(),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFF212121),
                      size: 48.sc,
                    ),
                  ),
                  Text(
                    context.watch<LanguageProvider>().isEnglish ? "Slide to see \ncomparison" : "Geser untuk lihat \nperbandingan",
                    style: TextStyle(
                      fontSize: 40.sc,
                      color: const Color(0xFF212121),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.normal
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.isOnRight)
              CustomPaint(
                size: Size(14.sc, 35.sc),
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
