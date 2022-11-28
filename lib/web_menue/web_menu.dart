import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';

import 'package:provider/provider.dart';

import '../web/menue_folder/menueProvider.dart';

class WebMenu extends StatefulWidget {
  @override
  State<WebMenu> createState() => _WebMenuState();
}

class _WebMenuState extends State<WebMenu> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MenuProvider>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.only(right: 0),
        child: Row(children: [
          ...List.generate(
            Provider.of<MenuProvider>(
              context,
            ).menuItems.length,
            (index) => WebMenuItem(
                isActive: index == value.selectedIndex,
                text: value.menuItems[index],
                press: () {
                  print("qqq ${value.menuItems[index]}");
                  if (value.menuItems[index] == "Home") {
                    Navigator.pushNamed(context, web_home_Page);
                  } else if (value.menuItems[index] == "Profile") {
                    Navigator.pushNamed(context, web_profile_page);
                  } else if (value.menuItems[index] == "Contact") {
                    Navigator.pushNamed(context, web_contact_main_page);
                  } else if (value.menuItems[index] == "Transactions") {
                    Navigator.pushNamed(context, web_transaction_page);
                  }
                  value.saveIndex(index, () {
                    // print("qqq ${value.selectedIndex}");
                    // if (value.selectedIndex == 1) {
                    //   Navigator.pushNamed(context, web_scaffold_page);
                    // } else if (value.selectedIndex == 3) {}
                  });
                }),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, web_scaffold_page);
              },
              icon: Icon(Icons.logout))
        ]),
      );
    });
  }
}

class WebMenuItem extends StatefulWidget {
  final bool isActive;

  final String text;

  final VoidCallback press;

  WebMenuItem(
      {required this.isActive, required this.text, required this.press});

  @override
  State<WebMenuItem> createState() => _WebMenuItemState();
}

class _WebMenuItemState extends State<WebMenuItem> {
  bool _isHover = false;
  Color _borderColor() {
    if (widget.isActive) {
      return kPrimaryColor;
    } else if (!widget.isActive & _isHover) {
      return kPrimaryColor.withOpacity(0.4);
    }
    return Colors.transparent;
  }

  Color _TextColor() {
    if (widget.isActive) {
      return kPrimaryColor;
    } else if (!widget.isActive & _isHover) {
      return kPrimaryColor.withOpacity(0.4);
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.press,
      // onHover: (value) {
      //  setState(() {
      //     _isHover = value;
      //  });
      // },
      child: AnimatedContainer(
          duration: kDefaultDuration,
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: EdgeInsets.symmetric(vertical: kDefaultPadding / 3),
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: _borderColor(), width: 3))),
          child: Text(
            widget.text,
            style: TextStyle(color: _TextColor()),
          )),
    );
  }
}
