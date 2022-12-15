import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/phone_field.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/ProfilePage.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/settings/setting_page.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

import '../../../utils/components/custom_toast.dart';
import '../../../utils/components/ecotextfield.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/contants.dart';
import '../../../web_menue/Drawer.dart';

class ChangePhoneNumber extends StatefulWidget {
  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController controller = TextEditingController();
  // TextEditingController passwordOtpC = TextEditingController();
  String? otpCode;
  TextEditingController oldpasswordC = TextEditingController();
  TextEditingController newpasswordC = TextEditingController();
  TextEditingController conformpasswordC = TextEditingController();
  String? isoCode;

  bool isLoadingGif = false;

  getOtp() async {
    // um.response.user.
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/getChangePhoneOtp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "phone": "${phoneController.text}",
            "password": "${controller.text}",
            "countryCode": "$isoCode"
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
          showDialog(
              context: context, builder: (context) => showPasswordChangeBox());

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

  changePhone() async {
    // um.response.user.
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/changePassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "Authorization": await userM!.response!.user!.memberUniqueKey!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "userToken": await userM!.response!.user!.memberUniqueKey!,
            "passwordOtp": "${otpCode}",
            "oldPassword": "${oldpasswordC.text}",
            "newPassword": "${newpasswordC.text}",
            "newConfirmPassword": "${conformpasswordC.text}"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          GoRouter.of(context).goNamed(RouteCon.home_Page);
          setState(() {
            isLoadingGif = false;
          });

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

  showPasswordChangeBox() {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 40),
      // backgroundColor: Color.fromARGB(255, 46, 45, 45),
      backgroundColor: kContainerBg,
      actions: [
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
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            Text("change your password here"),
            SizedBox(
              height: 20,
            ),
            OtpTextField(
              numberOfFields: 6,
              borderColor: Color(0xFFBD8E37),
              focusedBorderColor: Color(0xFFBD8E37),
              enabledBorderColor: Color(0xFFBD8E37),
              cursorColor: Color(0xFFBD8E37),
              margin: const EdgeInsets.all(0),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            EcoTextField(
              isPassword: true,
              upperText: "old password",
              controller: oldpasswordC,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              postIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(eye_open),
              ),
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(unlockIcon),
              ),
            ),
            EcoTextField(
              isPassword: true,
              upperText: "new Password",
              controller: newpasswordC,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              postIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(eye_open),
              ),
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(unlockIcon),
              ),
            ),
            EcoTextField(
              isPassword: true,
              upperText: "Confirm Password",
              controller: conformpasswordC,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              postIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(eye_open),
              ),
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(unlockIcon),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            PrimaryButton(
                loading: isLoadingGif,
                title: "SUBMIT",
                onPress: () {
                  if (controller.text.isEmpty) {
                    CustomToast.customToast(context, "fill something");
                  } else {
                    changePhone();
                  }
                },
                width: double.infinity),
            SizedBox(height: 70),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(userM!.response!.user.!);
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(horizontal: 40),
      // backgroundColor: Color.fromARGB(255, 46, 45, 45),
      backgroundColor: kContainerBg,
      actions: [
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
        Column(
          children: [
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 30,
            ),
            EcoMobileTextField(
              upperText: "Mobile Number",
              controller: phoneController,
              isoCode: isoCode,
              onChanged: (p) {
                print("okk ${p!.dialCode}");
                isoCode = p.dialCode;
              },
            ),
            SizedBox(
              height: 20,
            ),
            EcoTextField(
              isPassword: true,
              upperText: "Confirm Password",
              controller: controller,
              validate: (value) {
                if (value!.isEmpty) {
                  return 'Please enter password';
                } else {
                  if (!regex.hasMatch(value)) {
                    return 'Enter valid password';
                  } else {
                    return null;
                  }
                }
              },
              postIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(eye_open),
              ),
              preIcons: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(unlockIcon),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            PrimaryButton(
                loading: isLoadingGif,
                title: "SUBMIT",
                onPress: () {
                  if (controller.text.isEmpty) {
                    CustomToast.customToast(
                        context, "nick name must be filled");
                  } else {
                    getOtp();
                  }
                },
                width: double.infinity),
            SizedBox(height: 70),
          ],
        ),
      ],
    );
  }
}
