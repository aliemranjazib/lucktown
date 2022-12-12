import 'dart:convert';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/available_credits_model.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/product_model.dart';
import '../../utils/components/custom_toast.dart';
import '../../utils/constants/api_constants.dart';
import '../ProfilePage/checktopup/checktopupmodel.dart';
import '../transactions/all_game_transaction_model.dart';

class ProductDetailPage extends StatefulWidget {
  ProductsModelResponseProducts? product;
  ProductDetailPage({
    this.product,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLoadingTransactions = false;
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

  get kContainerBg => null;

  // Future<String> getToken() async {
  //   // getdata();
  //   return await jsonDecode(LuckySharedPef.getAuthToken())['response']
  //       ['authToken'];
  // }

  Future<AvailableCredits> getAvailableCredit() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}game/getAvailableCredit'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": widget.product!.product_id,
            "pullCredit": "true"
          }
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

  AllGameTransactionModel? allgames;
  Future<AllGameTransactionModel> allgameTransactions() async {
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/allGameTransaction'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": "all",
            "fromDate": "2020-07-25",
            "toDate": "2022-07-31",
            "page": 1,
            "pageSize": 1
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isLoadingTransactions = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            allgames = AllGameTransactionModel.fromJson(data);
            // profileData.response.transactions.first.tr
            // _availablecredit = AvailableCredits.fromJson(data);
          });
          // print("in game ${_availablecredit.response!.inGameStatus}");

          setState(() {
            isLoadingTransactions = false;
          });

          break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          setState(() {
            isLoadingTransactions = false;
          });

          CustomToast.customToast(context, data['msg']);
        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isLoadingTransactions = false;
      });
      CustomToast.customToast(context, e.toString());
    }
    return allgames!;
  }

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
          "Authorization": await um!.response!.authToken!,

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
          print("coin detail ${profileData.response!.gameTransactions}");

          setState(() {
            isLoadingGif = false;
          });

          break;
        case 514:
          // Map<String, dynamic> data = json.decode(response1.body);
          // print(
          //     "coin ${profileData.response!.accounts!.first!.accountName ?? "null"}");
          LuckySharedPef.removeAuthToken();
          LuckySharedPef.removeOnlyAuthToken();
          GoRouter.of(context).goNamed(RouteCon.home_Page);
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

  Future<PendtingTopUpModel> checkTopUp(context) async {
    PendtingTopUpModel? bm;
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}user/checkTopup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{"data": {}}),
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = await json.decode(response.body);
          bm = PendtingTopUpModel.fromJson(data);
          print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
          showBoxDialogue();
          break;
        case 201:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
          bm = PendtingTopUpModel.fromJson(data);
          GoRouter.of(context).goNamed(RouteCon.pending_top_up, extra: bm);
          print("201");
          break;
        case 400:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);

          print("OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
          // sm = SelectCountryModel.fromJson(item);
          break;
        default:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);
      }
    } catch (e) {
      print(e);

      CustomToast.customToast(context, e.toString());
    }
    return bm!;
  }

  showBoxDialogue() {
    return showDialog(
      context: context,
      builder: (context) {
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
                ...List.generate(
                    topupMethods.length,
                    (index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: PrimaryButton(
                              title: topupMethods[index],
                              onPress: () {
                                Navigator.pop(context);
                                print(topupMethods[index]);
                                if (topupMethods[index] == "Top Up USDT") {
                                  // Navigator.pop(context);
                                  _launchInBrowser(Uri.parse(
                                      "https://lt888.live/Payment/cryptoPayment/${um!.response!.user!.memberUniqueKey}"));
                                } else if (topupMethods[index] ==
                                    "Top Up Bank Transfer") {
                                  context
                                      .pushNamed(RouteCon.bank_topup_main_page);
                                } else if (topupMethods[index] == "Withdraw") {
                                  context.pushNamed(RouteCon.withdraw_page);
                                } else if (topupMethods[index] ==
                                    "Instant Top Up") {
                                  // Navigator.pop(context);

                                  if (um!.response!.user!.countryCode ==
                                      "THB") {
                                    _launchInBrowser(Uri.parse(
                                        "https://member.luckytown.online//Payment/topupTHB/${um!.response!.user!.memberUniqueKey}"));
                                  } else if (um!.response!.user!.countryCode ==
                                      "MYR") {
                                    _launchInBrowser(Uri.parse(
                                        "https://member.luckytown.online//Payment/directPayment/${um!.response!.user!.memberUniqueKey}"));
                                  }
                                }
                              },
                              width: double.infinity),
                        )),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  playGame() async {
    print("pid1 ${widget.product!.product_id}");
    setState(() {
      isLoading = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}game/launch'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": "${widget.product!.product_id}",
            "amountTransfer": "0",
            "viewType": "mobile"
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
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "productId": widget.product!.product_id,
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

  @override
  void initState() {
    getProfileInfo();
    getAvailableCredit();
    allgameTransactions();
    if (widget.product == null) {
      print("NULLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
      GoRouter.of(context).goNamed(RouteCon.home_Page);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("my id ${widget.product!.productImageUrl}");
    // print(um!.response!.authToken);
    if (widget.product == null) {
      print("NULLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
      GoRouter.of(context).goNamed(RouteCon.home_Page);
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: profileData.response == null
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Color(0xffBD8E37),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFCD877)),
              ))
            : SingleChildScrollView(
                child: Column(
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
                                  // context.pop();
                                  context.goNamed(RouteCon.home_Page);

                                  // Navigator.pushNamed(context, path);
                                  // Navigator.pop(context);
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
                              width: ResponsiveWrapper.of(context)
                                      .isLargerThan(MOBILE)
                                  ? 202
                                  : 101,
                              height: ResponsiveWrapper.of(context)
                                      .isLargerThan(MOBILE)
                                  ? 62
                                  : 31,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Image.network(
                      widget.product!.product_image_url ??
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
                                  child: Text(
                                      "${widget.product!.product_name!}",
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
                                                      "${_availablecredit.response!.coinAvailable ?? "0"}"),
                                              availableTransfer(
                                                  title: "Total",
                                                  value:
                                                      "${_availablecredit.response!.productDetail!.member_product_total_balance ?? "0"}"),
                                              availableTransfer(
                                                  title: "Cash",
                                                  value:
                                                      "${_availablecredit.response!.coinAvailable ?? "0"}"),
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
                                                          checkTopUp(context);
                                                          // showBoxDialogue();
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
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          context.goNamed(RouteCon
                                                              .all_game_transaction_page);
                                                          ;
                                                        },
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
                                                        "Amount (THB)    ${_availablecredit.response!.productDetail!.member_product_total_balance ?? "0"}",
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
                                                              "Today stake: ${_availablecredit.response!.todayStake ?? "0"}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Yesterday stake: ${_availablecredit.response!.yesterdayStake ?? 0}",
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
                                                      "${_availablecredit.response!.avaiableTransfer ?? "0"}"),
                                              availableTransfer(
                                                  title: "Available Coin",
                                                  value:
                                                      "${_availablecredit.response!.coinAvailable ?? "0"}"),
                                              availableTransfer(
                                                  title: "Total",
                                                  value:
                                                      "${_availablecredit.response!.productDetail!.member_product_total_balance ?? "0"}"),
                                              availableTransfer(
                                                  title: "Cash",
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
                                                        "Amount (THB)    ${_availablecredit.response!.productDetail!.member_product_total_balance}",
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
                                                              "Today stake: ${_availablecredit.response!.todayStake ?? "0"}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                      fontSize:
                                                                          16,
                                                                      color: Colors
                                                                          .white)),
                                                          Text(
                                                              "Yesterday stake: ${_availablecredit.response!.yesterdayStake ?? "0"}",
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
                              PrimaryButton(
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
                              allgames!.response == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      backgroundColor: Color(0xffBD8E37),
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Color(0xffFCD877)),
                                    ))
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
                                                        .gameTransactions!
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
                                                            rows: allgames!
                                                                .response!
                                                                .transactions!
                                                                .map(
                                                                    (e) =>
                                                                        DataRow(
                                                                          cells: [
                                                                            DataCell(
                                                                              Text(e!.transaction_created_datetime!),
                                                                            ),
                                                                            DataCell(
                                                                              Text("dnt know"),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.transaction_id ?? " "),
                                                                            ),
                                                                            DataCell(
                                                                              Text("dnt know"),
                                                                            ),
                                                                            DataCell(
                                                                              Text(e.game_transaction_winloss ?? ""),
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
                                            itemCount: allgames!
                                                .response!.transactions!.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              final pdata = allgames!.response!
                                                  .transactions![index];
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
                                                    "dnt know",
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
                                                        "${pdata!.transaction_created_datetime ?? ""}",
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
                                                                  "Bet/Transfer   :   ${pdata.game_transaction_valid_stake}",
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
                                                                  "Win    :   ${pdata.game_transaction_winloss ?? ""}",
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
