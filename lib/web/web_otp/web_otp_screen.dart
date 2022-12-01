import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../models/user_session_model.dart';
import '../../utils/components/custom_toast.dart';
import '../../utils/components/gradient_text.dart';
import '../../utils/constants/api_constants.dart';

class OTPScreen extends StatefulWidget {
  // String? image;
  // String? text;
  // final String? data;
  // OTPScreen({this.data});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? otpCode;
  // String? tokenKey;
  bool isLoading = false;
  bool isverifying = false;

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
  void initState() {
    super.initState();
    // tokenKey = widget.data;
    // print("my token key ${widget.data}");
  }

  getOtp() async {
    print(temAuth);
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/otpBind'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": "$temAuth",
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"tokenKey": "$tokenKey"}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoading = false;
          });
          final data = json.decode(response1.body);
          print(data);
          CustomToast.customToast(context, data['msg']);

          break;
        default:
          final data = json.decode(response1.body);
          // print(data);
          print(response1.statusCode);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            // index = 0;
            isLoading = false;
          });
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
      setState(() {
        // index = 0;
        isLoading = false;
      });
    }
  }

  verifyOtp() async {
    setState(() {
      isverifying = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/bind'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "Authorization": temAuth!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "tokenKey":
                "ULHrzxpJGnQBNqaS95ttbRdQ7BA9XoQTeRmnsrXHV9o7V96w2KktS2IgZ6KRQrPKbkdmR1ohRc7UQbr27log2amjFqk2ZL99G4ueE90drNCoyIAW5MnKwPiUjD4AOgkHwSTO9Iz3wWWBpAjb2Q5vHAlMzrbc6cZmp20ujKrDycWYzs7gFFfksm9YqqsMydThjNyuk4Z0",
            "otpCode": "439428",
            "deviceInfo": {
              "id": "33CC669C-2CB7-4B9A-B0A9-ED3B2DD6BCFB",
              "platform": "web"
            },
            "version": "1.0.8"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isverifying = false;
          });

          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            // userModel = user.User.fromJson(data['response']['user']);
          });
          CustomToast.customToast(context, data['msg']);
          // Navigator.pushNamed(context, web_home_Page);
          // print("ooo ${dau.getAllUsers()}");
          Future.delayed(
              Duration(
                seconds: 1,
              ), () {
            LuckySharedPef.saveAuthToken(response1.body);
            // LuckySharedPef.saveOnlyAuthToken(data['response']['authToken']);
          });
          // String? otp = data['response']['userToken'];

          Future.delayed(
              Duration(
                seconds: 1,
              ), () {
            String aa = LuckySharedPef.getAuthToken();
            print(aa);
            // String bb = LuckySharedPef.getOnlyAuthToken();
            // print("get only auth ${bb}");

            Map<String, dynamic> decodedata = jsonDecode(aa);
            setState(() {
              um = UserSessionModel.fromJson(decodedata);
              print("tttt ${um!.response!.user!.memberUsername}");
            });

            // Navigator.pushNamed(context, web_home_Page);
            Navigator.pushNamed(context, web_home_Page);
            // print()
          });

          setState(() {
            isverifying = false;
          });
          // setState(() {
          //   tempAuthKey = data['response']['authToken'];
          // });
          // Navigator.pushNamed(context, web_otp_page, arguments: {
          //   "authkey": data['response']['authToken'],
          //   "usertoken": data['response']['userToken']
          // });
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          break;
        default:
          final data = json.decode(response1.body);
          // print(data);
          print(response1.statusCode);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            // index = 0;
            isverifying = false;
          });
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
      setState(() {
        // index = 0;
        isverifying = false;
      });
    }
  }

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
                        topbackbutton(context, web_signin_page),
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
                                    child: silverGradient("OTP Code Bind", 28),
                                  ),
                                  // SizedBox(height: 40),

                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: silverGradientLight(
                                          "Enter 6 Digit Code", 18),
                                    ),
                                  ),
                                  // SizedBox(height: 40),
                                  PrimaryButton(
                                      loading: isLoading,
                                      title: "GET OTP",
                                      onPress: () async {
                                        getOtp();
                                      },
                                      width: double.infinity),
                                  SizedBox(height: 30),
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
                                      // showDialog(
                                      //     context: context,
                                      //     builder: (context) {
                                      //       return AlertDialog(
                                      //         title: Text("Verification Code"),
                                      //         content: Text(
                                      //             'Code entered is $verificationCode'),
                                      //       );
                                      //     });
                                    }, // end onSubmit
                                  ),
                                  SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: PrimaryButton(
                                        title: "Continue",
                                        width: double.infinity,
                                        loading: isverifying,
                                        onPress: () {
                                          verifyOtp();
                                        }),
                                  ),
                                  SizedBox(height: 20),

                                  Align(
                                      alignment: Alignment.center,
                                      child: silverGradient(
                                          "Did not receive code?", 18)),
                                  Align(
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () {
                                        getOtp();
                                      },
                                      child: Text(
                                        "Click here",
                                        style: TextStyle(color: Colors.white),
                                      ),
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
    );
  }
}
