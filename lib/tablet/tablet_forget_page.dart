import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/components/social_buttons.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';

import '../utils/components/gradient_text.dart';
import '../utils/components/select_category.dart';

class TabletForgetPage extends StatefulWidget {
  // String? image;
  // String? text;

  @override
  State<TabletForgetPage> createState() => _TabletForgetPageState();
}

class _TabletForgetPageState extends State<TabletForgetPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xBD8E37).withOpacity(1),
      Color(0xFCD877).withOpacity(1),
      Color(0xFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(200.0, 0.0, 0.0, 70.0));

  int s() {
    if (index == 0) {
      print("000000000000000");
      setState(() {
        line_visible = true;
        line_visible1 = false;
      });
      return index;
    } else {
      print("11111111111111111111111");
      // line_visible = !line_visible;
      // line_visible = !line_visible;
      setState(() {
        line_visible1 = true;
        line_visible = false;
      });
      return index;
    }
  }

  @override
  Widget build(BuildContext context) {
    s();
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            Expanded(
              // child: Image.asset(bg),
              // child: Container(
              //   color: Colors.black,
              // ),
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(
                  color: bgColor,
                  image: DecorationImage(
                    image: AssetImage(tabletsidebar),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
                child: Center(child: Image.asset(logo)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 60),
                child: SingleChildScrollView(
                  child: Container(
                    // height: double.infinity,
                    color: bgColor,

                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(tabletrightbar),
                    //     fit: BoxFit.cover,
                    //     alignment: Alignment.center,
                    //   ),
                    // ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.navigate_before,
                                    color: Colors.white,
                                  ),
                                  iconSize: 40,
                                ),
                                SizedBox(width: 10),
                                Image.asset(
                                  logo,
                                  height: 60,
                                  width: 195,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            Image.asset(
                              chat,
                              width: 32,
                              height: 37,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),

                        // Image.asset(curve),
                        // logoWork(),
                        SizedBox(height: 70),
                        SizedBox(height: 10),

                        SizedBox(height: 50),

                        SizedBox(height: 70),

                        signIn(),

                        // select_country.map((e) => Text(e.text)).toList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget signIn() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // edit(),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 0),
                child: silverGradient('Recover Password', 28),
              )),
          SizedBox(height: 50),
          EcoTextField(
            upperText: "Your ID",
            hinttext: 'wayne123',
            preIcons: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(userIcon),
            ),
          ),
          SizedBox(height: 30),
          // EcoTextField(
          //   isPassword: true,
          //   upperText: "Password",
          //   postIcons: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.asset(eye_open),
          //   ),
          //   preIcons: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Image.asset(unlockIcon),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
            child: PrimaryButton(
                title: "Continue", width: double.infinity, onPress: () {}),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
