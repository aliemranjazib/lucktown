import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../utils/components/gradient_text.dart';

class SeetingTokenAndOtp {
  String? otp;
  String? userToken;

  SeetingTokenAndOtp({this.otp, this.userToken});
}

class SettingsForgetOtpPage extends StatefulWidget {
  String? userToken;
  SettingsForgetOtpPage({this.userToken});
  @override
  State<SettingsForgetOtpPage> createState() => _SettingsForgetOtpPageState();
}

class _SettingsForgetOtpPageState extends State<SettingsForgetOtpPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? otpCode;
  String? tokenKey;
  bool isLoading = false;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xBD8E37).withOpacity(1),
      Color(0xFCD877).withOpacity(1),
      Color(0xFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(200.0, 0.0, 0.0, 70.0));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Row(
          children: [
            ResponsiveVisibility(
              visible: true,
              hiddenWhen: const [Condition.smallerThan(name: TABLET)],
              child: Expanded(
                child: Container(
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
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, right: 60),
                  child: Container(
                    color: bgColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        topheader(context),
                        // SizedBox(height: 100),

                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 58, right: 48),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, bottom: 30),
                                    child: silverGradient("OTP Code", 28),
                                  ),
                                  // SizedBox(height: 40),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: silverGradientLight(
                                        "Enter 6 Digit Code", 18),
                                  ),
                                  // SizedBox(height: 40),
                                  OtpTextField(
                                    numberOfFields: 6,
                                    borderColor: Color(0xFFBD8E37),
                                    focusedBorderColor: Color(0xFFBD8E37),
                                    enabledBorderColor: Color(0xFFBD8E37),
                                    cursorColor: Color(0xFFBD8E37),
                                    margin: const EdgeInsets.all(0),
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    borderRadius: BorderRadius.circular(10),
                                    //set to true to show as box or false to show as dash
                                    showFieldAsBox: true,
                                    //runs when a code is typed in
                                    onCodeChanged: (String code) {
                                      //handle validation or checks here
                                    },
                                    //runs when every textfield is filled
                                    onSubmit: (String verificationCode) {
                                      otpCode = verificationCode;
                                    }, // end onSubmit
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: PrimaryButton(
                                        title: "Continue",
                                        width: double.infinity,
                                        onPress: () {
                                          SeetingTokenAndOtp top =
                                              SeetingTokenAndOtp(
                                            otp: "$otpCode",
                                            userToken: "${widget.userToken}",
                                          );
                                          context.goNamed(
                                              RouteCon.set_new_password,
                                              extra: top);
                                        }),
                                  ),
                                  SizedBox(height: 20),
                                  Align(
                                      alignment: Alignment.center,
                                      child: silverGradient(
                                          "Did not receive code?", 18)),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Click here",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Expanded topheader(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  GoRouter.of(context).pop();
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
    );
  }
}
