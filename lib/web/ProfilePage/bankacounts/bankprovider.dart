import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/bank_model.dart';
import 'package:flutter_application_lucky_town/web/ProfilePage/bankacounts/exisitng_bank_model.dart';
import 'package:http/http.dart' as http;

class BankProvider extends ChangeNotifier {
  bool isloading = false;
  bool isloadingbank = false;

  BankModel bm = BankModel();
  ExistingBankModel ebm = ExistingBankModel();

  getBanks(context) async {
    isloading = true;
    bm = await getBankList(context);
    isloading = false;
    notifyListeners();
  }

  getExisitngBanks(context) async {
    isloadingbank = true;
    ebm = await getExisitngBanks(context);
    isloadingbank = false;
    notifyListeners();
  }
}

Future<ExistingBankModel> existinggetBankList(context) async {
  ExistingBankModel? ebm;
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}user/getBankList'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": await um!.response!.authToken!,

        // 'Authorization':
      },
      body: jsonEncode(<String, dynamic>{
        "data": {"targetUniqueKey": "", "amount": "10"}
      }),
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = await json.decode(response.body);
        ebm = ExistingBankModel.fromJson(data);
        break;
      case 400:
        Map<String, dynamic> data = await json.decode(response.body);
        CustomToast.customToast(context, data['msg']);
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
  return ebm!;
}

addBank() async {
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}bank/createAccount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": await um!.response!.authToken!,

        // 'Authorization':
      },
      body: jsonEncode(<String, dynamic>{
        "data": {"targetUniqueKey": "", "amount": "10"}
      }),
    );
  } catch (e) {
    print(e);
  }
}

Future<BankModel> getBankList(context) async {
  BankModel? bm;
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}bank/accounts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": await um!.response!.authToken!,

        // 'Authorization':
      },
      body: jsonEncode(<String, dynamic>{}),
    );
    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> data = await json.decode(response.body);
        bm = BankModel.fromJson(data);
        break;
      case 400:
        Map<String, dynamic> data = await json.decode(response.body);
        CustomToast.customToast(context, data['msg']);
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
