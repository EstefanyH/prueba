import 'package:flutter/material.dart';
import 'package:prueba/commom/css/fontstyle.dart';

class TitleBanner extends StatelessWidget {
  final String text;
  const TitleBanner({
    super.key,
    required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.keyboard_arrow_right),
          Text(text, style: style16Wblack,)
        ],
      ),);
  }
}