import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/bottom_button_view.dart';
import 'package:kiosk_painting_info/views/details_card_view.dart';
import 'package:kiosk_painting_info/views/fun_facts_view.dart';
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

class FunFact {
  final String title;
  final String description;

  FunFact({required this.title, required this.description});
}

class PaintingView extends StatefulWidget {
  const PaintingView({
    super.key,
    required this.text,
    required this.pointOfInterests,
    required this.imageAsset,
    required this.uiOnRight,
    required this.funFacts,
    required this.onSelectPainting
  });

  final String text;
  final List<PointOfInterest> pointOfInterests;
  final String imageAsset;
  final bool uiOnRight;
  final List<FunFact> funFacts;
  final Function(String) onSelectPainting;

  @override
  State<PaintingView> createState() => _PaintingViewState();
}

class _PaintingViewState extends State<PaintingView>
    with TickerProviderStateMixin {
  PointOfInterest? _selectedPoint;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isFunFactOpened = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePointDetails(PointOfInterest? point) {
    setState(() {
      _isFunFactOpened = false;
    });

    if (point == null) {
      if (_selectedPoint != null) {
        _animationController.reverse().then((_) {
          setState(() {
            _selectedPoint = null;
          });
        });
      }
      return;
    } else if (_selectedPoint == point) {
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
        return Stack(
          children: [
            GestureDetector(
              onTap: () => _togglePointDetails(null),
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.black,
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.fitWidth,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
              ),
            ),

            // Points of interest
            for (var pointOfInterest in widget.pointOfInterests)
              PointOfInterestView(
                width: constraints.maxWidth,
                pointOfInterest: pointOfInterest,
                height: constraints.maxHeight,
                onTap: () => _togglePointDetails(pointOfInterest),
              ),

            // Details card
            if (_selectedPoint != null)
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return DetailsCardView(
                    point: _selectedPoint!,
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    opacity: _fadeAnimation.value,
                    scale: _scaleAnimation.value,
                    onClose: () => _togglePointDetails(null),
                  );
                },
              ),
            Row(
              children: [
                if (widget.uiOnRight) Spacer(),
                Container(
                  padding: EdgeInsets.all(40.sc),
                  child: Column(
                    crossAxisAlignment:
                        widget.uiOnRight
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                    spacing: 20.sc,
                    children: [
                      Spacer(),
                      AnimatedCrossFade(
                        duration: Duration(milliseconds: 250),
                        crossFadeState:
                            _isFunFactOpened
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                        firstChild: SizedBox(height: 0, width: 500.sc),
                        secondChild: FunFactsView(
                          name: widget.text,
                          funFacts: widget.funFacts,
                        ),
                      ),
                      Row(
                        spacing: 20.sc,
                        children: [
                          GestureDetector(
                            onTap: () { 
                              setState(() {
                                _togglePointDetails(null);
                              });
                              widget.onSelectPainting(widget.imageAsset);
                            },
                            child: BottomButtonView(
                              text: "See Full Painting",
                              icon: Icons.home_max,
                              isOtherOpened: _isFunFactOpened,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (!_isFunFactOpened) {
                                  _togglePointDetails(null);
                                }
                                _isFunFactOpened = !_isFunFactOpened;
                              });
                            },
                            child: BottomButtonView(
                              text: "Read Fun Facts",
                              icon: Icons.info_outline,
                              isOtherOpened: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (!widget.uiOnRight) Spacer(),
              ],
            ),
          ],
        );
      },
    );
  }
}
