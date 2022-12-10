import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/CompleteTextBar.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/HeaderComponet.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/checktopupmodel.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_routes/app_routes.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/contants.dart';
import '../../web_menue/header.dart';
// import '../';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

UserSessionModel? userM;

class _ProfilePageState extends State<ProfilePage> {
  bool isLoadingGif = false;
  ProfileData profileData = ProfileData();
  Map userInfo = {};
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

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      print('Could not launch $url');
      throw 'Could not launch $url';
    }
  }

  Future<PendtingTopUpModel> checkTopUp(context) async {
    PendtingTopUpModel? bm;
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}user/checkTopup'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,
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
                                      "https://lt888.live/Payment/cryptoPayment/${userM!.response!.user!.memberUniqueKey}"));
                                } else if (topupMethods[index] ==
                                    "Top Up Bank Transfer") {
                                  context
                                      .goNamed(RouteCon.bank_topup_main_page);
                                } else if (topupMethods[index] == "Withdraw") {
                                  context.goNamed(RouteCon.withdraw_page);
                                } else if (topupMethods[index] ==
                                    "Instant Top Up") {
                                  // Navigator.pop(context);

                                  if (userM!.response!.user!.countryCode ==
                                      "THB") {
                                    _launchInBrowser(Uri.parse(
                                        "https://member.luckytown.online//Payment/topupTHB/${userM!.response!.user!.memberUniqueKey}"));
                                  } else if (userM!
                                          .response!.user!.countryCode ==
                                      "MYR") {
                                    _launchInBrowser(Uri.parse(
                                        "https://member.luckytown.online//Payment/directPayment/${userM!.response!.user!.memberUniqueKey}"));
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

  Future<ProfileData> getProfileInfo() async {
    setState(() {
      isLoadingGif = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/getProfileData'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{"data": {}}),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            profileData = ProfileData.fromJson(data);
          });
          // print(
          //     "coin ${profileData.response!.accounts!.first!.accountName ?? "null"}");

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
          print("response-------------${response1.statusCode}");
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

  bool isGettingToken = false;

  Future<UserSessionModel> getToken() async {
    String aa = await LuckySharedPef.getAuthToken();
    Map<String, dynamic> decodedata = jsonDecode(aa);

    setState(() {
      userM = UserSessionModel.fromJson(decodedata);
      print("popo ${userM!.response!.authToken}");

      print("username ${userM!.response!.user!.memberUsername}");
      print("vip ${userM!.response!.user!.vipLevelId}");
      print("nick ${userM!.response!.user!.memberNickname}");
      print("username ${userM!.response!.user!.memberUsername}");
    });

    return await userM!;
  }

  getAllData() async {
    setState(() {
      isGettingToken = true;
    });
    await getToken();

    await getProfileInfo();

    setState(() {
      isGettingToken = false;
    });
    // getAllProducts();
  }

  @override
  void initState() {
    getAllData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: Colors.black,
          body: isGettingToken == true
              ? Center(
                  child: CircularProgressIndicator(
                  backgroundColor: Color(0xffBD8E37),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xffFCD877)),
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Header(),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // WebMenu(),
                                // Spacer(),
                                userM!.response == null
                                    ? CircularProgressIndicator()
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ProfileHeader(
                                          imageUrl:
                                              'https://cdn-icons-png.flaticon.com/512/188/188999.png?w=740&t=st=1669457916~exp=1669458516~hmac=b9dbb7e5bf4aa076c57728e986cf13802c63328a0148d7b3559d7af1898de5f3',
                                          title:
                                              "${userM!.response!.user!.memberUsername ?? " "}",
                                          lid:
                                              "${userM!.response!.user!.vipLevelId ?? " "}",
                                          nick:
                                              "${userM!.response!.user!.memberNickname ?? " "}",
                                          reffercal:
                                              "${userM!.response!.user!.refMemberName ?? " "}",
                                          qrUrl:
                                              "${userM!.response!.user!.memberQrcodeUrl ?? " "}",
                                          countryUrl:
                                              "${userM!.response!.user!.countryUrl ?? " "}",
                                        ),
                                      ),

                                ResponsiveWrapper.of(context)
                                        .isLargerThan(MOBILE)
                                    ? CompleteTextBar(
                                        chips:
                                            profileData.response!.coinBalance ??
                                                "0",
                                        cash: profileData
                                                .response!.walletBalance ??
                                            "0",
                                        coin: profileData
                                                .response!.interestBalance ??
                                            "0",
                                        stage: "stage",
                                      )
                                    : CompleteTextBarMobileView(
                                        chips:
                                            profileData.response!.coinBalance ??
                                                "0",
                                        cash: profileData
                                                .response!.walletBalance ??
                                            "0",
                                        coin: profileData
                                                .response!.interestBalance ??
                                            "0",
                                        stage: "stage",
                                      ),

                                ResponsiveVisibility(
                                  visible: false,
                                  visibleWhen: [
                                    Condition.smallerThan(name: TABLET)
                                  ],
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 8),
                                    child: Container(
                                      width: double.infinity,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        color: kContainerBg,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                children: [
                                                  silverGradientRobto(
                                                      'Check-in : Day  5',
                                                      12,
                                                      FontWeight.normal),
                                                  Row(
                                                    children: [
                                                      Image.asset(
                                                        pCoin,
                                                        width: 22,
                                                        height: 22,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      silverGradientRobto(
                                                          '50 MYR',
                                                          12,
                                                          FontWeight.normal),
                                                      Image.asset(
                                                        spinMove,
                                                        width: 22,
                                                        height: 22,
                                                      ),
                                                      silverGradientRobto(
                                                          'x1 Spin',
                                                          12,
                                                          FontWeight.normal),
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Image.asset(
                                            giftBox,
                                            height: 82,
                                            width: 82,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                Row(
                                  children: [
                                    ResponsiveVisibility(
                                      visible: true,
                                      hiddenWhen: [
                                        Condition.smallerThan(name: TABLET)
                                      ],
                                      child: Expanded(
                                        child: Container(
                                          width: 336,
                                          height: 306,
                                          decoration: BoxDecoration(
                                            color: kContainerBg,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              silverGradientRobto(
                                                  'Check-in : Day  5',
                                                  20,
                                                  FontWeight.normal),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        pCoin,
                                                        width: 50,
                                                        height: 50,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      silverGradientRobto(
                                                          '50 MYR',
                                                          20,
                                                          FontWeight.normal),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Image.asset(
                                                        spinMove,
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                      silverGradientRobto(
                                                          'x1 Spin',
                                                          20,
                                                          FontWeight.normal),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Image.asset(giftBox)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: [
                                          Row(
                                            // shrinkWrap: true,
                                            // crossAxisCount: 3,
                                            children: [
                                              box(
                                                topUp,
                                                "Top up\nWithdraw",
                                                () async {
                                                  await checkTopUp(context);
                                                  // showBoxDialogue();
                                                },
                                              ),
                                              box(
                                                transfer,
                                                "Transfer",
                                                () {
                                                  context.pushNamed(RouteCon
                                                      .profile_tranfer_main_page);
                                                },
                                              ),
                                              ResponsiveVisibility(
                                                  visible: true,
                                                  hiddenWhen: [
                                                    Condition.smallerThan(
                                                        name: TABLET)
                                                  ],
                                                  child: box(
                                                    bank,
                                                    "Bank \nAccount",
                                                    () {
                                                      context.pushNamed(RouteCon
                                                          .bank_acount_page);
                                                    },
                                                  )),
                                            ],
                                          ),
                                          ResponsiveVisibility(
                                            visible: false,
                                            visibleWhen: [
                                              Condition.smallerThan(
                                                  name: TABLET)
                                            ],
                                            child: Row(
                                              // shrinkWrap: true,
                                              // crossAxisCount: 3,
                                              children: [
                                                box(topUp, "Top up /Withdraw",
                                                    () {}),
                                                box(
                                                  transfer,
                                                  "Transfer",
                                                  () {},
                                                ),
                                                ResponsiveVisibility(
                                                    visible: true,
                                                    hiddenWhen: [
                                                      Condition.smallerThan(
                                                          name: TABLET)
                                                    ],
                                                    child: box(
                                                      bank,
                                                      "Bank \n Account",
                                                      () {},
                                                    )),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            // shrinkWrap: true,
                                            // crossAxisCount: 3,
                                            children: [
                                              box(
                                                CurrencyExchange,
                                                "Currency\nExchange",
                                                () {
                                                  context.pushNamed(RouteCon
                                                      .currency_exchange_page);
                                                },
                                              ),
                                              box(helpDesk, "Help Desk", () {
                                                _launchInBrowser(Uri.parse(
                                                    "https://member.luckytown.online//Support/live/${userM!.response!.user!.memberUsername}${userM!.response!.user!.lastLoginIp}"));
                                              }),
                                              ResponsiveVisibility(
                                                  visible: true,
                                                  hiddenWhen: [
                                                    Condition.smallerThan(
                                                        name: TABLET)
                                                  ],
                                                  child: box(
                                                    promotion,
                                                    "Promotion",
                                                    () {},
                                                  )),
                                              // box(promotion, "Promotion"),
                                            ],
                                          ),
                                          Row(
                                            // shrinkWrap: true,
                                            // crossAxisCount: 3,
                                            children: [
                                              box(
                                                vip,
                                                "VIP",
                                                () {},
                                              ),
                                              box(
                                                setting,
                                                "Setting",
                                                () {
                                                  context.pushNamed(
                                                      RouteCon.setting_page);
                                                },
                                              ),
                                              ResponsiveVisibility(
                                                  visible: true,
                                                  hiddenWhen: [
                                                    Condition.smallerThan(
                                                        name: TABLET)
                                                  ],
                                                  child: Expanded(
                                                      child: Container())),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Text(
                              '订单记录  / Order',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: kDefaultPadding,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Container(
                              child:
                                  TabBar(indicatorColor: kPrimaryColor, tabs: [
                                Tab(text: "Top Up"),
                                Tab(text: "WithDraw"),
                              ]),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height,
                            child: TabBarView(
                              children: [
                                // topUpBar(),
                                profileData.response == null
                                    ? Center(child: CircularProgressIndicator())
                                    : topUpBar(),
                                transferBar(),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
    );
  }

  Widget topUpBar() {
    return ResponsiveWrapper.of(context).isLargerThan(MOBILE)
        ? Container(
            // color: Color(0xff121519),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: profileData.response!.orderTransactions!.isEmpty
                      ? Center(child: Text("no data"))
                      : isLoadingGif
                          ? Container()
                          : Column(
                              children: [
                                Container(
                                  color: Color(0xff121519),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            flex: 2, child: Text("Record")),
                                        Expanded(
                                            flex: 2, child: Text("Status")),
                                        Expanded(
                                            flex: 1, child: Text("Top Up")),
                                      ],
                                    ),
                                  ),
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: profileData
                                      .response!.orderTransactions!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final orders = profileData
                                        .response!.orderTransactions![index]!;
                                    return Container(
                                      color: Color(0xff212631),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 20),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Row(
                                                  children: [
                                                    Image.network(
                                                      orders.topupReceiptUrl ??
                                                          "https://player.luckytown.online/images/Lucky_Town_Logo_FA-01.png",
                                                      height: 60,
                                                      width: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    SizedBox(width: 10),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("Top Up"),
                                                        Text(
                                                            "${orders.topupDatetime ?? ""}"),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                            Expanded(
                                                flex: 2,
                                                child: Text(
                                                    "${orders.topupStatus ?? ""}")),
                                            Expanded(
                                                child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                children: [
                                                  Image.asset(pCoin),
                                                  Text(
                                                      "${orders.topupAmount ?? ""}"),
                                                ],
                                              ),
                                            )),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),

                  // DataTable(
                  //     border: TableBorder(bottom: BorderSide.none),
                  //     onSelectAll: (b) {},
                  //     sortColumnIndex: 0,
                  //     // columnSpacing: 180,
                  //     sortAscending: true,
                  //     columns: <DataColumn>[
                  //       DataColumn(
                  //         label: Expanded(
                  //             child:
                  //                 Text("Record", style: headfontSize)),
                  //       ),
                  //       DataColumn(
                  //         label: Text("Status", style: headfontSize),
                  //       ),
                  //       DataColumn(
                  //         label: Text("Top Up", style: headfontSize),
                  //       ),
                  //     ],
                  //     rows: profileData.response!.orderTransactions!
                  //         .map((e) => DataRow(
                  //               cells: [
                  //                 DataCell(
                  //                   Row(
                  //                     children: [
                  //                       Image.asset(smalLogo),
                  //                       SizedBox(width: 10),
                  //                       Column(
                  //                         mainAxisAlignment:
                  //                             MainAxisAlignment.start,
                  //                         crossAxisAlignment:
                  //                             CrossAxisAlignment.start,
                  //                         children: [
                  //                           Text("Top Up"),
                  //                           Text(
                  //                               e!.topupType ?? "null"),
                  //                         ],
                  //                       ),
                  //                     ],
                  //                   ),
                  //                 ),
                  //                 DataCell(
                  //                   Text(e.topupStatus ?? "null"),
                  //                 ),
                  //                 DataCell(
                  //                   Text(e.topupAmount ?? "null"),
                  //                 ),
                  //               ],
                  //             ))
                  //         .toList()),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Color(0xff121519),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: profileData.response!.orderTransactions!.length,
              itemBuilder: (BuildContext context, int index) {
                final pdata = profileData.response!.orderTransactions![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    // radius: 20,
                    minRadius: 30,
                    maxRadius: 30,
                    child: Text(""),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      pdata!.topupType ?? "null",
                      style: GoogleFonts.roboto(),
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pdata.transactionDatetime ?? "null"}",
                          style: GoogleFonts.roboto(fontSize: 12),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0, right: 10, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Status  :   ${pdata.topupStatus ?? "null"}",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset(
                                    Hnadcoin,
                                    width: 12,
                                    height: 11,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Top Up    :   ${pdata.topupAmount ?? "null"}",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset(
                                    Hnadcoin,
                                    width: 12,
                                    height: 11,
                                    fit: BoxFit.cover,
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
          );
  }

  Widget transferBar() {
    return ResponsiveWrapper.of(context).isLargerThan(MOBILE)
        ? Container(
            // color: Color(0xff121519),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: profileData.response!.walletTransactions!.isEmpty
                      ? Center(child: Text("no data"))
                      : isLoadingGif
                          ? Container()
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    color: Color(0xff121519),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 50, vertical: 20),
                                      child: Row(
                                        children: [
                                          Expanded(
                                              flex: 2, child: Text("Record")),
                                          Expanded(
                                              flex: 2, child: Text("Status")),
                                          Expanded(
                                              flex: 1, child: Text("Top Up")),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: profileData
                                        .response!.walletTransactions!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final orders = profileData.response!
                                          .walletTransactions![index]!;
                                      return Container(
                                        color: Color(0xff212631),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  flex: 2,
                                                  child: Row(
                                                    children: [
                                                      Image.network(
                                                        orders.productImageUrl ??
                                                            "https://player.luckytown.online/images/Lucky_Town_Logo_FA-01.png",
                                                        height: 60,
                                                        width: 60,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      SizedBox(width: 10),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text("Top Up"),
                                                          Text(
                                                              "${orders.withdrawUpdateDatetime ?? ""}"),
                                                        ],
                                                      ),
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                      "${orders.transactionStatus ?? ""}")),
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Row(
                                                  children: [
                                                    Image.asset(pCoin),
                                                    Text(
                                                        "${orders.transactionAmount ?? ""}"),
                                                  ],
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              color: Color(0xff121519),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: profileData.response!.walletTransactions!.length,
              itemBuilder: (BuildContext context, int index) {
                final pdata = profileData.response!.orderTransactions![index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    // radius: 20,
                    minRadius: 30,
                    maxRadius: 30,
                    child: Text(""),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      pdata!.topupType ?? "null",
                      style: GoogleFonts.roboto(),
                    ),
                  ),
                  subtitle: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${pdata.transactionDatetime ?? "null"}",
                          style: GoogleFonts.roboto(fontSize: 12),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 0, right: 10, top: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Status  :   ${pdata.topupStatus ?? "null"}",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset(
                                    Hnadcoin,
                                    width: 12,
                                    height: 11,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Top Up    :   ${pdata.topupAmount ?? "null"}",
                                    style: GoogleFonts.roboto(fontSize: 12),
                                  ),
                                  SizedBox(width: 5),
                                  Image.asset(
                                    Hnadcoin,
                                    width: 12,
                                    height: 11,
                                    fit: BoxFit.cover,
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
          );
  }

  Widget box(
    String imagepath,
    String text,
    GestureTapCallback onpress,
  ) {
    return Expanded(
      flex: 1,
      // fit: FlexFit.loose,
      child: GestureDetector(
        onTap: onpress,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            // height: 10,
            // width: 300,

            height: 86,
            // width: 200,
            // constraints: BoxConstraints(
            //     minHeight: 86, maxHeight: 86, maxWidth: 235, minWidth: 155),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kContainerBg,
            ),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      imagepath,
                      width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 40
                          : 20,
                      height: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                          ? 40
                          : 19,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 10),
                    silverGradientRobto('$text', 18, FontWeight.normal),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  // Home Screen Options Desktop View

// Desk View Option

  // Home Screen Options MObile View

  Widget RowData() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          'Record',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          'Status',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          'Top Up',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ],
    );
  }

  Widget smallcontainer(
      String title, String ImagePath, GestureTapCallback press) {
    return Column(
      children: [
        GestureDetector(
          onTap: press,
          child: Container(
            width: kMaxWidth / 5,
            height: kDefaultPadding * 5,
            decoration: BoxDecoration(
                color: Color(0xff252A2D),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(
                  ImagePath,
                  scale: 1.4,
                ),
                silverGradientRobto(title, 20, FontWeight.normal),
              ],
            ),
          ),
        ),
        SizedBox(
          height: kDefaultPadding,
          width: kDefaultPadding,
        )
      ],
    );
  }
}
