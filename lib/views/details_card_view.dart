import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
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
    final cardWidth = 300.0.sc;
    
    // Calculate dynamic height based on content
    final titlePainter = TextPainter(
      text: TextSpan(
        text: point.name,
        style: TextStyle(
          fontSize: 16.sc,
          fontWeight: FontWeight.bold,
        ),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: cardWidth - 24.sc); // Account for padding
    
    final descriptionPainter = TextPainter(
      text: TextSpan(
        text: point.description,
        style: TextStyle(fontSize: 14.sc),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    descriptionPainter.layout(maxWidth: cardWidth - 24.sc); // Account for padding
    
    final cardHeight = titlePainter.height + 8.sc + descriptionPainter.height + 24.sc; // titleHeight + spacing + descHeight + padding
    
    double left = positionX - cardWidth / 2;
    double top = positionY + 20.sc;

    // Adjust horizontal position
    if (left + cardWidth > width) {
      left = positionX - cardWidth;
    }
    if (left - cardWidth / 2 < 0) {
      left = positionX;
    }
    
    if (top + cardHeight > height) {
      top = positionY - 60.sc - cardHeight;
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
            padding: EdgeInsets.all(12.sc),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.sc),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(100),
                  blurRadius: 8.sc,
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
                  style: TextStyle(
                    fontSize: 16.sc,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.sc),
                Text(
                  point.description,
                  style: TextStyle(fontSize: 14.sc),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}