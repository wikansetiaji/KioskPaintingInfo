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
    required this.onClose,
  });

  final PointOfInterest point;
  final double width;
  final double height;
  final double opacity;
  final double scale;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final positionX = width * point.x;
    final positionY = height * point.y;
    final cardWidth = 892.0.sc;

    // Calculate dynamic height based on content
    final titlePainter = TextPainter(
      text: TextSpan(
        text: point.name.text(context),
        style: TextStyle(fontSize: 36.sc, fontWeight: FontWeight.bold),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    titlePainter.layout(maxWidth: cardWidth - 64.sc); // Account for padding

    final descriptionPainter = TextPainter(
      text: TextSpan(
        text: point.description.text(context),
        style: TextStyle(fontSize: 36.sc),
      ),
      maxLines: null,
      textDirection: TextDirection.ltr,
    );
    descriptionPainter.layout(
      maxWidth: cardWidth - 64.sc,
    ); // Account for padding

    final cardHeight =
        titlePainter.height +
        descriptionPainter.height +
        64.sc; // titleHeight + descHeight + padding

    double left = positionX - cardWidth / 2;
    double top = positionY + 20.sc;

    // Adjust horizontal position
    if (left + cardWidth > width - 40.sc) {
      left = positionX - cardWidth;
    }
    if (left - cardWidth / 2 < 0) {
      left = positionX;
    }

    if (top + cardHeight > height - 240.sc) {
      top = positionY - 240.sc - cardHeight;
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
            decoration: BoxDecoration(
              color: Color(0xFF2C2B2B),
              borderRadius: BorderRadius.circular(20.sc),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width,
                  padding: EdgeInsets.all(32.sc),
                  decoration: BoxDecoration(
                    color: Color(0xFF4C4C4C),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.sc),
                      topRight: Radius.circular(20.sc),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        point.name.text(context),
                        style: TextStyle(
                          fontSize: 36.sc,
                          color: Colors.white,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: onClose,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 48.sc,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(32.sc),
                  child: Text(
                    point.description.text(context),
                    style: TextStyle(
                      fontSize: 36.sc,
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
