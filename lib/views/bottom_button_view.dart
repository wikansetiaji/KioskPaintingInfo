import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';

class BottomButtonView extends StatelessWidget {
  const BottomButtonView({super.key, required this.text, required this.icon, required this.isOtherOpened});

  final String text;
  final IconData icon;
  final bool isOtherOpened;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.sc),
      decoration: BoxDecoration(
        color: isOtherOpened ? Color(0xFF373737) : Color(0xFF4C4C4C),
        borderRadius: BorderRadius.circular(8.sc),
      ),
      child: Row(
        spacing: 10.sc,
        children: [
          Icon(icon, color: isOtherOpened ? Color(0xFF929292) : Color(0xFFFFE8AB), size: 20.sc),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sc, color: isOtherOpened ? Color(0xFF929292) : Colors.white),
          ),
        ],
      ),
    );
  }
}
