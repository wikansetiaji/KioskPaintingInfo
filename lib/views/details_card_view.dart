import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class DetailsCardView extends StatelessWidget {
  const DetailsCardView({
    super.key,
    required this.point,
    required this.width,
    required this.height,
    required this.opacity,
    required this.scale,
  });

  final PointOfInterest point;
  final double width;
  final double height;
  final double opacity;
  final double scale;

  @override
  Widget build(BuildContext context) {
    final positionX = width * point.x;
    final positionY = height * point.y;
    final cardWidth = 300.0;
    
    // Calculate dynamic height based on content
    final titlePainter = TextPainter(
      text: TextSpan(
        text: point.name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: cardWidth - 24); // Account for padding
    
    final descriptionPainter = TextPainter(
      text: TextSpan(
        text: point.description,
        style: const TextStyle(fontSize: 14),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    descriptionPainter.layout(maxWidth: cardWidth - 24); // Account for padding
    
    final cardHeight = titlePainter.height + 8 + descriptionPainter.height + 24; // titleHeight + spacing + descHeight + padding
    
    double left = positionX - cardWidth / 2;
    double top = positionY + 20;

    // Adjust horizontal position
    if (left + cardWidth > width) {
      left = positionX - cardWidth;
    }
    if (left - cardWidth / 2 < 0) {
      left = positionX;
    }
    
    if (top + cardHeight > height) {
      top = positionY - 60 - cardHeight;
    }

    return Positioned(
      left: left,
      top: top,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Container(
            width: cardWidth,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  point.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  point.description,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}