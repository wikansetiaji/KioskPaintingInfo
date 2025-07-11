import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class SplitPage extends StatefulWidget {
  const SplitPage({super.key});

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  double _dragPosition = 0.5;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final handleX = _dragPosition * screenWidth;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
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
                  pointOfInterests: [
                    PointOfInterest(
                      name: "The Mysterious Garden Gateway",
                      description: "This ornate archway leads to a secret garden where ancient roses bloom year-round. Legend says that lovers who pass through together will be blessed with eternal happiness and prosperity.",
                      x: 0.5,
                      y: 0.95,
                    ),
                    PointOfInterest(
                      name: "The Weathered Stone Fountain",
                      description: "Built in 1847, this fountain was once the centerpiece of the estate's main courtyard. The intricate carvings depict scenes from classical mythology, including the story of Persephone and her journey between worlds.",
                      x: 0.85,
                      y: 0.91,
                    ),
                    PointOfInterest(
                      name: "The Artist's Studio Window",
                      description: "From this very window, the renowned painter Elena Martinez created her famous series of landscape paintings. The natural light streaming through this opening inspired some of the most celebrated works of the 19th century.",
                      x: 0.85,
                      y: 0.5,
                    ),
                    PointOfInterest(
                      name: "The Ancient Oak Tree",
                      description: "This majestic oak tree has stood here for over 300 years, witnessing countless seasons and historical events. Local folklore claims that wishes made while touching its bark during the full moon will come true within a year.",
                      x: 0.6,
                      y: 0.4,
                    ),
                  ],
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
                  pointOfInterests: [
                    PointOfInterest(
                      name: "The Grand Ballroom Chandelier",
                      description: "This magnificent crystal chandelier contains over 2,000 individual crystals, each hand-cut and carefully positioned. It was commissioned by the estate's original owner and took master craftsmen three years to complete.",
                      x: 0.05,
                      y: 0.95,
                    ),
                    PointOfInterest(
                      name: "The Hidden Library Alcove",
                      description: "Behind this seemingly ordinary bookshelf lies a secret reading nook where the estate's children would hide during their lessons. The alcove contains first-edition books dating back to the 1600s, including rare manuscripts and poetry collections.",
                      x: 0.5,
                      y: 0.7,
                    ),
                    PointOfInterest(
                      name: "The Marble Staircase Banister",
                      description: "Carved from a single piece of Carrara marble, this banister features intricate floral patterns that change subtly as they spiral upward. Each flower represents a different member of the founding family.",
                      x: 0.2,
                      y: 0.2,
                    ),
                    PointOfInterest(
                      name: "The Portrait Gallery Corner",
                      description: "This corner houses portraits of five generations of the estate's inhabitants. The paintings are arranged chronologically, telling the visual story of changing fashion, artistic styles, and family traditions across two centuries.",
                      x: 0.3,
                      y: 0.3,
                    ),
                  ],
                ),
              ),
            ),

            vwSlider(handleX),
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
                Icon(Icons.chevron_right, color: Color(0xFF4F5051), size: 17.sc),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}