import 'package:flutter/material.dart';
import 'gradient_text.dart';

Column selectCountry(
    String text, String image, double fontsize, BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        child: Image.asset(
          image,
          width: width / 12,
          height: width / 9.5,
          fit: BoxFit.contain,
        ),
      ),
      Center(child: silverGradient(text, fontsize))
    ],
  );
}
