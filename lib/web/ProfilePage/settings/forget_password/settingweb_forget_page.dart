import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/ecotextfield.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/web_forget_page/forget_otp_page.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/components/gradient_text.dart';
import '../../../../utils/constants/api_constants.dart';

class SeetingWebForgetPage extends StatefulWidget {
  // String? image;
  // String? text;

  @override
  State<SeetingWebForgetPage> createState() => _SeetingWebForgetPageState();
}

class _SeetingWebForgetPageState extends State<SeetingWebForgetPage> {
  int index = 0;
  bool line_visible1 = false;
  bool line_visible = true;
  String? isoCode;

  // final TextEditingController phoneController = TextEditingController();
  String? selectedValue;
  TextEditingController number = TextEditingController();
  TextEditingController userId = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool isLoading = false;

  getOtp() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/forgotPassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "phone": "${number.text}",
            "username": "${userId.text}",
            "countryCode": "$isoCode"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

          context.goNamed(RouteCon.setting_forget_otp,
              params: {"userToken": "${data['response']['userToken']}"});
          setState(() {
            isLoading = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          break;
        case 514:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          // Navigator.pushNamed(context, web_scaffold_page);
          break;
        case 500:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
          // Navigator.pushNamed(context, web_scaffold_page);
          break;
        // break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoading = false;
          });
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
      setState(() {
        isLoading = false;
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
                            BackButton(
                              onPressed: () {
                                context.goNamed(RouteCon.profile_page);
                                // context.pop();
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

                        SizedBox(height: 50),

                        SizedBox(height: 70),

                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Form(
                              key: formkey,
                              child: Column(
                                children: [
                                  // edit(),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 0, vertical: 0),
                                        child: silverGradient(
                                            'Recover Password',
                                            ResponsiveWrapper.of(context)
                                                    .isLargerThan(MOBILE)
                                                ? 28
                                                : 16),
                                      )),
                                  SizedBox(height: 50),

                                  EcoMobileTextField(
                                    upperText: "Mobile Number",
                                    controller: number,
                                    isoCode: isoCode,
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "phone number is empty";
                                      }
                                      return null;
                                    },
                                    onChanged: (p) {
                                      print("okk ${p!.dialCode}");
                                      isoCode = p.dialCode;
                                    },
                                  ),
                                  SizedBox(height: 50),
                                  EcoTextField(
                                    controller: userId,
                                    validate: (p0) {
                                      if (p0!.isEmpty) {
                                        return "user Id is empty";
                                      }
                                      return null;
                                    },
                                    upperText: "Your ID",
                                    hinttext: 'enter userId',
                                    preIcons: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(userIcon),
                                    ),
                                  ),
                                  SizedBox(height: 30),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    child: PrimaryButton(
                                      title: "Continue",
                                      onPress: () async {
                                        await getOtp();
                                        // if (formkey.currentState!.validate()) {
                                        //   print(number.text);
                                        //   print(userId.text);
                                        //   // getToken();

                                        // }
                                      },
                                      width: double.infinity,
                                    ),
                                  ),

                                  SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        )

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
}
