import 'package:flutter/material.dart';

class ProfileTextBarComponet extends StatelessWidget {
  final String title;
  Icon icon = Icon(Icons.abc);
  bool yesicon = false;
  ProfileTextBarComponet({this.title, this.icon, this.yesicon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        yesicon == true ? icon : Container(),
      ],
    );
  }
}