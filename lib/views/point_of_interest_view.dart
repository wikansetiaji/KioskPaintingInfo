import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/repository/painting_repository.dart';
import 'package:kiosk_painting_info/services/event_bus.dart';
import 'package:kiosk_painting_info/services/size_config.dart';

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
  late StreamSubscription _subscription;
  bool _dimmed = false;

  @override
  void initState() {
    super.initState();

    _subscription = EventBus.stream.listen((event) {
      setState(() {
        _dimmed = !event.contains(widget.pointOfInterest.id) && event.isNotEmpty;
      });
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.width * widget.pointOfInterest.x - 100.sc,
      top: widget.height * widget.pointOfInterest.y - 100.sc,
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
                    width: 100.sc,
                    height: 100.sc,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withAlpha(_dimmed ? 55 : 120),
                    ),
                  ),
                ),
                CircleAvatar(radius: 25.sc, backgroundColor: Colors.white.withAlpha(_dimmed ? 50 : 255)),
              ],
            );
          },
        ),
      ),
    );
  }
}
