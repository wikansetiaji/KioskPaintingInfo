import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/repository/painting_repository.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/bottom_button_view.dart';
import 'package:kiosk_painting_info/views/details_card_view.dart';
import 'package:kiosk_painting_info/views/fun_facts_view.dart';
import 'package:kiosk_painting_info/views/poi_nudge_view.dart';
import 'package:kiosk_painting_info/views/point_of_interest_view.dart';
import 'package:kiosk_painting_info/services/event_bus.dart';
import 'package:provider/provider.dart';

class PaintingView extends StatefulWidget {
  const PaintingView({
    super.key,
    required this.name,
    required this.pointOfInterests,
    required this.imageAsset,
    required this.uiOnRight,
    required this.funFacts,
    required this.onSelectPainting,
  });

  final TranslatedString name;
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
  late StreamSubscription _subscription;
  bool _isNudgeShown = true;
  Timer? _nudgeTimer;

  @override
  void initState() {
    super.initState();

    _subscription = EventBus.stream.listen((event) {
      setState(() {
        if (_nudgeTimer?.isActive ?? false) {
          _nudgeTimer!.cancel();
        }

        if (event != "") {
          _isNudgeShown = false;
        } else {
          _nudgeTimer = Timer(Duration(seconds: 30), () {
            if (mounted) {
              setState(() {
                _isNudgeShown = true;
              });
            }
          });
        }

        if (event == "") {
          _togglePointDetails(null);
          return;
        } else if (event.contains(_selectedPoint?.id ?? "***")) {
          return;
        }
        _togglePointDetails(
          widget.pointOfInterests.firstWhere((point) => event.contains(point.id)),
        );
      });
    });

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
    _subscription.cancel();
    _nudgeTimer?.cancel();
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
              onTap: () {
                _togglePointDetails(null);
                EventBus.send("");
              },
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                color: Colors.black,
                child: Image.asset(
                  widget.imageAsset,
                  fit: BoxFit.cover,
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
                onTap: () {
                  if (_selectedPoint?.id == pointOfInterest.id) {
                    _togglePointDetails(null);
                    EventBus.send("");
                    return;
                  }
                  _togglePointDetails(pointOfInterest);
                  EventBus.send("${pointOfInterest.id}/${widget.uiOnRight ? "right" : "left"}");
                },
              ),

            for (var pointOfInterest in widget.pointOfInterests)
              if (pointOfInterest.showNudge && _isNudgeShown)
                POINudgeView(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  selectedPoint: pointOfInterest,
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
                    onClose: () {
                      _togglePointDetails(null);
                      EventBus.send("");
                    },
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
                        firstChild: SizedBox(height: 0, width: 892.sc),
                        secondChild: FunFactsView(
                          name: widget.name.text(context),
                          funFacts: widget.funFacts,
                        ),
                      ),
                      Row(
                        spacing: 60.sc,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _togglePointDetails(null);
                              EventBus.send("");
                              widget.onSelectPainting(widget.imageAsset);
                            },
                            child: BottomButtonView(
                              text: context.watch<LanguageProvider>().isEnglish ? "See Full Painting" : "Lihat Lukisan Penuh",
                              icon: "assets/icons/icon-maximize.png",
                              isOtherOpened: _isFunFactOpened,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _isFunFactOpened = !_isFunFactOpened;
                              });
                            },
                            child: BottomButtonView(
                              text: context.watch<LanguageProvider>().isEnglish ? "Read Fun Facts" : "Baca Fakta",
                              icon: "assets/icons/icon-book.png",
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
