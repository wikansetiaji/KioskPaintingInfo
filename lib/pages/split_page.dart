import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/repository/painting_repository.dart';
import 'package:kiosk_painting_info/services/idle_timer.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/views/language_toggle_switch_view.dart';
import 'package:kiosk_painting_info/views/slider_nudge_view.dart';
import 'package:kiosk_painting_info/services/event_bus.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<double> _slideAnimation;
  double _dragPosition = 0.5;
  bool _isAnimating = false;

  String? _selectedPainting;
  bool _showLeftSliderNudge = false;
  bool _showRightSliderNudge = false;
  late AnimationController _modalAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _modalAnimation;
  late Animation<double> _scaleAnimation;
  late StreamSubscription _subscription;
  bool _showCoverScreen = true;
  late IdleTimer _idleTimer;

  // Transform controller for zoom and pan
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    _idleTimer = IdleTimer(
      timeout: Duration(minutes: 10),
      onTimeout: _onIdleTimeout,
    );
    _idleTimer.reset();

    _subscription = EventBus.stream.listen((event) {
      String id = event.split("/").first;
      if (id.isNotEmpty && PaintingRepository().getPOIPairCenterX(id) != null) {
        final targetPosition = PaintingRepository().getPOIPairCenterX(id)!;
        _animateToPosition(targetPosition);
      }

      setState(() {
        if (id.isNotEmpty &&
            PaintingRepository().getPOIPairCenterX(id) != null) {
          return;
        }
        if (event.contains("left")) {
          _showLeftSliderNudge = true;
          _showRightSliderNudge = false;
        } else if (event.contains("right")) {
          _showRightSliderNudge = true;
          _showLeftSliderNudge = false;
        } else {
          _showLeftSliderNudge = false;
          _showRightSliderNudge = false;
        }
      });
    });

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<double>(
            begin: _dragPosition,
            end: _dragPosition,
          ).animate(_slideController)
          ..addListener(() {
            if (!_isAnimating) return;
            setState(() {
              _dragPosition = _slideAnimation.value;
            });
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed ||
                status == AnimationStatus.dismissed) {
              _isAnimating = false;
            }
          });

    // Modal fade animation
    _modalAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _modalAnimation = CurvedAnimation(
      parent: _modalAnimationController,
      curve: Curves.easeInOut,
    );

    // Scale animation for the painting
    _scaleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _scaleAnimationController,
      curve: Curves.elasticOut,
    );
  }

  void _animateToPosition(double targetPosition) {
    // Stop any ongoing animation
    _slideController.stop();

    // Update the animation with new values
    _slideAnimation = Tween<double>(
      begin: _dragPosition,
      end: targetPosition.clamp(0.0, 1.0),
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Reset the controller and start the animation
    _slideController.reset();
    _isAnimating = true;
    _slideController.forward();
  }

  void _onIdleTimeout() {
    setState(() {
      _showCoverScreen = true;
      _selectedPainting = null;
      _dragPosition = 0.5;
      EventBus.send("");
    });
  }

  void _onUserInteraction() {
    _idleTimer.reset();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _modalAnimationController.dispose();
    _scaleAnimationController.dispose();
    _transformationController.dispose();
    _subscription.cancel();
    _idleTimer.dispose();
    super.dispose();
  }

  void _showPainting(String? painting) {
    if (painting != null) {
      EventBus.send("");
      setState(() {
        _selectedPainting = painting;
      });
      _modalAnimationController.forward();
      _scaleAnimationController.forward();
      // Reset transform when showing new painting
      _transformationController.value = Matrix4.identity();
    }
  }

  void _hidePainting() {
    _modalAnimationController.reverse().then((_) {
      setState(() {
        _selectedPainting = null;
      });
      _scaleAnimationController.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final handleX = _dragPosition * screenWidth - 85.sc;

    return Listener(
      onPointerDown: (_) => _onUserInteraction(),
      behavior: HitTestBehavior.translucent,
      child: Scaffold(
        body: GestureDetector(
          onHorizontalDragUpdate: (details) {
            if (!_showCoverScreen) {
              if (_isAnimating) {
                _slideController.stop();
                _isAnimating = false;
              }
              setState(() {
                if (_showLeftSliderNudge) {
                  _showLeftSliderNudge = false;
                }
                if (_showRightSliderNudge) {
                  _showRightSliderNudge = false;
                }
                if (_selectedPainting != null) {
                  return;
                }

                bool reachedLeftEdge =
                    details.delta.dx < 0 && _dragPosition <= 0.05;
                bool reachedRightEdge =
                    details.delta.dx > 0 && _dragPosition >= 0.95;
                    
                if (reachedLeftEdge) {
                  _dragPosition = 0.05;
                } else if (reachedRightEdge) {
                  _dragPosition = 0.95;
                } else {
                  _dragPosition += details.delta.dx / screenWidth;
                }
                _dragPosition = _dragPosition.clamp(0.0, 1.0);
              });
            }
          },
          onTapDown: (details) {
            print(
              'Tapped at relative: (${details.localPosition.dx / MediaQuery.of(context).size.width},${details.localPosition.dy / MediaQuery.of(context).size.height})',
            );
          },
          child: Stack(
            children: [
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PaintingView(
                    imageAsset: 'assets/pieneman-painting.png',
                    name: TranslatedString(
                      strings: {
                        AppLanguage.en:
                            "THE ARREST OF DIPONEGORO BY LIEUTENANT GENERAL DE KOCK",
                        AppLanguage.id:
                            "THE ARREST OF DIPONEGORO BY LIEUTENANT GENERAL DE KOCK",
                      },
                    ),
                    uiOnRight: true,
                    pointOfInterests:
                        PaintingRepository().pienemanPointOfInterests,
                    funFacts: PaintingRepository().pienemanFunFacts,
                    onSelectPainting: _showPainting,
                  ),
                ),
              ),

              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: _dragPosition,
                  child: PaintingView(
                    imageAsset: 'assets/saleh-painting.png',
                    name: TranslatedString(
                      strings: {
                        AppLanguage.en: "PENANGKAPAN PANGERAN DIPONEGORO",
                        AppLanguage.id: "PENANGKAPAN PANGERAN DIPONEGORO",
                      },
                    ),
                    uiOnRight: false,
                    pointOfInterests:
                        PaintingRepository().salehPointOfInterests,
                    funFacts: PaintingRepository().salehFunFacts,
                    onSelectPainting: _showPainting,
                  ),
                ),
              ),

              vwSlider(handleX),

              if (_showRightSliderNudge)
                SliderNudgeView(
                  handleX: handleX,
                  isOnRight: true,
                  onClose: () {
                    setState(() {
                      _showRightSliderNudge = false;
                    });
                  },
                ),
              if (_showLeftSliderNudge)
                SliderNudgeView(
                  handleX: handleX,
                  isOnRight: false,
                  onClose: () {
                    setState(() {
                      _showLeftSliderNudge = false;
                    });
                  },
                ),

              Container(
                padding: EdgeInsets.all(35.sc),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [LanguageToggleSwitch()],
                ),
              ),

              if (_selectedPainting != null)
                Stack(
                  children: [
                    AnimatedBuilder(
                      animation: _modalAnimation,
                      builder: (context, child) {
                        return GestureDetector(
                          onTap: _hidePainting,
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            color: Colors.black.withOpacity(
                              0.8 * _modalAnimation.value,
                            ),
                          ),
                        );
                      },
                    ),
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _modalAnimation,
                        _scaleAnimation,
                      ]),
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Opacity(
                            opacity: _modalAnimation.value,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              padding: EdgeInsets.all(100.sc),
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFFFD700),
                                      width: 47.sc,
                                    ),
                                    borderRadius: BorderRadius.circular(35.sc),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        blurRadius: 20.sc,
                                        offset: Offset(0, 10.sc),
                                      ),
                                      BoxShadow(
                                        color: const Color(
                                          0xFFFFD700,
                                        ).withOpacity(0.3),
                                        blurRadius: 40.sc,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.sc),
                                    child: GestureDetector(
                                      onDoubleTap: () {
                                        if (_transformationController.value
                                                .getMaxScaleOnAxis() >
                                            1.1) {
                                          _transformationController.value =
                                              Matrix4.identity();
                                        } else {
                                          _transformationController.value =
                                              Matrix4.identity()
                                                ..scale(2.0)
                                                ..translate(
                                                  -MediaQuery.of(
                                                        context,
                                                      ).size.width /
                                                      4,
                                                  -MediaQuery.of(
                                                        context,
                                                      ).size.height /
                                                      4,
                                                );
                                        }
                                      },
                                      child: InteractiveViewer(
                                        transformationController:
                                            _transformationController,
                                        minScale: 0.5,
                                        maxScale: 4.0,
                                        constrained: true,
                                        child: Image.asset(
                                          _selectedPainting!,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 2000),
                switchInCurve: Curves.elasticIn,
                switchOutCurve: Curves.easeIn,
                child:
                    _showCoverScreen
                        ? GestureDetector(
                          key: const ValueKey("coverScreen"),
                          onTap: () {
                            setState(() {
                              _showCoverScreen = false;
                            });
                          },
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/bg-home-screen.png",
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                              Padding(
                                padding: EdgeInsets.all(120.sc),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "PENANGKAPAN PANGERAN \nDIPONEGORO",
                                      style: TextStyle(
                                        fontSize: 80.sc,
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "Airone",
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(120.sc),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      children: [
                                        Spacer(),
                                        Text(
                                          "THE ARREST OF DIPONEGORO BY \nLIEUTENANT GENERAL DE KOCK",
                                          style: TextStyle(
                                            fontSize: 80.sc,
                                            color: Color(0xFFFFFFFF),
                                            fontFamily: "Airone",
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              vwSlider(handleX),
                            ],
                          ),
                        )
                        : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned vwSlider(double handleX) {
    return Positioned(
      left: handleX,
      top: 0,
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 40.sc, color: Colors.white),
          Container(
            width: 130.sc,
            height: 130.sc,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(65.sc),
            ),
          ),
          Container(
            width: 80.sc,
            height: 80.sc,
            decoration: BoxDecoration(
              color: Color(0xFF636363),
              borderRadius: BorderRadius.circular(40.sc),
            ),
          ),
          SizedBox(
            width: 80.sc,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(Icons.code, color: Colors.white, size: 60.sc)],
            ),
          ),
        ],
      ),
    );
  }
}
