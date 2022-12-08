import 'dart:convert';

import 'package:client_information/client_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web/sign_in_sign_up/web_signin.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';
import '../../app_routes/app_routes.dart';
import '../../models/user_session_model.dart';
import '../../utils/components/custom_toast.dart';
import '../../utils/components/gradient_text.dart';
import '../../utils/constants/api_constants.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

class BindOTPScreen extends StatefulWidget {
  // String? image;
  // String? text;
  // final String? data;
  // BindOTPScreen({this.data});

  @override
  State<BindOTPScreen> createState() => _BindOTPScreenState();
}

class _BindOTPScreenState extends State<BindOTPScreen> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? otpCode;
  // String? tokenKey;
  bool isLoading = false;
  bool isverifying = false;
  ClientInformation cli = ClientInformation();
  var platformName = '';
  getPlateform() {
    if (kIsWeb) {
      platformName = "Web";
    } else {
      if (Platform.isAndroid) {
        platformName = "Android";
      } else if (Platform.isIOS) {
        platformName = "IOS";
      } else if (Platform.isFuchsia) {
        platformName = "Fuchsia";
      } else if (Platform.isLinux) {
        platformName = "Linux";
      } else if (Platform.isMacOS) {
        platformName = "MacOS";
      } else if (Platform.isWindows) {
        platformName = "Windows";
      }
    }
    print("platformName :- " + platformName.toString());
  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xBD8E37).withOpacity(1),
      Color(0xFCD877).withOpacity(1),
      Color(0xFFFFD1).withOpacity(1),
      // Color.fromARGB(0, 248, 248, 133).withOpacity(1),
      Color(0xC1995C).withOpacity(1),
    ],
  ).createShader(Rect.fromLTWH(200.0, 0.0, 0.0, 70.0));
  Future<ClientInformation> getDeviceId() async {
    return (await ClientInformation.fetch());
  }

  String? tokenKeyofOtp;
  @override
  void initState() {
    super.initState();
    // tokenKey = widget.data;
    // print("my token key ${widget.data}");
    getPlateform();
    getDeviceId().then((value) {
      cli = value;
    });
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
          final data = json.decode(response1.body);
          print(data);

          CustomToast.customToast(context, data['msg']);
          setState(() {
            tokenKeyofOtp = data['response']['userToken'];
            isLoading = false;
          });
          break;
        case 400:
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
            "tokenKey": tokenKeyofOtp,
            "otpCode": otpCode,
            "deviceInfo": {
              "id": "${cli.deviceId}",
              "platform": "${platformName.toString()}"
            },
            "version": "4.0.1"
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

            Map<String, dynamic> decodedata = jsonDecode(aa);
            setState(() {
              um = UserSessionModel.fromJson(decodedata);
              print("tttt ${um!.response!.user!.memberUsername}");
            });

            context.goNamed(RouteCon.home_Page);
          });

          setState(() {
            isverifying = false;
          });

          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isverifying = false;
          });
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
                        topbackbutton(context, RouteCon.signin_page),
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
                                          print(otpCode);
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
