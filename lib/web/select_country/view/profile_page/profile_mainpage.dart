import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ProfileMainPage extends StatelessWidget {
  const ProfileMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                ? Text("aaaaaaa")
                : Text("BBBBB")
          ],
        ));
  }
}

Container cc(double) {
  return Container(
    height: 300,
    width: 300,
    color: Colors.red,
  );
}
