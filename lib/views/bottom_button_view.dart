import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';

class BottomButtonView extends StatelessWidget {
  const BottomButtonView({
    super.key,
    required this.text,
    required this.icon,
    required this.isOtherOpened,
  });

  final String text;
  final String icon;
  final bool isOtherOpened;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.sc),
      decoration: BoxDecoration(
        color: isOtherOpened ? Color(0xFF373737) : Color(0xFF4C4C4C),
        borderRadius: BorderRadius.circular(12.sc),
      ),
      child: Row(
        spacing: 32.sc,
        children: [
          Image.asset(
            icon,
            width: 60.sc,
            height: 60.sc,
            color: isOtherOpened ? Color(0xFF929292) : Color(0xFFFFE8AB),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40.sc,
              color: isOtherOpened ? Color(0xFF929292) : Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: "Inter",
            ),
          ),
        ],
      ),
    );
  }
}
