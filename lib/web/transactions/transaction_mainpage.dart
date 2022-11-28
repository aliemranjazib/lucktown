import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/models/profile_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_dialogue.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/contact/contactsModel.dart';
import 'package:flutter_application_lucky_town/web/contact/searchfriendmodel.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:flutter_application_lucky_town/web_menue/header.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:responsive_framework/responsive_framework.dart';

import '../../web_menue/SideMenu.dart';
import '../menue_folder/menueProvider.dart';

class TransactionMainPage extends StatefulWidget {
  @override
  State<TransactionMainPage> createState() => _TransactionMainPageState();
}

class _TransactionMainPageState extends State<TransactionMainPage> {
  bool isLoadingGif = false;
  bool isSearching = false;
  bool isAdding = false;

  String buttonText = "+ New Friend";
  TextEditingController searchController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isLoadingClose = false;
  String? gameStatus = "";
  ProfileData profileData = ProfileData();
  bool isRunning = false;
  Map<String, dynamic> userInfo = {};

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: sideMenu(),
        key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  child: TabBar(indicatorColor: kPrimaryColor, tabs: [
                    Tab(text: "Games"),
                    Tab(text: "Wallet"),
                  ]),
                ),
              ),
              Container(
                //Add this to give height
                height: MediaQuery.of(context).size.height,
                child: TabBarView(children: [
                  Container(
                    child: profileData.response == null
                        ? Center(child: CircularProgressIndicator())
                        : games(),
                  ),
                  Container(
                    child: profileData.response == null
                        ? Center(child: CircularProgressIndicator())
                        : wallet(),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  games() {
    Column(
      children: [
        Row(children: <Widget>[
          Text('hi'),
          Text('hi'),
          Text('hi'),
        ]),
        ListView.builder(
          shrinkWrap: true,
          itemCount: profileData.response!.gameTransactions!.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [],
            );
          },
        ),
      ],
    );
  }

  wallet() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        color: Color(0xff121519),
        // padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Game',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Bet/Transfer',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Win',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: profileData.response!.walletTransactions!.length,
                itemBuilder: (context, index) {
                  final data =
                      profileData.response!.walletTransactions![index]!;
                  return Container(
                    color: Color(0xff212631),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Row(
                                    children: [
                                      Image.network(
                                        data.productImageUrl!,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.productName!),
                                          Text(
                                              data.transactionCreatedDatetime!),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Text(data.transactionType!)),
                                Expanded(child: Text(data.transactionAmount!)),
                                Expanded(child: Text("dnt know")),
                              ]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
