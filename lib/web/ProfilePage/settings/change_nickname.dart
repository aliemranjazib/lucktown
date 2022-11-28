import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/setting_page.dart';
import 'package:http/http.dart' as http;

import '../../../utils/components/custom_toast.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/contants.dart';
import '../../../web_menue/Drawer.dart';

class ChangeNickeName extends StatefulWidget {
  @override
  State<ChangeNickeName> createState() => _ChangeNickeNameState();
}

class _ChangeNickeNameState extends State<ChangeNickeName> {
  TextEditingController controller = TextEditingController();

  bool isLoadingGif = false;

  saveNick() async {
    // um.response.user.
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/changeNickName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"nickName": controller.text}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);

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

  @override
  Widget build(BuildContext context) {
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
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SettingTextField(
                title: "change nick name",
                controller: controller,
                hintText: "write nick name"),
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
                    saveNick();
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
