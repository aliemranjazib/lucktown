import 'package:flutter/material.dart';

import '../constants/contants.dart';
import 'gradient_text.dart';

Column logoWork() {
  return Column(
    children: [
      Image.asset(
        logo,
        height: 62,
        width: 202,
      ),
      // silverGradient('Welcome to the', 40),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          silverGradient('Lucky', 40),
          whitegradient(),
        ],
      ),
    ],
  );
}
