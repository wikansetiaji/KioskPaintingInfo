import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class PointOfInterestView extends StatefulWidget {
  const PointOfInterestView({
    super.key,
    required this.width,
    required this.pointOfInterest,
    required this.height,
    required this.onTap,
  });

  final double width;
  final PointOfInterest pointOfInterest;
  final double height;
  final VoidCallback onTap;

  @override
  State<PointOfInterestView> createState() => _PointOfInterestViewState();
}

class _PointOfInterestViewState extends State<PointOfInterestView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.width * widget.pointOfInterest.x - 30.sc,
      top: widget.height * widget.pointOfInterest.y - 30.sc,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 40.sc,
                    height: 40.sc,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(80),
                    ),
                  ),
                ),
                CircleAvatar(radius: 10.sc, backgroundColor: Colors.white),
              ],
            );
          },
        ),
      ),
    );
  }
}