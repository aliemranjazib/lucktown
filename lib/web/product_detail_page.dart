import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/available_credits_model.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/product_model.dart';
import '../utils/components/custom_toast.dart';
import '../utils/constants/api_constants.dart';

String temp =
    "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Njg0MzY4MzQsImlzcyI6IiIsImV4cCI6MTY2ODUyMzIzNCwidXNlclRva2VuIjoiQ3ZyS0pnTWkxNm4zY3JMUTdDUnByUktZaWhmOWVwYm5wMjlET2NkM3RXNEZNeU5wSFlVUVg2VjdERVJwelVZNEREY3o4TzlwT2FSNFB4b2dPR2t5c2RQU05QeEpCMmdwQUJ0ZlRrbG9Sc01LeGZZOFR4a2xqME9DdEhuT1VLVjBrYUJtTkJhWk5zVzNlT3RVTmVsU00zclE2ek9Mb3hjc2dBQWFxUnNrZHF5Z2s1bElCUnJzVmJ1QlJjSHBNSU1UQUQ4YVVlTlciLCJ1c2VyVHlwZSI6Im1lbWJlciIsInVzZXJBdXRoIjoiNm1vQ0wxNFViNEloRFROVkhiUUc2QVI4U29WUmxKWXBIYnpGNTRGVG5HQVZleHZ2RnF0Ymx5Z0Z3RXZpOHNwckxQZzVvRU1QMTM0NUp0dTBkUnB6VmNXekd6bUMwRVVJWVp3ZllkM2VlWWRmSnZXc0NSVEJyTjRSSDg1R3BlMnQwNk1QM0FOc2lKM2Q4RXRTczJDSW9OelBVYUZ1ZFFtbE9BaGMyNUUwUGgyR2hOZExRZHd3ZW9OdDc5ck1Vb0hBbElPZDBSbE0ifQ.GuE4PycyHIqy5IdS8gbwJ6mh54i0eSqfrRvaX_wT5PQ";

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
  bool isLoadingClose = false;
  String? gameStatus = "";
  ProfileData profileData = ProfileData();
  AvailableCredits _availablecredit = AvailableCredits();
  bool isRunning = false;
  bool isLoadingGif = false;
  Map<String, dynamic> userInfo = {};

  String? url;
  List<String> topupMethods = [
    "Instant Top Up",
    "Top Up Bank Transfer",
    "Top Up USDT",
    "Withdraw"
  ];
  final headfontSize = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final rowfontSize = TextStyle(
    fontSize: 16,
  );

  // DateTime datetime = DateTime.now();
  String? date = DateFormat('dd/MM/yyyy').format(DateTime.now());

  Future<String> getToken() async {
    // getdata();
    return await jsonDecode(LuckySharedPef.getAuthToken())['response']
        ['authToken'];
  }

  showBoxDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          // title: Text("data"),
          title: Image.network(
            logo,
            width: 100,
            height: 50,
          ),
          children: [
            ...List.generate(
                topupMethods.length,
                (index) => Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: SelectButton(
                          title: topupMethods[index],
                          onPress: () {
                            print(topupMethods[index]);
                            if (topupMethods[index] == "Top Up USDT") {
                              // _launchInBrowser(url)
                              window.open(
                                  "https://lt888.live/Payment/cryptoPayment/${userInfo['response']['user']['member_unique_key']}",
                                  "fff");

                              // Navigator.pushNamed(context, web_topup_usdt_page);
                            }
                          },
                          width: double.infinity),
                    ))
          ],
        );
      },
    );
  }

  Future<AvailableCredits> getAvailableCredit() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}game/getAvailableCredit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await getToken(),

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"productId": widget.product!.productId, "pullCredit": "true"}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoadingGif = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            _availablecredit = AvailableCredits.fromJson(data);
          });
          print("in game ${_availablecredit.response!.inGameStatus}");

          setState(() {
            isLoadingGif = false;
            gameStatus = _availablecredit.response!.inGameStatus;
            print(gameStatus);
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

    return _availablecredit;
  }

  // Future<String> getTopUpMethods() async {
  //   try {
  //     final response1 = await http.post(
  //       Uri.parse('${memberBaseUrl}user/getTopupMethod'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         "Authorization": await getToken(),
  //         // 'Authorization':
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         "data": {
  //           "targetUniqueKey":
  //               "kVRT0VFaftUW19n3GpIquuXOwrRhz5y9N7R1m3BHcshbN0O9XU0BtyATyYsyeq85RJLpgB0TQSO5sDO7Mzevz5imKwrS81gDvRnabrrER8Qiyz8vqb5AlcKSEI4ztljuQA47TUYo0UjtTvk3SpEPkQwG7fO4xL0KhALq4L8B4lou4gc8iBmJo1GQQImjN7wrdhW6vmJK",
  //           "amount": "10"
  //         }
  //       }),
  //     );
  //     switch (response1.statusCode) {
  //       case 200:
  //         setState(() {
  //           print(response1.statusCode);
  //           isLoadingGif = true;
  //         });
  //         Map<String, dynamic> data = json.decode(response1.body);
  //         setState(() {
  //           // topupMethods = data['response']['list'];
  //           for (var element in data['response']['list']) {
  //             print(element['code']);
  //             topupMethods.add(element['code']);
  //           }
  //         });
  //         // print("topupMethods ${topupMethods}");
  //         // showBoxDialogue();
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return SimpleDialog(
  //               // title: Text("data"),
  //               title: Image.network(
  //                 logo,
  //                 width: 100,
  //                 height: 50,
  //               ),
  //               children: [
  //                 ...List.generate(
  //                     topupMethods.length,
  //                     (index) => Padding(
  //                           padding: const EdgeInsets.all(14.0),
  //                           child: SelectButton(
  //                               title: topupMethods[index],
  //                               onPress: () {},
  //                               width: double.infinity),
  //                         ))
  //               ],
  //               // height: 200,
  //               // width: 200,
  //               // decoration: BoxDecoration(
  //               //   color: Color(0xff231F20),
  //               // ),
  //               // child: Column(
  //               //   children: [
  //               //     ...List.generate(
  //               //         topupMethods.length,
  //               //         (index) => PrimaryButton(
  //               //             title: topupMethods[index], onPress: () {}, width: 50))
  //               //   ],
  //               // ),
  //             );
  //           },
  //         );

  //         setState(() {
  //           isLoadingGif = false;
  //         });

  //         break;
  //       default:
  //         final data = json.decode(response1.body);
  //         print(response1.statusCode);
  //         print(data);
  //         setState(() {
  //           isLoadingGif = false;
  //         });

  //         CustomToast.customToast(context, data['msg']);
  //       // CustomToast.customToast(context, "WENT WRONG");
  //     }
  //   } catch (e) {
  //     setState(() {
  //       isLoadingGif = false;
  //     });
  //     CustomToast.customToast(context, e.toString());
  //   }

  //   return "";
  // }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  Future<ProfileData> getProfileInfo() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/getProfileData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await getToken(),

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{"data": {}}),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoadingGif = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            profileData = ProfileData.fromJson(data);
          });
          print("coin ${profileData.response!.coinBalance}");

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

    return profileData;
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
          "Authorization": await getToken(),
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": widget.product!.productId,
            "amountTransfer": '0',
            'viewType': "web",
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
          print("ppp ${data['response']['gameDetails']['Url']}");
          // _launchInBrowser(Uri.parse(data['response']['gameDetails']['Url']));
          // String a = Uri.parse(data['response']['gameDetails']['Url']);
          window.open(data['response']['gameDetails']['Url'], 'foo');
          getAvailableCredit();
          setState(() {
            isLoading = false;
            isRunning = true;

            gameStatus = _availablecredit.response!.inGameStatus;
            url = data['response']['gameDetails']['Url'];
          });
          break;
        case 400:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoading = false;
          });

          CustomToast.customToast(context, data['msg']);
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

  closeGame() async {
    setState(() {
      isLoadingClose = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}game/closeGame'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await getToken(),
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": widget.product!.productId,
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoadingClose = true;
          });
          print(response1.statusCode);
          Map<String, dynamic> data = json.decode(response1.body);
          // CustomToast.customToast(context, data['msg']);
          // window.close();
          CustomToast.customToast(context, data['msg']);
          // print("ppp ${data['response']['gameDetails']['Url']}");
          // var other = window.open(url!, 'foo');
