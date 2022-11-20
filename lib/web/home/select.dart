import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';

GestureDetector selection(
    String image, String text, GestureTapCallback? onTap) {
  return GestureDetector(
    onTap: onTap!,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(image, height: 20, width: 20),
        ),
        silverGradientLight(
          "$text",
          18,
        ),
      ],
    ),
  );
}
