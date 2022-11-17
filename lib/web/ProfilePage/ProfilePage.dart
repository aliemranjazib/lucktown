import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/gradient_text.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/db_services/share_pref.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/BigBoxComponet.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/CompleteTextBar.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/HeaderComponet.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/Componet/HomeScreenCatagory.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/SideMenu.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';
import '../../utils/constants/api_constants.dart';
import '../../utils/constants/contants.dart';
import '../../web_menue/header.dart';
import '../menue_folder/menueProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoadingGif = false;
  ProfileData profileData = ProfileData();
  List<String> topupMethods = [
    "Instant Top Up",
    "Top Up Bank Transfer",
    "Top Up USDT",
    "Withdraw"
  ];

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
                              Navigator.pushNamed(context, web_topup_usdt_page);
                            }
                          },
                          width: double.infinity),
                    ))
          ],
        );
      },
    );
  }

  Future<String> getToken() async {
    return await LuckySharedPef.getAuthToken();
  }

  Future<ProfileData> getProfileInfo() async {
    if (getToken().toString().isNotEmpty) {
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
            print("coin ${profileData.response!.accounts!.first.accountName}");

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
    return profileData;
  }

  @override
  void initState() {
    getToken();
    getProfileInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlackColor,
        drawer: sideMenu(),
        key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: isLoadingGif == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Header(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // WebMenu(),
                        // Spacer(),
                        ProfileHeader(
                          title: "name",
                          lid: "lid",
                          nick: "nick",
                          reffercal: "pppp",
                        ),
                        if (ResponsiveWrapper.of(context)
                                .isLargerThan('Tablet') ||
                            ResponsiveWrapper.of(context).isTablet ||
                            ResponsiveWrapper.of(context).isDesktop)
                          CompleteTextBar(
                            chips: profileData.response!.coinBalance!,
                            cash: profileData.response!.walletBalance!,
                            coin: Hnadcoin,
                            stage: "stage",
                          ),
                        if (ResponsiveWrapper.of(context).isMobile || ResponsiveWrapper.of(context).isSmallerThan('Mobile'))
                          CompleteTextBarMobileView(
                            chips: profileData.response!.coinBalance!,
                            cash: profileData.response!.walletBalance!,
                            coin: Hnadcoin,
                            stage: "stage",
                          ),
                        if (ResponsiveWrapper.of(context)
                                .isLargerThan('Tablet') ||
                            ResponsiveWrapper.of(context).isTablet ||
                            ResponsiveWrapper.of(context).isDesktop)
                          HomeScreenCatagory(),
                        if (ResponsiveWrapper.of(context).isMobile)
                          HomeScreenCatagoryMobileView(),
                        if (ResponsiveWrapper.of(context)
                                .isLargerThan('Tablet') ||
                            ResponsiveWrapper.of(context).isTablet ||
                            ResponsiveWrapper.of(context).isDesktop)
                          HomeScreenOptionsDesktopView(),
                        if (ResponsiveWrapper.of(context).isMobile)
                          HomeScreenOptionsMobileView(),
                      ],
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
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: Container(
                        width: kMaxWidth / 3,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff252A2D),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(12, 12, 23, 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Record',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Text(
                                    'Status',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Text(
                                    'Top Up',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 18.0,
                        right: 18.0,
                      ),
                      child: Container(
                        width: double.infinity,
                        height: 500,
                        decoration: BoxDecoration(
                            color: Color(0xff252A2D),
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RowData(),
                            RowData(),
                            RowData(),
                            RowData(),
                            RowData(),
                            RowData(),
                            RowData(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  // Home Screen Options Desktop View

  Widget HomeScreenOptionsDesktopView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BigBOxComponetsDeskTopView(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showBoxDialogue();
                  },
                  child: smallcontainer(
                      'Top up / WithDraw',
                      topUp,
                      
                      ),
                ),
                SizedBox(
                  width: 12,
                ),
                smallcontainer(
                    'Transfer',
                    transfer),
                SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {},
                  child: smallcontainer(
                      'Bank Account',
                      bank,
                      
                      ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smallcontainer(
                    'Currency Exchange',
                    CurrencyExchange,
                    ),
                SizedBox(
                  width: 12,
                ),
                smallcontainer(
                    'Help Desk',
                    helpDesk
                    ),
                SizedBox(
                  width: 12,
                ),
                smallcontainer(
                    'Promotion',
                    promotion),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                smallcontainer(
                    'VIP',
                    vip),
                SizedBox(
                  width: 12,
                ),
                smallcontainer(
                    'Setting',
                    setting),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
          ],
        )
      ],
    );
  }

// Desk View Option

  // Home Screen Options MObile View

  Widget HomeScreenOptionsMobileView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigBOxComponets(),
        Column(
          children: [
        HomeScreenCatagoryMobileView1(),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showBoxDialogue();
                      },
                      child: smallcontainer(
                          'Top up / WithDraw',
                         topUp,),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                      InkWell(
                      onTap: () {},
                      child: smallcontainer(
                          'Bank Account',
                          bank),
                    ),
                     smallcontainer(
                        'Help Desk',
                       helpDesk),
                    SizedBox(
                      width: 12,
                    ),
                    smallcontainer(
                        'VIP',
                       vip),
                  
                  
                    SizedBox(
                      width: 12,
                    ),
                    
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                      smallcontainer(
                        'Transfer',
                        transfer),
                    SizedBox(
                      width: 12,
                    ),
                    smallcontainer(
                        'Currency Exchange',
                       CurrencyExchange),
                    SizedBox(
                      width: 12,
                    ),
                   
                    smallcontainer(
                        'Promotion',
                        promotion),
                    SizedBox(
                      width: 12,
                    ),
                    smallcontainer(
                        'Setting',
                        setting),
                  ],
                ),
              ],
            )
          ],
        )
      ],
    );
  }

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

  Widget smallcontainer(String title, String ImagePath) {
    return Column(
      children: [
        Container(
          width: kMaxWidth / 5,
          height: kDefaultPadding * 5,
          decoration: BoxDecoration(
              color: Color(0xff252A2D),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(ImagePath,scale: 1.4,),
              silverGradientRobto(title, 20, FontWeight.normal),
            ],
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
