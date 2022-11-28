import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/BigBoxComponet.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/CompleteTextBar.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/HeaderComponet.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/HomeScreenCatagory.dart';
import 'package:flutter_application_lucky_town/web/home/coin_chips.dart';
import 'package:flutter_application_lucky_town/web/home/web_home.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/SideMenu.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/contants.dart';
import '../../web_menue/header.dart';
import '../menue_folder/menueProvider.dart';
// import '../';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

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
                                print(topupMethods[index]);
                                if (topupMethods[index] == "Top Up USDT") {
                                  // _launchInBrowser(url)
                                  _launchInBrowser(Uri.parse(
                                      "https://lt888.live/Payment/cryptoPayment/${um!.response!.user!.memberUniqueKey}"));

                                  // Navigator.pushNamed(context, web_topup_usdt_page);
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
          "Authorization": await um!.response!.authToken!,

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
          print("coin ${profileData.response!.accounts!.first!.accountName}");

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

  @override
  void initState() {
    Future.delayed(Duration(seconds: 0), () {
      getProfileInfo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: sideMenu(),
        key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: isLoadingGif == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Header(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // WebMenu(),
                          // Spacer(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProfileHeader(
                              imageUrl:
                                  'https://cdn-icons-png.flaticon.com/512/188/188999.png?w=740&t=st=1669457916~exp=1669458516~hmac=b9dbb7e5bf4aa076c57728e986cf13802c63328a0148d7b3559d7af1898de5f3',
                              title:
                                  "${um!.response!.user!.memberUsername ?? " "}",
                              lid: "${um!.response!.user!.vipLevelId ?? " "}",
                              nick:
                                  "${um!.response!.user!.memberNickname ?? " "}",
                              reffercal:
                                  "${um!.response!.user!.refMemberName ?? " "}",
                            ),
                          ),

                          ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                              ? CompleteTextBar(
                                  chips: profileData.response!.coinBalance!,
                                  cash: profileData.response!.walletBalance!,
                                  coin: profileData.response!.interestBalance!,
                                  stage: "stage",
                                )
                              : CompleteTextBarMobileView(
                                  chips: profileData.response!.coinBalance!,
                                  cash: profileData.response!.walletBalance!,
                                  coin: profileData.response!.interestBalance!,
                                  stage: "stage",
                                ),

                          ResponsiveVisibility(
                            visible: false,
                            visibleWhen: [Condition.smallerThan(name: TABLET)],
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
                                                silverGradientRobto('50 MYR',
                                                    12, FontWeight.normal),
                                                Image.asset(
                                                  spinMove,
                                                  width: 22,
                                                  height: 22,
                                                ),
                                                silverGradientRobto('x1 Spin',
                                                    12, FontWeight.normal),
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
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        silverGradientRobto('Check-in : Day  5',
                                            20, FontWeight.normal),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Image.asset(
                                                  pCoin,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                                silverGradientRobto('50 MYR',
                                                    20, FontWeight.normal),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  spinMove,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                                silverGradientRobto('x1 Spin',
                                                    20, FontWeight.normal),
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
                                          () {
                                            showBoxDialogue();
                                          },
                                        ),
                                        box(
                                          transfer,
                                          "Transfer",
                                          () {
                                            Navigator.pushNamed(
                                                context, web_contact_main_page);
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
                                                Navigator.pushNamed(context,
                                                    web_bank_acount_page);
                                              },
                                            )),
                                      ],
                                    ),
                                    ResponsiveVisibility(
                                      visible: false,
                                      visibleWhen: [
                                        Condition.smallerThan(name: TABLET)
                                      ],
                                      child: Row(
                                        // shrinkWrap: true,
                                        // crossAxisCount: 3,
                                        children: [
                                          box(topUp, "Top up /Withdraw", () {}),
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
                                            Navigator.pushNamed(context,
                                                web_currency_exchange_page);
                                          },
                                        ),
                                        box(helpDesk, "Help Desk", () {
                                          _launchInBrowser(Uri.parse(
                                              "https://member.luckytown.online//Support/live/${um!.response!.user!.memberUsername}${um!.response!.user!.lastLoginIp}"));
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
                                            Navigator.pushNamed(
                                                context, web_setting_page);
                                          },
                                        ),
                                        ResponsiveVisibility(
                                            visible: true,
                                            hiddenWhen: [
                                              Condition.smallerThan(
                                                  name: TABLET)
                                            ],
                                            child:
                                                Expanded(child: Container())),
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
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: kDefaultPadding,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 22),
                      child: Row(
                        children: [
                          Text(
                            'Top Up',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                          SizedBox(
                            width: kDefaultPadding * 3,
                          ),
                          Text(
                            'WithDraw',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: double.infinity,
                            height: 5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Container(
                            width: kMaxWidth / 15,
                            height: 5,
                            color: Colors.amber,
                          ),
                        )
                      ],
                    ),
                    profileData.response == null
                        ? Center(child: CircularProgressIndicator())
                        : ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                            ? Container(
                                // constraints: BoxConstraints(minWidth: 100),
                                color: Color(0xff121519),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child:
                                          profileData.response!
                                                  .walletTransactions!.isEmpty
                                              ? Center(child: Text("no data"))
                                              : isLoadingGif
                                                  ? Container()
                                                  : DataTable(
                                                      border: TableBorder(
                                                          bottom:
                                                              BorderSide.none),
                                                      onSelectAll: (b) {},
                                                      sortColumnIndex: 0,
                                                      // columnSpacing: 180,
                                                      sortAscending: true,
                                                      columns: <DataColumn>[
                                                        DataColumn(
                                                          label: Expanded(
                                                              child: Text(
                                                                  "Record",
                                                                  style:
                                                                      headfontSize)),
                                                        ),
                                                        DataColumn(
                                                          label: Text("Status",
                                                              style:
                                                                  headfontSize),
                                                        ),
                                                        DataColumn(
                                                          label: Text("Top Up",
                                                              style:
                                                                  headfontSize),
                                                        ),
                                                      ],
                                                      rows: profileData
                                                          .response!
                                                          .orderTransactions!
                                                          .map((e) => DataRow(
                                                                cells: [
                                                                  DataCell(
                                                                    Row(
                                                                      children: [
                                                                        Image.asset(
                                                                            smalLogo),
                                                                        SizedBox(
                                                                            width:
                                                                                10),
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text("Top Up"),
                                                                            Text(e!.topupType!),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  DataCell(
                                                                    Text(e
                                                                        .topupStatus!),
                                                                  ),
                                                                  DataCell(
                                                                    Text(e
                                                                        .topupAmount!),
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
                                  color: Color(0xff121519),
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: profileData
                                      .response!.orderTransactions!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final pdata = profileData
                                        .response!.orderTransactions![index];
                                    return ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.blue,
                                        // radius: 20,
                                        minRadius: 30,
                                        maxRadius: 30,
                                        child: Text(""),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                          pdata!.topupType!,
                                          style: GoogleFonts.roboto(),
                                        ),
                                      ),
                                      subtitle: Container(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${pdata.transactionDatetime}",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0, right: 10, top: 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Status  :   ${pdata.topupStatus}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
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
                                                        "Top Up    :   ${pdata.topupAmount}",
                                                        style:
                                                            GoogleFonts.roboto(
                                                                fontSize: 12),
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
                              ),
                  ],
                ),
              ));
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
