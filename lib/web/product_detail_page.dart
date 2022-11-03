import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/product_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/web_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../utils/components/custom_toast.dart';
import '../utils/constants/api_constants.dart';

class ProductDetailPage extends StatefulWidget {
  Products? product;
  ProductDetailPage({
    this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoading = false;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  playGame() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}game/launch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": homeAuthToken,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": widget.product!.productId,
            "amountTransfer": '0',
            'viewType': "mobile",
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoading = true;
          });
          print(response1.statusCode);
          Map<String, dynamic> data = json.decode(response1.body);
          // CustomToast.customToast(context, data['msg']);
          CustomToast.customToast(
              context, data['response']['gameDetails']['Url']);
          print("ppp ${data['response']['gameDetails']['Url']}");
          _launchInBrowser(Uri.parse(data['response']['gameDetails']['Url']));
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
            Container(
              height: 50,
              color: Colors.black,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.navigate_before)),
                  Text("Back")
                ],
              ),
            ),
            Image.asset(detail_page_banner),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.product!.productName!,
                                  style: GoogleFonts.roboto(fontSize: 32))),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.product!.productCategory!,
                                  style: GoogleFonts.roboto(fontSize: 32))),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // width: 100,
                                  // height: 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xff292929),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(38.0),
                                    child: Row(
                                      children: [
                                        Image.asset(topup),
                                        silverGradient('Top Up', 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  // width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Color(0xff292929),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(38.0),
                                    child: Row(
                                      children: [
                                        Image.asset(transaction),
                                        silverGradient('Game Transaction', 16),
                                        Text('')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          PrimaryButton(
                              title: "Start",
                              onPress: () {
                                playGame();
                              },
                              width: double.infinity),
                        ],
                      ),
                    )),
                Expanded(
                    child: Container(
                  height: 300,
                  decoration: BoxDecoration(color: Color(0xff292929)),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
