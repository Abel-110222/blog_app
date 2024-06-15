import 'package:flutter/material.dart';

class MyTextClass extends StatelessWidget {
  ///
  final String text;
  final double fontSize;
  final Color colorText;
  final bool wrap;
  final bool bold;
  final int maxLines;
  final TextAlign textAlign;
  final bool enable;
  final bool isTextColor;

  ///
  const MyTextClass({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.colorText = Colors.black,
    this.wrap = true,
    this.bold = false,
    this.maxLines = 1,
    this.textAlign = TextAlign.left,
    this.enable = false,
    this.isTextColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: TextOverflow.fade,
      softWrap: wrap,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: isTextColor ? const Color(0xff00695C) : (enable ? const Color(0xFF9E9E9E) : colorText),
        backgroundColor: Colors.transparent,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}