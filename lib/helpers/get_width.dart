import 'package:flutter/material.dart';

double getWidth(@required String text, BuildContext context) {
  final Size size = (TextPainter(
          text: TextSpan(
            text: text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          maxLines: 1,
          textScaleFactor: MediaQuery.of(context).textScaleFactor,
          textDirection: TextDirection.ltr)
        ..layout())
      .size;
  return size.width;
}
