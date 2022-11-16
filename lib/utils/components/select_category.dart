import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'gradient_text.dart';

Column selectCountry(String text, String image, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Image.asset(
          image,
          width: ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 124 : 84,
          height: ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 124 : 84,
          fit: BoxFit.contain,
        ),
      ),
      SizedBox(height: 10),
      Center(
          child: silverGradientRobto(
              text,
              ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 24 : 16,
              FontWeight.normal))
    ],
  );
}
