import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/change_nickname.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';

import '../../utils/components/gradient_text.dart';
import '../../utils/constants/contants.dart';
import '../../web_menue/Drawer.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              topbackbutton(context, web_profile_page),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "General Settings",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    tiles("Change Login Password", () {}),
                    tiles("Change Payment Pin", () {}),
                    tiles("Change Nickname", () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ChangeNickeName();
                        },
                      );
                    }),
                    tiles("Change Phone Number", () {}),
                    tiles("Switch Account", () {}),
                    tiles("Change", () {}),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Support",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    Column(
                      children: [
                        ListTile(
                          title: Text("Language"),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("English"),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios)),
                              ],
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                    tiles('About Phone', () {}),
                    tiles('About', () {}),
                    Column(
                      children: [
                        ListTile(
                          title: Text("Time Zone"),
                          trailing: Container(
                            child: Text("UST/GMT +8:00 Asia/KL"),
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Column tiles(String text, GestureTapCallback press) {
    return Column(
      children: [
        ListTile(
          title: Text("$text"),
          trailing: IconButton(
              onPressed: () {
                press();
              },
              icon: Icon(Icons.arrow_forward_ios)),
        ),
        Divider(
          color: Color(0xff212631),
          thickness: 0.5,
        ),
      ],
    );
  }
}

class SettingTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const SettingTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.validate,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: silverGradientRobto("$title", 16, FontWeight.normal)),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: TextStyle(color: Colors.black),
            fillColor: Color(0xffEEF2F5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffEEF2F5), width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
