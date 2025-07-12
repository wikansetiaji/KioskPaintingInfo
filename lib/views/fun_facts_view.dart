import 'package:flutter/material.dart';
import 'package:kiosk_painting_info/services/size_config.dart';
import 'package:kiosk_painting_info/views/painting_view.dart';

class FunFactsView extends StatefulWidget {
  const FunFactsView({super.key, required this.name, required this.funFacts});

  final String name;
  final List<FunFact> funFacts;

  @override
  State<FunFactsView> createState() => _FunFactsViewState();
}

class _FunFactsViewState extends State<FunFactsView> {
  int? _selectedFunFact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 892.sc,
      padding: EdgeInsets.all(48.sc),
      decoration: BoxDecoration(
        color: Color(0xFF38383A),
        borderRadius: BorderRadius.circular(20.sc),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            styledTextSpan(
              fullText: widget.name.toUpperCase(),
              highlighted: "DIPONEGORO",
              normalStyle: TextStyle(
                fontSize: 52.sc,
                color: Color(0xFFEBBC4A),
                fontFamily: "Inter",
                fontWeight: FontWeight.bold,
              ),
              highlightedStyle: TextStyle(
                fontSize: 52.sc,
                color: Color(0xFFEBBC4A),
                fontFamily: "Airone",
                fontWeight: FontWeight.normal,
                letterSpacing: 1
              ),
            ),
          ),
          Divider(color: Color(0xFF4C4C4C)),
          SizedBox(height: 10.sc),
          ...widget.funFacts.asMap().entries.map((entry) {
            final index = entry.key;
            final fact = entry.value;
            final isExpanded = _selectedFunFact == index;

            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFunFact = isExpanded ? null : index;
                    });
                  },
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    width: 892.sc,
                    padding: EdgeInsets.all(32.sc),
                    decoration: BoxDecoration(
                      color: Color(0xFF4C4C4C),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.sc),
                        topRight: Radius.circular(12.sc),
                        bottomLeft:
                            isExpanded
                                ? Radius.circular(0.0)
                                : Radius.circular(12.sc),
                        bottomRight:
                            isExpanded
                                ? Radius.circular(0.0)
                                : Radius.circular(12.sc),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            fact.title.text(context),
                            style: TextStyle(
                              fontSize: 36.sc,
                              color: Colors.white,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                          size: 48.sc,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 100),
                  crossFadeState:
                      isExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                  firstChild: SizedBox(height: 0, width: 892.sc),
                  secondChild: Container(
                    width: 892.sc,
                    padding: EdgeInsets.all(32.sc),
                    decoration: BoxDecoration(
                      color: Color(0xFF2C2B2B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.sc),
                        bottomRight: Radius.circular(12.sc),
                      ),
                    ),
                    child: Text(
                      fact.description.text(context),
                      style: TextStyle(
                        fontSize: 36.sc,
                        color: Colors.white,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.sc),
              ],
            );
          }),
        ],
      ),
    );
  }

  TextSpan styledTextSpan({
    required String fullText,
    required String highlighted,
    required TextStyle normalStyle,
    required TextStyle highlightedStyle,
  }) {
    if (highlighted.isEmpty) {
      return TextSpan(text: fullText, style: normalStyle);
    }

    final text = fullText.toLowerCase();
    final highlight = highlighted.toLowerCase();
    final spans = <TextSpan>[];
    int start = 0;
    int index;

    while ((index = text.indexOf(highlight, start)) != -1) {
      // Add the non-highlighted text before the match
      if (index > start) {
        spans.add(
          TextSpan(text: fullText.substring(start, index), style: normalStyle),
        );
      }

      // Add the highlighted text
      spans.add(
        TextSpan(
          text: fullText.substring(index, index + highlight.length),
          style: highlightedStyle,
        ),
      );

      start = index + highlight.length;
    }

    // Add any remaining non-highlighted text
    if (start < fullText.length) {
      spans.add(TextSpan(text: fullText.substring(start), style: normalStyle));
    }

    return TextSpan(children: spans);
  }
}
