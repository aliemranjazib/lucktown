import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page/forget_otp_page.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;
import '../../utils/components/ecotextfield.dart';
import '../../utils/constants/contants.dart';

class SetNewPasswordPage extends StatefulWidget {
  final TokenAndOtp? tokenAndOtp;
  const SetNewPasswordPage({super.key, this.tokenAndOtp});

  @override
  State<SetNewPasswordPage> createState() => _SetNewPasswordPageState();
}

class _SetNewPasswordPageState extends State<SetNewPasswordPage> {
  bool isLoading = false;
  bool isPasswordShown = false;
  String? isoCode;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  saveData() async {
    if (_formKey.currentState!.validate()) {
      // print("OKKKKK");
      if (passwordController.text != confirmPasswordController.text) {
        CustomToast.customToast(
            context, "password and retype password is not matched");
      } else {
        await setNewPassword();
      }
    }
  }

  setNewPassword() async {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    // print("need $te");
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/changePasswordNoAuth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "userToken": "${widget.tokenAndOtp!.userToken}",
            "passwordOtp": "${widget.tokenAndOtp!.otp}",
            "newPassword": "${passwordController.text}",
            "newConfirmPassword": "${confirmPasswordController.text}"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          context.goNamed(RouteCon.home_Page);

          setState(() {
            isLoading = false;
          });
          print(response1.statusCode);
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          setState(() {
            isLoading = false;
          });
          print(response1.statusCode);
          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoading = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.tokenAndOtp!.userToken);
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
              padding: const EdgeInsets.only(top: 0, right: 10, left: 10),
              child: SingleChildScrollView(
                child: Container(
                  // height: double.infinity,
                  color: bgColor,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            onPressed: () {
                              context.pop();
                            },
                          ),
                          // SizedBox(width: 10),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                logo,
                                height: 60,
                                width: 195,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 70),

                      SizedBox(height: 50),
                      signUp(context),
                      SizedBox(height: 70),

                      // select_country.map((e) => Text(e.text)).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signUp(BuildContext context) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    // RegExp reguser = RegExp(r'^[a-zA-Z0-9]+$');
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            SizedBox(height: 30),
            EcoTextField(
              isPassword: false,
              upperText: "New Password",
              controller: passwordController,
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
            passwordConditions(Icons.done, "contains at least 8 characters"),
            passwordConditions(
                Icons.done, "contains both lowercase and uppercase letters"),
            passwordConditions(
                Icons.done, "contains at least one number (0-9) or a symbol"),
            passwordConditions(
                Icons.done, "does not contain your email address"),
            SizedBox(height: 30),
            EcoTextField(
              isPassword: false,
              upperText: "Confirm Password",
              controller: confirmPasswordController,
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
            SizedBox(height: 30),
            Row(
              children: [
                Checkbox(
                    activeColor: primaryColor, value: true, onChanged: (v) {}),
              ],
            ),
            PrimaryButton(
                title: "Submit",
                width: double.infinity,
                loading: isLoading,
                onPress: () async {
                  await saveData();
                }),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget passwordConditions(IconData icon, String text) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 70, vertical: 0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          Expanded(
            child: Text(
              text,
              style:
                  TextStyle(color: Color(0xFFEEF2F5), fontFamily: gotham_light),
            ),
          ),
        ],
      ),
    );
  }
}
