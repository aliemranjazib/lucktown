import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../web_menue/Drawer.dart';

class CustomDialog extends StatefulWidget {
  final String? name;
  final String? amount;
  final String memberUniqueKey;
  final String? avatar;

  const CustomDialog(
      {Key? key,
      this.avatar,
      this.name,
      this.amount,
      required this.memberUniqueKey})
      : super(key: key);

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  TextEditingController amountController = TextEditingController();
  bool isAdding = false;

  @override
  void initState() {
    // amountController.text = widget.amount!;
    super.initState();
  }

  transfer() async {
    setState(() {
      isAdding = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/transfer'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "targetUniqueKey": widget.memberUniqueKey,
            "amount": amountController.text,
            "language": "EN",
            "currency": "myr"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            isAdding = false;
          });
          // print("${sm.msg} ${response1.statusCode}");
          CustomToast.customToast(context, "${data['msg']}");

          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");

          setState(() {
            isAdding = false;
          });

          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, "${data['msg']}");

          setState(() {
            isAdding = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isAdding = false;
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
            Container(
              width: 100.0,
              height: 100.0,
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                image: new DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: NetworkImage(widget.avatar!),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${widget.name}",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "${widget.amount}",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  "Enter Amount",
                  style: TextStyle(
                    color: Color(0xffFCD877),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: amountController,
                style: TextStyle(
                  color: Colors.black,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "should not be empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "enter amount",
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.all(10),
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PrimaryButton(
                title: "Continue",
                onPress: () {
                  transfer();
                },
                width: double.infinity),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ],
    );
  }
}
