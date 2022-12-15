import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  final String title;
  final String value;
  const Info({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$title:",
          style: TextStyle(fontSize: 16),
        ),
        Text(
          "$value",
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
