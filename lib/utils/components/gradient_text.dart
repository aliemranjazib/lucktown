import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text_style.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

GradientText silverGradient(String text, double? fontsize) {
  return GradientText(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: "gotham",
    ),
    gradient:
        LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,
            // tileMode: TileMode.clamp,
            colors: [
          Color(0xBD8E37).withOpacity(1),
          Color(0xFCD877).withOpacity(1),
          Color(0xFFFFD1).withOpacity(1),
          // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
          Color(0xC1995C).withOpacity(1),
        ]),
  );
}

GradientText silverGradientLight(String text, double? fontsize) {
  return GradientText(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: gotham_light,
    ),
    gradient:
        LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter,
            // tileMode: TileMode.clamp,
            colors: [
          Color(0xBD8E37).withOpacity(1),
          Color(0xFCD877).withOpacity(1),
          Color(0xFFFFD1).withOpacity(1),
          // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
          Color(0xC1995C).withOpacity(1),
        ]),
  );
}

GradientText whitegradient() {
  return GradientText(
    'TownApp',
    style: const TextStyle(
      fontSize: 40,
      fontFamily: "gotham",
    ),
    gradient:
        LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
            // tileMode: TileMode.clamp,
            colors: [
          Color(0xFFFFFF).withOpacity(1),
          Color(0xCECECE).withOpacity(1),
          Color(0xFFFFD1).withOpacity(1),
          Color(0xF7E1C0).withOpacity(1),
        ]),
  );
}
