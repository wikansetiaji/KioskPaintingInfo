import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/repository/painting_repository.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/triangle_direction_view.dart';
import 'package:provider/provider.dart';

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

class _POINudgeViewState extends State<POINudgeView>
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
    final point = widget.selectedPoint;
    if (point == null) return const SizedBox.shrink();

    return Positioned(
      left: widget.width * point.x - 170.sc,
      top: widget.height * point.y + 20.sc,
      child: AnimatedBuilder(
        animation: _scale,
        builder: (_, child) {
          return Transform.scale(scale: _scale.value, child: child);
        },
        child: Column(
          children: [
            CustomPaint(
              size: Size(35.5.sc, 14.sc),
              painter: TrianglePainter(color: const Color(0xBBFFFAF1)),
            ),
            Container(
              width: 243.sc,
              padding: EdgeInsets.symmetric(horizontal: 20.sc, vertical: 10.sc),
              decoration: BoxDecoration(
                color: const Color(0xBBFFFAF1),
                borderRadius: BorderRadius.circular(12.sc),
                border: Border.all(color: const Color(0xFFFFFFFF), width: 4.sc),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context.watch<LanguageProvider>().isEnglish
                        ? "Open"
                        : "Buka",
                    style: TextStyle(
                      fontSize: 40.sc,
                      color: const Color(0xFF212121),
                      fontFamily: "Inter",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(width: 20.sc),
                  Image.asset(
                    "assets/icons/icon-hand-click.png",
                    width: 40.sc,
                    height: 40.sc,
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
