import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

import '../../utils/constants/api_constants.dart';
import '../../utils/constants/contants.dart';
import '../product_detail_page/all_game_transaction.dart';

class CurrencyExchangePage extends StatefulWidget {
  @override
  State<CurrencyExchangePage> createState() => _CurrencyExchangePageState();
}

class _CurrencyExchangePageState extends State<CurrencyExchangePage> {
  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();
  bool isLoadingGif = false;

  String temp =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2NjkyMTU0MTcsImlzcyI6IiIsImV4cCI6MTY2OTMwMTgxNywidXNlclRva2VuIjoiQ3ZyS0pnTWkxNm4zY3JMUTdDUnByUktZaWhmOWVwYm5wMjlET2NkM3RXNEZNeU5wSFlVUVg2VjdERVJwelVZNEREY3o4TzlwT2FSNFB4b2dPR2t5c2RQU05QeEpCMmdwQUJ0ZlRrbG9Sc01LeGZZOFR4a2xqME9DdEhuT1VLVjBrYUJtTkJhWk5zVzNlT3RVTmVsU00zclE2ek9Mb3hjc2dBQWFxUnNrZHF5Z2s1bElCUnJzVmJ1QlJjSHBNSU1UQUQ4YVVlTlciLCJ1c2VyVHlwZSI6Im1lbWJlciIsInVzZXJBdXRoIjoiUkdFckx2V1pyRXNpc2hlVmc4WUx0STRRVUJhaUVNNTJuVkxKTGpmcFV3UDY1ZU5nNWxIN04zcTJoVTVlcmFhRm9RQ1FzOWtNSk5Eeno4UG4zRkVvTlkyQzJLZTlNSnY5QnhBbkxXbVg1b3VRNlFJT2VHemg2d08yMWZKdHNzQ3N5YzY3cHZlWlF3UlZWMnlna01VeXVwd1dvYlM4ZVFta3NudHFiODFJQzUxc3FaOXFFenRFZW9RMTg0N2p6ZlJpNmdYbFdWcGgifQ.0diMQYeOGUqnPV10u6kN5j-IODL4tNZIjvvsHEHOfo4";

  currencyExchange() async {
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}currency/exchange'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"from": "MYR", "to": "THB", "amount": fromController.text}
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
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  color: Colors.black,
                  child: Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.pushNamed(context, web_profile_page);
                        },
                      ),
                      ResponsiveVisibility(
                          visible: true,
                          hiddenWhen: const [
                            Condition.smallerThan(name: TABLET)
                          ],
                          child: Text("Back"))
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Image.asset(
                      logo,
                      width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 202
                          : 101,
                      height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 62
                          : 31,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: silverGradientRobto(
                          "Currency Exchange", 24, FontWeight.normal)),
                  SizedBox(height: 40),
                  CurrencyTextField(
                    title: "MYR",
                    controller: fromController,
                    hintText: "Amount (THB)    0.00",
                    validate: (p0) {
                      return "";
                    },
                  ),
                  SizedBox(height: 40),
                  CurrencyTextField(
                    title: "THB",
                    controller: toController,
                    hintText: "Amount (THB)    0.00",
                    validate: (p0) {
                      return "";
                    },
                  ),
                  // Spacer(),
                  SizedBox(height: 40),
                  silverGradientRobto("Exchange Rate", 20, FontWeight.normal),
                  SizedBox(height: 10),
                  Text("MYR 1  = THB 8.04"),
                  SizedBox(height: 40),

                  PrimaryButton(
                      title: "CONTINUE",
                      onPress: () {
                        currencyExchange();
                      },
                      loading: isLoadingGif,
                      width: double.infinity),
                ],
              ),
            )
          ],
        ));
  }
}

class CurrencyTextField extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validate;
  const CurrencyTextField({
    Key? key,
    required this.title,
    required this.controller,
    this.validate,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: silverGradientRobto("$title", 16, FontWeight.normal)),
        SizedBox(height: 10),
        TextFormField(
          controller: controller,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: "$hintText",
            hintStyle: TextStyle(color: Colors.black),
            fillColor: Color(0xffEEF2F5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffEEF2F5), width: 2.0),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ],
    );
  }
}
