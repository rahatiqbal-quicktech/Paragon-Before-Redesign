import 'package:courier/config/appColors.dart';
import 'package:flutter/material.dart';

class KText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  final String fontFamily;
  final int maxLines;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final double wordSpacing;

  final TextDirection textDirection;
  final TextDecoration decoration;

  KText({
    this.text,
    this.color,
    this.fontSize,
    this.fontFamily,
    this.maxLines,
    this.fontWeight,
    this.textAlign,
    this.textDirection,
    this.wordSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: TextStyle(
        decoration: decoration,
        fontSize: fontSize != null ? fontSize : 14,
        fontFamily: fontFamily,
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
        color: color != null ? color : black,
        wordSpacing: wordSpacing,
        overflow: TextOverflow.ellipsis,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      textDirection: textDirection,
    );
  }
}
