import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../utils/components/gradient_text.dart';

class WebForgetPage extends StatefulWidget {
  // String? image;
  // String? text;

  @override
  State<WebForgetPage> createState() => _WebForgetPageState();
}

class _WebForgetPageState extends State<WebForgetPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? isoCode;

  final TextEditingController phoneController = TextEditingController();

  // final Shader linearGradient = LinearGradient(
  //   colors: <Color>[
  //     Color(0xBD8E37).withOpacity(1),
  //     Color(0xFCD877).withOpacity(1),
  //     Color(0xFFFFD1).withOpacity(1),
  //     // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
  //     Color(0xC1995C).withOpacity(1),
  //   ],
  // ).createShader(Rect.fromLTWH(200.0, 0.0, 0.0, 70.0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            ResponsiveVisibility(
              visible: true,
              hiddenWhen: [Condition.smallerThan(name: TABLET)],
              child: Expanded(
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
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, right: 10),
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

                        forgotPageUi(),

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

  Widget forgotPageUi() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            // edit(),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: silverGradient(
                      'Recover Password',
                      ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 28
                          : 16),
                )),
            SizedBox(height: 50),

            EcoMobileTextField(
              upperText: "Mobile Number",
              controller: phoneController,
              isoCode: isoCode,
              onChanged: (p) {
                print("okk ${p!.dialCode}");
                isoCode = p.dialCode;
              },
            ),
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
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: PrimaryButton(
                title: "Continue",
                onPress: () {},
                width: double.infinity,
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
