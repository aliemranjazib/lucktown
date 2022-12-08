import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/app_routes/app_routes.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/ProfilePage.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/checktopup/checktopupmodel.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import "package:http/http.dart" as http;

import '../../../utils/constants/api_constants.dart';

class PendingTopUpPage extends StatefulWidget {
  PendtingTopUpModel? ptm;
  PendingTopUpPage({super.key, this.ptm});

  @override
  State<PendingTopUpPage> createState() => _PendingTopUpPageState();
}

class _PendingTopUpPageState extends State<PendingTopUpPage> {
  bool isValidatingUserName = false;
  @override
  void didChangeDependencies() {
    if (widget.ptm!.response == null) {
      GoRouter.of(context).pushNamed(RouteCon.profile_page);
    }
    super.didChangeDependencies();
  }

  cancelTopUp() async {
    setState(() {
      isValidatingUserName = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/cancelTopUp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await userM!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {"topupId": "${widget.ptm!.response!.info!.topupId!}"}
        }),
      );
      switch (response1.statusCode) {
        case 200:
          setState(() {
            isValidatingUserName = true;
          });
          Map<String, dynamic> data = json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          context.goNamed(RouteCon.profile_page);
          print(response1.statusCode);

          setState(() {
            isValidatingUserName = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = json.decode(response1.body);

          CustomToast.customToast(context, data['msg']);

          setState(() {
            isValidatingUserName = false;
          });
          break;
        default:
          Map<String, dynamic> data = json.decode(response1.body);

          CustomToast.customToast(context, data['msg']);
          setState(() {
            isValidatingUserName = false;
          });

        // CustomToast.customToast(context, "WENT WRONG");
      }
    } catch (e) {
      setState(() {
        isValidatingUserName = false;
      });
      CustomToast.customToast(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.ptm!.response == null) {
      context.goNamed(RouteCon.profile_page);
    }
    // print(widget.ptm!.response!.info!.bankId);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            topbackbutton(context),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        child: PrimaryButton(
                            title: "CANCEL TOP UP",
                            loading: isValidatingUserName,
                            onPress: () {
                              cancelTopUp();
                            },
                            width: MediaQuery.of(context).size.width * 0.3),
                      ),
                      SizedBox(height: 10),
                      container_box("Bank",
                          "${widget.ptm!.response!.info!.topupBankName ?? "0"}"),
                      container_box("Account Name",
                          "${widget.ptm!.response!.info!.bankAccountName ?? "0"}"),
                      container_box("Account No.",
                          "${widget.ptm!.response!.info!.bankAccountNumber ?? "0"}"),
                      container_box("Top Up Type",
                          "${widget.ptm!.response!.info!.topupType ?? "0"}"),
                      container_box("Amount",
                          "${widget.ptm!.response!.info!.topupAmount ?? "0"}"),
                      container_box("Date",
                          "${widget.ptm!.response!.info!.topupDatetime ?? "0"}"),
                      container_box("Remarks",
                          "${widget.ptm!.response!.info!.topupRemarks ?? "0"}"),
                      Image.network(
                          "${widget.ptm!.response!.info!.topupReceiptUrl ?? ""}")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card container_box(String title, String value) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            Text("$title            :         "),
            Text("${value}"),
            Divider(),
          ],
        ),
      ),
    );
  }

  Row topbackbutton(
    BuildContext context,
  ) {
    return Row(
      children: [
        Container(
          height: 50,
          color: Colors.black,
          child: Row(
            children: [
              BackButton(
                onPressed: () {
                  context.goNamed(RouteCon.profile_page);

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
              width: ResponsiveWrapper.of(context).isLargerThan(MOBILE)
                  ? 202
                  : 101,
              height:
                  ResponsiveWrapper.of(context).isLargerThan(MOBILE) ? 62 : 31,
            ),
          ),
        ),
      ],
    );
  }
}
