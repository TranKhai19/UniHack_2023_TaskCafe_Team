import 'package:flutter/material.dart';

class textFrotmat {
  bool isExceedsThreeLines(String text, TextStyle style, double maxWidth) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
      text: textSpan,
      maxLines: 3,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
}
}
