import 'package:flutter/material.dart';

class ProfileTextBarComponet extends StatelessWidget {
  final String title;
  String ImagePath;
  bool yesicon = false;
  ProfileTextBarComponet({required this.title, required this.ImagePath, required this.yesicon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        yesicon == true ? Image.asset(ImagePath) : Container(),
      ],
    );
  }
}