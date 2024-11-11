import 'package:flutter/material.dart';

class CTextBox extends StatelessWidget {
  const CTextBox({super.key, required this.inputText, this.textStyle="body", this.center=false});
  final String inputText;
  final String textStyle;
  final bool center;

  @override
  Widget build(BuildContext context) {
    const double baseSize = 8;
    var styleToUse = const TextStyle(fontSize: baseSize);
    switch (textStyle) {
      case "title":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 5,fontWeight: FontWeight.bold);
        }
      case "sub-title":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 4);
        }
      case "sub-title1":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 2);
        }
      case "body":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 3);
        }
      case "body-1":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 3);
        }
      case "small-text":
        {
          styleToUse = const TextStyle(fontSize: baseSize * 2);
        }
    }
    return Align(alignment: center? Alignment.center : Alignment.topLeft, child: Padding(padding: EdgeInsets.all(5),child: Text(inputText, style: styleToUse, textAlign: TextAlign.left)));
  }
}
