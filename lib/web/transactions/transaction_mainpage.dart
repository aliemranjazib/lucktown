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
import 'package:flutter_application_lucky_town/web/transactions/transaction_provider.dart';
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
    final p = Provider.of<TransactionProvider>(context, listen: false);
    p.getAllTransaction(context);
    p.getAllWalletTransaction(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final getTransactions = Provider.of<TransactionProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        drawer: sideMenu(),
        // key: Provider.of<MenuProvider>(context, listen: false).scaffoldkey,
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
                    child: getTransactions.isLoadinggt
                        ? Center(child: CircularProgressIndicator())
                        : Padding(
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  'Game',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Type',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Bet/Transfer',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  'Win',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ]),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      // shrinkWrap: true,
                                      itemCount: getTransactions
                                          .agt.response!.transactions!.length,
                                      itemBuilder: (context, index) {
                                        final data = getTransactions.agt
                                            .response!.transactions![index]!;
                                        return Container(
                                          color: Color(0xff212631),
                                          child: Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        flex: 2,
                                                        child: Row(
                                                          children: [
                                                            Image.network(
                                                              data.product_image_url!,
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit
                                                                  .contain,
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
                                                                Text(data
                                                                    .game_transaction_payout!),
                                                                Text(data
                                                                    .transaction_created_datetime!),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                          child: Text(data
                                                              .transaction_type!)),
                                                      Expanded(
                                                          child: Text(data
                                                              .transaction_amount!)),
                                                      Expanded(
                                                          child: Text(data
                                                              .game_transaction_winloss!)),
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
                          ),
                  ),
                  Container(
                      child: getTransactions.isLoadingwt
                          ? Center(child: CircularProgressIndicator())
                          : Padding(
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(
                                                    'Game',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Type',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Bet/Transfer',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Win',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        // shrinkWrap: true,
                                        itemCount: getTransactions.agwt
                                            .response!.transactions!.length,
                                        itemBuilder: (context, index) {
                                          final data = getTransactions.agwt
                                              .response!.transactions![index]!;
                                          return Container(
                                            color: Color(0xff212631),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          flex: 2,
                                                          child: Row(
                                                            children: [
                                                              Image.network(
                                                                data.product_image_url!,
                                                                height: 80,
                                                                width: 80,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              SizedBox(
                                                                  width: 10),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(data
                                                                          .product_name ??
                                                                      "nnn"),
                                                                  Text(data
                                                                          .transaction_created_datetime ??
                                                                      "ooo"),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            child: Text(
                                                                data.transaction_type ??
                                                                    "nnn")),
                                                        Expanded(
                                                            child: Text(
                                                                data.done_by_shareholder_id ??
                                                                    "0000")),
                                                        Expanded(
                                                            child: Text(
                                                                "dnt know")),
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
                            )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // games() {
  //   final getTransactions = Provider.of<TransactionProvider>(context);
  //   return getTransactions.isLoading
  //       ? Center(child: CircularProgressIndicator())
  //       : Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Container(
  //             color: Color(0xff121519),
  //             // padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(14.0),
  //                     child: Container(
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Expanded(
  //                               flex: 2,
  //                               child: Text(
  //                                 'Game',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Type',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Bet/Transfer',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Win',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                           ]),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     // shrinkWrap: true,
  //                     itemCount:
  //                         getTransactions.agt.response!.transactions!.length,
  //                     itemBuilder: (context, index) {
  //                       final data =
  //                           getTransactions.agt.response!.transactions![index]!;
  //                       return Container(
  //                         color: Color(0xff212631),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(14.0),
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Expanded(
  //                                       flex: 2,
  //                                       child: Row(
  //                                         children: [
  //                                           Image.network(
  //                                             data.product_image_url!,
  //                                             height: 80,
  //                                             width: 80,
  //                                             fit: BoxFit.contain,
  //                                           ),
  //                                           SizedBox(width: 10),
  //                                           Column(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.start,
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               Text(data
  //                                                   .game_transaction_payout!),
  //                                               Text(data
  //                                                   .transaction_created_datetime!),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                         child: Text(data.transaction_type!)),
  //                                     Expanded(
  //                                         child:
  //                                             Text(data.transaction_amount!)),
  //                                     Expanded(
  //                                         child: Text(
  //                                             data.game_transaction_winloss!)),
  //                                   ]),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );
  // }

  // wallet() {
  //   final getWalletTransactions = Provider.of<TransactionProvider>(context);

  //   return
  //   getWalletTransactions.isLoadingWallet
  //       ? Center(child: CircularProgressIndicator())
  //       : Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 10),
  //           child: Container(
  //             color: Color(0xff121519),
  //             // padding: EdgeInsets.symmetric(horizontal: 10),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(14.0),
  //                     child: Container(
  //                       child: Row(
  //                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                           children: [
  //                             Expanded(
  //                               flex: 2,
  //                               child: Text(
  //                                 'Game',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Type',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Bet/Transfer',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                             Expanded(
  //                               child: Text(
  //                                 'Win',
  //                                 style: TextStyle(fontWeight: FontWeight.bold),
  //                               ),
  //                             ),
  //                           ]),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   child: ListView.builder(
  //                     // shrinkWrap: true,
  //                     itemCount: getWalletTransactions
  //                         .agwt.response!.transactions!.length,
  //                     itemBuilder: (context, index) {
  //                       final data = getWalletTransactions
  //                           .agwt.response!.transactions![index]!;
  //                       return Container(
  //                         color: Color(0xff212631),
  //                         child: Padding(
  //                           padding: const EdgeInsets.all(14.0),
  //                           child: Column(
  //                             children: [
  //                               Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Expanded(
  //                                       flex: 2,
  //                                       child: Row(
  //                                         children: [
  //                                           Image.network(
  //                                             data.product_image_url!,
  //                                             height: 80,
  //                                             width: 80,
  //                                             fit: BoxFit.contain,
  //                                           ),
  //                                           SizedBox(width: 10),
  //                                           Column(
  //                                             mainAxisAlignment:
  //                                                 MainAxisAlignment.start,
  //                                             crossAxisAlignment:
  //                                                 CrossAxisAlignment.start,
  //                                             children: [
  //                                               Text(
  //                                                   data.product_name ?? "nnn"),
  //                                               Text(
  //                                                   data.transaction_created_datetime ??
  //                                                       "ooo"),
  //                                             ],
  //                                           ),
  //                                         ],
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                         child: Text(
  //                                             data.transaction_type ?? "nnn")),
  //                                     Expanded(
  //                                         child: Text(
  //                                             data.done_by_shareholder_id ??
  //                                                 "0000")),
  //                                     Expanded(child: Text("dnt know")),
  //                                   ]),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         );

  // }
}
