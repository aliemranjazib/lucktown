import 'dart:convert';

import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/components/primary-button.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/utils/constants/contants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bank_model.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bankprovider.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/currency_exchange.dart';
import 'package:flutter_application_lucky_town/web/product_detail_page/all_game_transaction.dart';
import 'package:flutter_application_lucky_town/web_menue/Drawer.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({super.key});

  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  String? selectedValue;
  TextEditingController number = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoadingProfile = false;
  List<BankModelResponseAccounts?> cc = [];
  @override
  void initState() {
    final p = Provider.of<BankProvider>(context, listen: false);
    p.getBanks(context);

    // p.getExisitngBanks(context);
    super.initState();
  }

  getW() async {
    setState(() {
      isLoadingProfile = true;
    });
    try {
      final response1 = await http.post(
        Uri.parse('${memberBaseUrl}user/requestWithdraw'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization": await um!.response!.authToken!,
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "withdrawAmount": "${number.text}",
            "withdrawBankAccountId": "11"
          }
        }),
      );
      switch (response1.statusCode) {
        case 200:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
          break;
        case 400:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
          break;
        case 514:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
          // Navigator.pushNamed(context, web_scaffold_page);
          break;
        case 500:
          Map<String, dynamic> data = await json.decode(response1.body);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
          // Navigator.pushNamed(context, web_scaffold_page);
          break;
        // break;
        default:
          final data = json.decode(response1.body);
          print(response1.statusCode);
          print(data);
          CustomToast.customToast(context, data['msg']);
          setState(() {
            isLoadingProfile = false;
          });
      }
    } catch (e) {
      CustomToast.customToast(context, e.toString());
      setState(() {
        isLoadingProfile = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final getBanks = Provider.of<BankProvider>(context);
    if (!getBanks.isloading) {
      getBanks.bm.response!.accounts = getBanks.bm.response!.accounts!
          .distinct((element) => element!.bankId!)
          .toList();
      for (var element in getBanks.bm.response!.accounts!) {
        print(element!.bankId);
      }
    }

    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            topbackbutton(context, web_profile_page),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: getBanks.isloading
                          ? Center(child: CircularProgressIndicator())
                          : DropdownButtonFormField(
                              hint: const Text("choose bank"),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(10),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return "bank must be selected";
                                }
                                return null;
                              },
                              value: selectedValue,
                              items: getBanks.bm.response!.accounts!
                                  .map((e) => DropdownMenuItem<String>(
                                      value: e!.bankId,
                                      child: Text(e.bankName!)))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value.toString();
                                  print(selectedValue);
                                  cc = getBanks.bm.response!.accounts!
                                      .where((element) =>
                                          element!.bankId == selectedValue)
                                      .toList();
                                  print("bnabn ${cc.first!.accountName}");
                                });
                              }),
                    ),
                    SizedBox(height: 20),
                    cc.isEmpty
                        ? Container()
                        : Column(
                            children: [
                              selectedAccount("BANK : ", cc.first!.bankName),
                              selectedAccount(
                                  "Account Name : ", cc.first!.accountName),
                              selectedAccount(
                                  "Account No. : ", cc.first!.accountNumber),
                            ],
                          ),
                    SizedBox(height: 20),
                    CurrencyTextField(
                        title: "Topup Amount",
                        controller: number,
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            return "amount must enter";
                          }
                          return null;
                        },
                        hintText: "account number"),
                    SizedBox(height: 20),
                    PrimaryButton(
                        title: "SUBMIT",
                        loading: isLoadingProfile,
                        onPress: () async {
                          if (formkey.currentState!.validate()) {
                            print("${number.text} and ${cc.first!.bankId!}");
                            // pickImage();
                            await getW();
                          }
                        },
                        width: double.infinity),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Padding selectedAccount(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: kContainerBg,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(child: Text("$title")),
                Expanded(child: Text(value ?? "")),
                Expanded(flex: 2, child: Container()),
              ],
            ),
          )),
    );
  }
}
