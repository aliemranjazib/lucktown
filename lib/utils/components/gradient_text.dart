import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text_style.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:google_fonts/google_fonts.dart';

Text silverGradient(String text, double? fontsize) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: "gotham",
    ),
  );
}

Text silverGradientRobto(String text, double? fontsize, FontWeight weight) {
  return Text(
    text,
    style: GoogleFonts.roboto(fontSize: fontsize, fontWeight: weight),
  );
}

Text silverGradientLight(String text, double? fontsize) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontsize,
      fontFamily: gotham_light,
    ),
  );
}

Text whiteText(String text, double? fontsize,) {
  return Text(
    text,
    style: GoogleFonts.roboto(fontSize: fontsize, ),
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
