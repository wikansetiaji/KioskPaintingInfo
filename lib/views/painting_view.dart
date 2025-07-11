import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/details_card_view.dart';
import 'package:kiosk_painting_info/views/point_of_interest_view.dart';

class PointOfInterest {
  final String name;
  final String description;
  final double x;
  final double y;
  
  PointOfInterest({
    required this.name,
    required this.description,
    required this.x,
    required this.y,
  });
}

class PaintingView extends StatefulWidget {
  const PaintingView({
    super.key,
    required this.background,
    required this.text,
    required this.pointOfInterests,
  });

  final MaterialColor background;
  final String text;
  final List<PointOfInterest> pointOfInterests;

  @override
  State<PaintingView> createState() => _PaintingViewState();
}

class _PaintingViewState extends State<PaintingView> with TickerProviderStateMixin {
  PointOfInterest? _selectedPoint;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePointDetails(PointOfInterest point) {
    if (_selectedPoint == point) {
      _animationController.reverse().then((_) {
        setState(() {
          _selectedPoint = null;
        });
      });
    } else if (_selectedPoint == null) {
      setState(() {
        _selectedPoint = point;
      });
      _animationController.forward();
    } else {
      _animationController.reverse().then((_) {
        setState(() {
          _selectedPoint = point;
        });
        _animationController.forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        
        return Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: widget.background,
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 32.sc,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            for (var pointOfInterest in widget.pointOfInterests)
              PointOfInterestView(
                width: width,
                pointOfInterest: pointOfInterest,
                height: height,
                onTap: () => _togglePointDetails(pointOfInterest),
              ),
            if (_selectedPoint != null)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return DetailsCardView(point: _selectedPoint!, width: width, height: height, opacity: _fadeAnimation.value, scale: _scaleAnimation.value);
                },
              ),
          ],
        );
      },
    );
  }
}
