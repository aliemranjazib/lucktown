import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/ProfilePage.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/setting_page.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../utils/components/custom_toast.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/contants.dart';
import '../../../web_menue/Drawer.dart';

class ChangePaymentPin extends StatefulWidget {
  @override
  State<ChangePaymentPin> createState() => _ChangePaymentPinState();
}

class _ChangePaymentPinState extends State<ChangePaymentPin> {
  TextEditingController oldPInC = TextEditingController();
  TextEditingController newPINC = TextEditingController();
  TextEditingController otpC = TextEditingController();
  TextEditingController confirmPInC = TextEditingController();
  // TextEditingController oldPInC = TextEditingController();
  final formkey = GlobalKey<FormState>();

  bool isLoadingGif = false;
  bool isLoadingOTP = false;
  bool v = false;

  getOTP() async {
    // um.response.user.
    setState(() {
      isLoadingOTP = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/getWalletOtp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{}),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          setState(() {
            isLoadingOTP = false;
            v = true;
          });

          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          setState(() {
            isLoadingOTP = false;
          });

          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoadingOTP = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoadingOTP = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  savePin() async {
    // um.response.user.
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/changePin'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "userToken": await userM!.response!.user!.memberUniqueKey!,
            "pinOtp": "${otpC.text}",
            "oldPin": "${oldPInC.text}",
            "newPin": "${newPINC.text}",
            "confirmPin": "${confirmPInC.text}",
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          setState(() {
            isLoadingGif = false;
          });
          GoRouter.of(context).pop();
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          setState(() {
            isLoadingGif = false;
          });

          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoadingGif = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoadingGif = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(userM!.response!.user.!);
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 40),
      // backgroundColor: Color.fromARGB(255, 46, 45, 45),
      backgroundColor: kContainerBg,
      content: SingleChildScrollView(
        child: Container(
          width: 400,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    logo,
                    height: 100,
                    width: 150,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close))
                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                        loading: isLoadingOTP,
                        title: "GET OTP",
                        onPress: () {
                          getOTP();
                        },
                        width: double.infinity),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Visibility(
                        visible: v,
                        child: Form(
                          key: formkey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SettingTextField(
                                    title: "Enter OTP",
                                    controller: otpC,
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "should not be empty";
                                      }
                                      return null;
                                    },
                                    hintText: "enter OTP"),
                                SizedBox(
                                  height: 5,
                                ),
                                SettingTextField(
                                    title: "Old Pin",
                                    controller: oldPInC,
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "should not be empty";
                                      }
                                      return null;
                                    },
                                    hintText: "write old"),
                                SizedBox(
                                  height: 5,
                                ),
                                SettingTextField(
                                    title: "New Pin",
                                    controller: newPINC,
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "should not be empty";
                                      }
                                      return null;
                                    },
                                    hintText: "write new pin"),
                                SizedBox(
                                  height: 15,
                                ),
                                SettingTextField(
                                    title: "Confirm",
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "should not be empty";
                                      }
                                      return null;
                                    },
                                    controller: confirmPInC,
                                    hintText: "write pin again"),
                                SizedBox(
                                  height: 5,
                                ),
                                PrimaryButton(
                                    loading: isLoadingGif,
                                    title: "SUBMIT",
                                    onPress: () async {
                                      if (formkey.currentState!.validate()) {
                                        await savePin();
                                      }
                                    },
                                    width: double.infinity),
                                SizedBox(height: 5),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
