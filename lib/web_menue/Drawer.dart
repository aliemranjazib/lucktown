import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFCD877);
const kDarkBlackColor = Colors.black;
const kBgColor = Color(0xFFE7E7E7);
const kBodyTextColor = Color(0xFF666666);
const kContainerBg = Color(0xFF252A2D);

const kDefaultPadding = 20.0;
const kMaxWidth = 1232.0;
const kDefaultDuration = Duration(milliseconds: 250);

class DrawerTitle extends StatelessWidget {
  final String title;
  final Icon menuIcon;
  final bool isActive;
  final VoidCallback press;
  const DrawerTitle({
    Key? key,
    required this.title,
    required this.isActive,
    required this.press,
    required this.menuIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        selected: isActive,
        selectedTileColor: kPrimaryColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        title: Text(title),
        leading: menuIcon,
        onTap: press);
  }
}