// Closes other window, as it is script-closeable.
          // other.close();
          getAvailableCredit();

          // print(other.closed);
          setState(() {
            isLoadingClose = false;
            isRunning = false;
            gameStatus = _availablecredit.response!.inGameStatus;
          });
          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoadingClose = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoadingClose = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  Future<String> getToken1() async {
    // getdata();
    return await LuckySharedPef.getAuthToken();
  }

  Future getAllData() async {
    // getdata();
    await getToken1().then((value) {
      setState(() {
        // res.UserSessionModel um= value;
        // print(value[''])
        userInfo = jsonDecode(value);
        print(userInfo['response']['user']['member_username']);
        // ress.Response m = ress.Response.fromJson(userInfo['response']);
        // print("uuuu ${m}");
        // print(jsonDecode(value));
        //  print(uu.msg);
        // print(uu.msg);
        // print(j['msg']);
      });
    });
  }

  @override
  void initState() {
    // getToken();
    // playGame();
    getAllData();
    getProfileInfo();
    getAvailableCredit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: (profileData.response == null &&
              _availablecredit.response == null &&
              widget.product!.productImageUrl == null &&
              widget.product!.productName == null)
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
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
                              width: 101,
                              height: 31,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      widget.product!.productImageUrl ??
                          "https://cdn.sanity.io/images/0vv8moc6/dermatologytimes/d198c3b708a35d9adcfa0435ee12fe454db49662-640x400.png",
                      width: double.infinity,
                      height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 301
                          : 131,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        Expanded(
                            // flex: 4,
                            child: Container(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("${widget.product!.productName!}",
                                      style: GoogleFonts.roboto(
                                          fontSize:
                                              ResponsiveWrapper.of(context)
                                                      .isLargerThan(MOBILE)
                                                  ? 32
                                                  : 18))),
                              ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                                  ? Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          // height: 100,
                                          // width: 100,
                                          child: Column(
                                            children: [
                                              availableTransfer(
                                                  title: "Available Transfer",
                                                  value:
                                                      "${_availablecredit.response!.avaiableTransfer}"),
                                              availableTransfer(
                                                  title: "Available Coin",
                                                  value:
                                                      "${_availablecredit.response!.coinAvailable}"),
                                              availableTransfer(
                                                  title: "Total",
                                                  value:
                                                      "${_availablecredit.response!.productDetail!.memberProductTotalBalance}"),
                                              availableTransfer(
                                                  title: "Available Transfer",
                                                  value:
                                                      "${_availablecredit.response!.avaiableTransfer}"),
                                            ],
                                          ),
                                          // color: Colors.amber,
                                        )),
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          showBoxDialogue();
                                                          // showBoxDialogue();
                                                        },
                                                        child: Container(
                                                          // width: 100,
                                                          // height: 100,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff292929),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(38.0),
                                                            child: Row(
                                                              children: [
                                                                Image.asset(
                                                                    topup),
                                                                silverGradient(
                                                                    'Top Up',
                                                                    16),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        // width: 100,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xff292929),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(38.0),
                                                          child: Row(
                                                            children: [
                                                              Image.asset(
                                                                  transaction),
                                                              silverGradient(
                                                                  'Game Transaction',
                                                                  16),
                                                              Text('')
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 426,
                                                  height: 54,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Color(0xffEEF2F5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "Amount (THB)    ${_availablecredit.response!.productDetail!.memberProductTotalBalance}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                                Container(
                                                  width: 426,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "${_availablecredit.response!.ptsCopyWriting}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Commission: ${_availablecredit.response!.selfCommission}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Today stake: ${_availablecredit.response!.todayStake}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Yesterday stake: ${_availablecredit.response!.yesterdayStake}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Container(
                                          // height: 100,
                                          // width: 100,
                                          child: Column(
                                            children: [
                                              availableTransfer(
                                                  title: "Available Transfer",
                                                  value:
                                                      "${_availablecredit.response!.avaiableTransfer}"),
                                              availableTransfer(
                                                  title: "Available Coin",
                                                  value:
                                                      "${_availablecredit.response!.coinAvailable}"),
                                              availableTransfer(
                                                  title: "Total",
                                                  value:
                                                      "${_availablecredit.response!.productDetail!.memberProductTotalBalance}"),
                                              availableTransfer(
                                                  title: "Available Transfer",
                                                  value:
                                                      "${_availablecredit.response!.avaiableTransfer}"),
                                            ],
                                          ),
                                          // color: Colors.amber,
                                        ),
                                        Column(
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          showBoxDialogue();
                                                        },
                                                        child: Container(
                                                          // width: 154,
                                                          alignment:
                                                              Alignment.center,
                                                          height: 100,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xff292929),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                  topup),
                                                              SizedBox(
                                                                  width: 10),
                                                              silverGradientRobto(
                                                                  'Top Up',
                                                                  ResponsiveWrapper.of(
                                                                              context)
                                                                          .isLargerThan(
                                                                              MOBILE)
                                                                      ? 16
                                                                      : 14,
                                                                  FontWeight
                                                                      .normal),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Expanded(
                                                      child: Container(
                                                        // width: 170,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                            color: Color(
                                                                0xff292929),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Image.asset(
                                                                  transaction),
                                                              SizedBox(
                                                                  width: 10),
                                                              silverGradientRobto(
                                                                  'Game Transaction',
                                                                  ResponsiveWrapper.of(
                                                                              context)
                                                                          .isLargerThan(
                                                                              MOBILE)
                                                                      ? 16
                                                                      : 14,
                                                                  FontWeight
                                                                      .normal),
                                                              Text('')
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  width: double.infinity,
                                                  height: 60,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    color: Color(0xffEEF2F5),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                        "Amount (THB)    ${_availablecredit.response!.productDetail!.memberProductTotalBalance}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black)),
                                                  ),
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  // width: 426,
                                                  child: Column(
                                                    children: [
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "${_availablecredit.response!.ptsCopyWriting}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Commission: ${_availablecredit.response!.selfCommission}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              "Today stake: ${_availablecredit.response!.todayStake}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Yesterday stake: ${_availablecredit.response!.yesterdayStake}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                        ],
                                                      ),
                                                      SizedBox(height: 10),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                              GameDetailPageButton(
                                  title: gameStatus == "" ? "Start" : "Close",
                                  onPress: () {
                                    setState(() {
                                      // gameStatus == "" ? playGame() : closeGame();
                                      if (gameStatus == "") {
                                        playGame();
                                      } else if (gameStatus == "inGame") {
                                        closeGame();
                                      }
                                    });
                                    // getAvailableCredit();
                                  },
                                  width: double.infinity),
                              SizedBox(height: 20),
                              ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("所有投注记录 / All Bets Record",
                                            style: GoogleFonts.roboto(
                                              fontSize: 24,
                                            )),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today),
                                            TextButton(
                                                onPressed: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: DateTime
                                                              .now(), //get today's date
                                                          firstDate: DateTime(
                                                              2000), //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101));
                                                  if (pickedDate != null) {
                                                    print(
                                                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                    String formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                    print(
                                                        formattedDate); //formatted date output using intl package =>  2022-07-04
                                                    //You can format date as per your need

                                                    setState(() {
                                                      date =
                                                          formattedDate; //set foratted date to TextField value.
                                                    });
                                                  } else {
                                                    print(
                                                        "Date is not selected");
                                                  }
                                                },
                                                child: Text(
                                                  "$date",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("所有投注记录 / All Bets Record",
                                            style: GoogleFonts.roboto(
                                              fontSize: 18,
                                            )),
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_today,
                                                size: 14),
                                            TextButton(
                                                onPressed: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: DateTime
                                                              .now(), //get today's date
                                                          firstDate: DateTime(
                                                              2000), //DateTime.now() - not to allow to choose before today.
                                                          lastDate:
                                                              DateTime(2101));
                                                  if (pickedDate != null) {
                                                    print(
                                                        pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                                    String formattedDate =
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(
                                                                pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                                    print(
                                                        formattedDate); //formatted date output using intl package =>  2022-07-04
                                                    //You can format date as per your need

                                                    setState(() {
                                                      date =
                                                          formattedDate; //set foratted date to TextField value.
                                                    });
                                                  } else {
                                                    print(
                                                        "Date is not selected");
                                                  }
                                                },
                                                child: Text(
                                                  "$date",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                              SizedBox(height: 15),
                              profileData.response == null
                                  ? Center(child: CircularProgressIndicator())
                                  : ResponsiveWrapper.of(context)
                                          .isLargerThan(MOBILE)
                                      ? Container(
                                          // constraints: BoxConstraints(minWidth: 100),
                                          color: Color(0xff212631),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: profileData
                                                        .response!
                                                        .walletTransactions!
                                                        .isEmpty
                                                    ? Center(
                                                        child: Text("no data"))
                                                    : isLoadingGif
                                                        ? Container()
                                                        : DataTable(
                                                            onSelectAll: (b) {},
                                                            sortColumnIndex: 0,
                                                            // columnSpacing: 180,
                                                            sortAscending: true,
                                                            columns: <
                                                                DataColumn>[
                                                              DataColumn(
                                                                  label: Expanded(
                                                                      child: Text(
                                                                          "Date & Time",
                                                                          style:
                                                                              headfontSize)),
                                                                  tooltip:
                                                                      "To Display date and time"),
                                                              DataColumn(
                                                                  label: Text(
                                                                      "Username",
                                                                      style:
                                                                          headfontSize),
                                                                  tooltip:
                                                                      "To Display user name"),
                                                              DataColumn(
                                                                  label: Text(
                                                                      "ID",
                                                                      style:
                                                                          headfontSize),
                                                                  tooltip:
                                                                      "display id"),
                                                              DataColumn(
                                                                  label: Text(
                                                                      "Bet / Transfer",
                                                                      style:
                                                                          headfontSize),
                                                                  tooltip:
                                                                      "to display bet/transfer"),
                                                              DataColumn(
                                                                  label: Text(
                                                                      "Total Win",
                                                                      style:
                                                                          headfontSize),
                                                                  tooltip:
                                                                      "to display total win"),
                                                            ],
                                                            rows: profileData
                                                                .response!
                                                                .walletTransactions!
                                                                .map(
                                                                    (e) =>
                                                                        DataRow(
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(e.transactionCreatedDatetime!),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.transactionOwner!),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.transactionId!),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.transactionAmount!),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.transactionAmount!),
                                                                            ),
                                                                          ],
                                                                        ))
                                                                .toList()),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff212631)
                                                .withOpacity(0.5),
                                          ),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: profileData.response!
                                                .walletTransactions!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final pdata = profileData
                                                  .response!
                                                  .walletTransactions![index];
                                              return ListTile(
                                                leading: CircleAvatar(
                                                  backgroundColor: Colors.blue,
                                                  // radius: 20,
                                                  minRadius: 30,
                                                  maxRadius: 30,
                                                  child: Text(""),
                                                ),
                                                title: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8),
                                                  child: Text(
                                                    pdata.transactionOwner!,
                                                    style: GoogleFonts.roboto(),
                                                  ),
                                                ),
                                                subtitle: Container(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${pdata.transactionCreatedDatetime}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 0,
                                                                right: 10,
                                                                top: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Bet/Transfer   :   ${pdata.transactionAmount}",
                                                                  style: GoogleFonts
                                                                      .roboto(
                                                                          fontSize:
                                                                              12),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Image.asset(
                                                                  Hnadcoin,
                                                                  width: 12,
                                                                  height: 11,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Win    :   ${pdata.transactionAmount}",
                                                                  style: GoogleFonts
                                                                      .roboto(
                                                                          fontSize:
                                                                              12),
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Image.asset(
                                                                  Hnadcoin,
                                                                  width: 12,
                                                                  height: 11,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                            ],
                          ),
                        )),
                        // Expanded(
                        //     child: Column(
                        //   children: [
                        //     // Text(
                        //     //   "你可能会喜欢 You May Like",
                        //     //   style: TextStyle(color: Colors.white, fontSize: 20),
                        //     // ),
                        //     Container(
                        //       height: 300,
                        //       decoration: BoxDecoration(
                        //         color: Colors.black,
                        //         // color: Color(0xff292929)
                        //       ),
                        //     ),
                        //   ],
                        // ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Align availableTransfer({String? title, String? value}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            Expanded(child: Text("$title")),
            SizedBox(width: 30, child: Text(":")),
            Expanded(
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("${value ?? "0"}"))),
          ],
        ),
        // child: Text("$title   :   ${value ?? "0"}",
        //     style: GoogleFonts.roboto(fontSize: 16)),
      ),
    );
  }
}
