import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/language_provider.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:provider/provider.dart';

class LanguageToggleSwitch extends StatelessWidget {
  const LanguageToggleSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LanguageProvider>(context);
    final isEnglish = provider.isEnglish;

    return GestureDetector(
      onTap: () => provider.toggleLanguage(),
      child: Container(
        width: 79.2.sc,
        height: 39.6.sc,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFF4B4B4B),
          borderRadius: BorderRadius.circular(19.8.sc),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.6.sc),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment:
                    isEnglish ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: 28.8.sc,
                  height: 28.8.sc,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      'EN',
                      style: TextStyle(
                        color: isEnglish ? Colors.black : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        fontSize: 18.sc,
                        letterSpacing: -3,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'ID',
                      style: TextStyle(
                        color: isEnglish ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        fontSize: 18.sc,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
