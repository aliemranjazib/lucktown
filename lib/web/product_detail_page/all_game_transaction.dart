import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/transactions/all_game_transaction_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../app_routes/app_routes.dart';
import '../../utils/constants/api_constants.dart';

class AllGameTransactionPage extends StatefulWidget {
  String? id;
  AllGameTransactionPage({this.id});
  @override
  State<AllGameTransactionPage> createState() => _AllGameTransactionPageState();
}

class _AllGameTransactionPageState extends State<AllGameTransactionPage> {
  bool isLoading = false;
  AllGameTransactionModel? profileData;

  final headfontSize = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  final rowfontSize = TextStyle(
    fontSize: 16,
  );
  String? date = DateFormat('dd/MM/yyyy').format(DateTime.now());

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
            isLoading = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          setState(() {
            profileData = AllGameTransactionModel.fromJson(data);
            // profileData.response.transactions.first.tr
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
    return profileData!;
  }

  @override
  void initState() {
    allgameTransactions();
    super.initState();
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
            ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(
                                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2022-07-04
                                  //You can format date as per your need

                                  setState(() {
                                    date =
                                        formattedDate; //set foratted date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              child: Text(
                                "$date",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("所有投注记录 / All Bets Record",
                          style: GoogleFonts.roboto(
                            fontSize: 18,
                          )),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14),
                          TextButton(
                              onPressed: () async {
                                DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        DateTime.now(), //get today's date
                                    firstDate: DateTime(
                                        2000), //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime(2101));
                                if (pickedDate != null) {
                                  print(
                                      pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                                  String formattedDate =
                                      DateFormat('dd/MM/yyyy').format(
                                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                                  print(
                                      formattedDate); //formatted date output using intl package =>  2022-07-04
                                  //You can format date as per your need

                                  setState(() {
                                    date =
                                        formattedDate; //set foratted date to TextField value.
                                  });
                                } else {
                                  print("Date is not selected");
                                }
                              },
                              child: Text(
                                "$date",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
                        ],
                      ),
                    ],
                  ),
            SizedBox(height: 15),
            profileData!.response == null
                ? Center(
                    child: CircularProgressIndicator(
                    backgroundColor: Color(0xffBD8E37),
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xffFCD877)),
                  ))
                : ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                    ? Container(
                        // constraints: BoxConstraints(minWidth: 100),
                        color: Color(0xff212631),
                        child: Row(
                          children: [
                            Expanded(
                              child: profileData!
                                      .response!.transactions!.isEmpty
                                  ? Center(child: Text("no data"))
                                  : isLoading
                                      ? Container()
                                      : DataTable(
                                          onSelectAll: (b) {},
                                          sortColumnIndex: 0,
                                          // columnSpacing: 180,
                                          sortAscending: true,
                                          columns: <DataColumn>[
                                            DataColumn(
                                                label: Expanded(
                                                    child: Text("Date & Time",
                                                        style: headfontSize)),
                                                tooltip:
                                                    "To Display date and time"),
                                            DataColumn(
                                                label: Text("Username",
                                                    style: headfontSize),
                                                tooltip:
                                                    "To Display user name"),
                                            DataColumn(
                                                label: Text("ID",
                                                    style: headfontSize),
                                                tooltip: "display id"),
                                            DataColumn(
                                                label: Text("Bet / Transfer",
                                                    style: headfontSize),
                                                tooltip:
                                                    "to display bet/transfer"),
                                            DataColumn(
                                                label: Text("Total Win",
                                                    style: headfontSize),
                                                tooltip:
                                                    "to display total win"),
                                          ],
                                          rows: profileData!
                                              .response!.transactions!
                                              .map((e) => DataRow(
                                                    cells: [
                                                      DataCell(
                                                        Text(e!
                                                            .transaction_created_datetime!),
                                                      ),
                                                      DataCell(
                                                        Text(e
                                                            .transaction_amount!),
                                                      ),
                                                      DataCell(
                                                        Text(e.transaction_id!),
                                                      ),
                                                      DataCell(
                                                        Text(e
                                                            .game_transaction_winloss!),
                                                      ),
                                                      DataCell(
                                                        Text(e
                                                            .game_transaction_winloss!),
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
                          color: Color(0xff212631).withOpacity(0.5),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              profileData!.response!.transactions!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final pdata =
                                profileData!.response!.transactions![index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                // radius: 20,
                                minRadius: 30,
                                maxRadius: 30,
                                child: Text(""),
                              ),
                              title: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  pdata!.transaction_amount!,
                                  style: GoogleFonts.roboto(),
                                ),
                              ),
                              subtitle: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${pdata.transaction_created_datetime}",
                                      style: GoogleFonts.roboto(fontSize: 12),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0, right: 10, top: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Bet/Transfer   :   ${pdata.transaction_amount}",
                                                style: GoogleFonts.roboto(
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
                                                "Win    :   ${pdata.transaction_amount}",
                                                style: GoogleFonts.roboto(
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
            // Expanded(
            //     child: Center(
            //   child: FutureBuilder(
            //     future: allgameTransactions(),
            //     builder: (BuildContext context,
            //         AsyncSnapshot<AllGameTransactionModel> snapshot) {
            //       if (!snapshot.hasData) {
            //         return CircularProgressIndicator();
            //       }
            //       if (snapshot.data == null) {
            //         return Text("NO DATA");
            //       }
            //       return Text("aaaa");
            //     },
            //   ),
            // ))
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
                context.goNamed(RouteCon.home_Page);

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
