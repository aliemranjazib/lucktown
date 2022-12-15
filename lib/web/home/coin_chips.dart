import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

import '../../utils/components/gradient_text.dart';

class coin_chips extends StatelessWidget {
  final String title;
  final String value;

  const coin_chips({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            children: [
              // SizedBox(width: 5),
              Text(
                "$title",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        silverGradient("$value", 16),
        Image.asset(pCoin),
        // Container(),
      ],
    );
  }
}
