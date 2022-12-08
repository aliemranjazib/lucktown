import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../app_routes/app_routes.dart';
import '../../utils/constants/api_constants.dart';

class AllGameTransactionPage extends StatefulWidget {
  @override
  State<AllGameTransactionPage> createState() => _AllGameTransactionPageState();
}

class _AllGameTransactionPageState extends State<AllGameTransactionPage> {
  bool isLoading = false;

  getAvailableCredit() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/allGameTransaction'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"productId": "alll", "pullCredit": "true"}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            // _availablecredit = AvailableCredits.fromJson(data);
          });
          // print("in game ${_availablecredit.response!.inGameStatus}");

          setState(() {
            isLoading = false;
          });

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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            topbackbutton(context, RouteCon.home_Page),
            Expanded(child: Center(child: Text("NO TRANSACTION")))
          ],
        ),
      ),
    );
  }
}

Row topbackbutton(BuildContext context, String path) {
  return Row(
    children: [
      Container(
        height: 50,
        color: Colors.black,
        child: Row(
          children: [
            BackButton(
              onPressed: () {
                context.pop();

                // Navigator.pushNamed(context, path);
                // Navigator.pop(context);
              },
            ),
            ResponsiveVisibility(
                visible: true,
                hiddenWhen: const [Condition.smallerThan(name: TABLET)],
                child: Text("Back"))
          ],
        ),
      ),
      Expanded(
        child: Center(
          child: Image.asset(
            logo,
            width:
                ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 202 : 101,
            height:
                ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 62 : 31,
          ),
        ),
      ),
    ],
  );
}
