import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/event_bus.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> with TickerProviderStateMixin {
  double _dragPosition = 0.5;
  String? _selectedPainting;
  late AnimationController _modalAnimationController;
  late AnimationController _scaleAnimationController;
  late Animation<double> _modalAnimation;
  late Animation<double> _scaleAnimation;

  // Transform controller for zoom and pan
  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

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

  @override
  void dispose() {
    _modalAnimationController.dispose();
    _scaleAnimationController.dispose();
    _transformationController.dispose();
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
    final handleX = _dragPosition * screenWidth;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            if (_selectedPainting != null) {
              return;
            }
            _dragPosition += details.delta.dx / screenWidth;
            _dragPosition = _dragPosition.clamp(0.0, 1.0);
          });
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
                  imageAsset: 'assets/pieneman-painting.jpg',
                  text: "Pieneman's Painting",
                  uiOnRight: true,
                  pointOfInterests: [
                    PointOfInterest(
                      id: "1",
                      name: "The Mysterious Garden Gateway",
                      description:
                          "This ornate archway leads to a secret garden where ancient roses bloom year-round. Legend says that lovers who pass through together will be blessed with eternal happiness and prosperity.",
                      x: 0.5,
                      y: 0.95,
                    ),
                    PointOfInterest(
                      id: "2",
                      name: "The Weathered Stone Fountain",
                      description:
                          "Built in 1847, this fountain was once the centerpiece of the estate's main courtyard. The intricate carvings depict scenes from classical mythology, including the story of Persephone and her journey between worlds.",
                      x: 0.85,
                      y: 0.91,
                    ),
                    PointOfInterest(
                      id: "3",
                      name: "The Artist's Studio Window",
                      description:
                          "From this very window, the renowned painter Elena Martinez created her famous series of landscape paintings. The natural light streaming through this opening inspired some of the most celebrated works of the 19th century.",
                      x: 0.85,
                      y: 0.5,
                    ),
                    PointOfInterest(
                      id: "4",
                      name: "The Ancient Oak Tree",
                      description:
                          "This majestic oak tree has stood here for over 300 years, witnessing countless seasons and historical events. Local folklore claims that wishes made while touching its bark during the full moon will come true within a year.",
                      x: 0.6,
                      y: 0.4,
                    ),
                  ],
                  funFacts: [
                    FunFact(
                      title: "The Hidden Signature",
                      description:
                          "Pieneman hid his signature in the painting's lower right corner, disguised as part of the stonework on the fountain. It wasn't discovered until 1923 during a restoration.",
                    ),
                    FunFact(
                      title: "Color Experimentation",
                      description:
                          "This was Pieneman's first major work using the newly developed cobalt blue pigment, which gives the sky its distinctive vibrant hue.",
                    ),
                    FunFact(
                      title: "Royal Commission",
                      description:
                          "The painting was commissioned by King William II of the Netherlands as a gift for his wife, Queen Anna Pavlovna. It hung in their summer palace for 40 years.",
                    ),
                    FunFact(
                      title: "Lost and Found",
                      description:
                          "The painting was missing for nearly two decades after being stolen in 1891. It was rediscovered in an attic in Brussels wrapped in newspaper.",
                    ),
                    FunFact(
                      title: "Weather Recording",
                      description:
                          "Art historians believe the cloud formations accurately depict the weather on June 15, 1842, as verified by meteorological records from nearby weather stations.",
                    ),
                    FunFact(
                      title: "Symbolic Butterflies",
                      description:
                          "The three butterflies near the garden gate represent Pieneman's three daughters. This was a personal touch the artist often included in his works.",
                    ),
                  ],
                  onSelectPainting: _showPainting,
                ),
              ),
            ),

            ClipRect(
              child: Align(
                alignment: Alignment.centerLeft,
                widthFactor: _dragPosition,
                child: PaintingView(
                  imageAsset: 'assets/saleh-painting.jpg',
                  text: "Saleh's Painting",
                  uiOnRight: false,
                  pointOfInterests: [
                    PointOfInterest(
                      id: "1",
                      name: "The Grand Ballroom Chandelier",
                      description:
                          "This magnificent crystal chandelier contains over 2,000 individual crystals, each hand-cut and carefully positioned. It was commissioned by the estate's original owner and took master craftsmen three years to complete.",
                      x: 0.05,
                      y: 0.85,
                    ),
                    PointOfInterest(
                      id: "2",
                      name: "The Hidden Library Alcove",
                      description:
                          "Behind this seemingly ordinary bookshelf lies a secret reading nook where the estate's children would hide during their lessons. The alcove contains first-edition books dating back to the 1600s, including rare manuscripts and poetry collections.",
                      x: 0.5,
                      y: 0.7,
                    ),
                    PointOfInterest(
                      id: "3",
                      name: "The Marble Staircase Banister",
                      description:
                          "Carved from a single piece of Carrara marble, this banister features intricate floral patterns that change subtly as they spiral upward. Each flower represents a different member of the founding family.",
                      x: 0.2,
                      y: 0.2,
                    ),
                    PointOfInterest(
                      id: "4",
                      name: "The Portrait Gallery Corner",
                      description:
                          "This corner houses portraits of five generations of the estate's inhabitants. The paintings are arranged chronologically, telling the visual story of changing fashion, artistic styles, and family traditions across two centuries.",
                      x: 0.3,
                      y: 0.3,
                    ),
                  ],
                  funFacts: [
                    FunFact(
                      title: "Revolutionary Techniques",
                      description:
                          "Raden Saleh introduced European Romanticism to Javanese art, blending Western techniques with traditional Indonesian themes in this groundbreaking work.",
                    ),
                    FunFact(
                      title: "Historical Accuracy",
                      description:
                          "The painting's depiction of Diponegoro's arrest has been verified by Dutch military records, showing Saleh's commitment to historical detail despite the dramatic composition.",
                    ),
                    FunFact(
                      title: "Symbolic Colors",
                      description:
                          "The red in Diponegoro's headdress was made from crushed cochineal insects imported from Mexico, symbolizing both his royal status and the blood of resistance.",
                    ),
                    FunFact(
                      title: "European Influence",
                      description:
                          "Saleh painted this work while studying under Horace Vernet in France, incorporating dramatic lighting techniques learned from his European mentors.",
                    ),
                    FunFact(
                      title: "Lost Preparatory Sketches",
                      description:
                          "38 preparatory sketches for this painting were discovered in 2001 in a Dutch collector's estate, revealing Saleh's meticulous planning process.",
                    ),
                    FunFact(
                      title: "Political Message",
                      description:
                          "The painting's composition subtly criticizes colonial power by placing Diponegoro at the visual center despite being the captured figure.",
                    ),
                    FunFact(
                      title: "Restoration Discovery",
                      description:
                          "During a 1995 restoration, conservators found a hidden layer showing an alternative composition where Diponegoro appears more defiant.",
                    ),
                    FunFact(
                      title: "International Recognition",
                      description:
                          "This painting was exhibited at the 1857 Paris Salon, making Saleh the first Indonesian artist to gain significant European recognition.",
                    ),
                  ],
                  onSelectPainting: _showPainting,
                ),
              ),
            ),

            vwSlider(handleX),

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
                                    width: 22.sc,
                                  ),
                                  borderRadius: BorderRadius.circular(12.sc),
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
          ],
        ),
      ),
    );
  }

  Positioned vwSlider(double handleX) {
    return Positioned(
      left: handleX - 25.sc,
      top: 0,
      bottom: 0,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: 16.sc, color: Color(0xFF4F5051)),
          Container(
            width: 50.sc,
            height: 50.sc,
            decoration: BoxDecoration(
              color: Color(0xFF4F5051),
              borderRadius: BorderRadius.circular(25.sc),
            ),
          ),
          Container(
            width: 30.sc,
            height: 30.sc,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.sc),
            ),
          ),
          SizedBox(
            width: 50.sc,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Icon(Icons.chevron_left, color: Color(0xFF4F5051), size: 17.sc),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xFF4F5051),
                  size: 17.sc,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
