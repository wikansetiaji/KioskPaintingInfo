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
      width: 500.sc,
      padding: EdgeInsets.all(20.sc),
      decoration: BoxDecoration(
        color: Color(0xFF38383A),
        borderRadius: BorderRadius.circular(10.sc),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.name.toUpperCase(),
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 20.sc,
              fontWeight: FontWeight.bold,
              color: Color(0xFFEBBC4A),
            ),
          ),
          Divider(color: Color(0xFF4C4C4C),),
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
                    width: 500.sc,
                    padding: EdgeInsets.all(14.sc),
                    decoration: BoxDecoration(
                      color: Color(0xFF4C4C4C),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.sc),
                        topRight: Radius.circular(10.sc),
                        bottomLeft: isExpanded ? Radius.circular(0.0) : Radius.circular(10.sc),
                        bottomRight: isExpanded ? Radius.circular(0.0) : Radius.circular(10.sc),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            fact.title,
                            style: TextStyle(
                              fontSize: 14.sc,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Icon(
                          isExpanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.white,
                          size: 20.sc,
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 100),
                  crossFadeState: isExpanded 
                      ? CrossFadeState.showSecond 
                      : CrossFadeState.showFirst,
                  firstChild: SizedBox(height: 0, width: 500.sc,),
                  secondChild: Container(
                    width: 500.sc,
                    padding: EdgeInsets.all(14.sc),
                    decoration: BoxDecoration(
                      color: Color(0xFF2C2B2B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.sc),
                        bottomRight: Radius.circular(10.sc),
                      ),
                    ),
                    child: Text(
                      fact.description,
                      style: TextStyle(
                        fontSize: 14.sc,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.sc),
              ],
            );
          }),
        ],
      ),
    );
  }
}