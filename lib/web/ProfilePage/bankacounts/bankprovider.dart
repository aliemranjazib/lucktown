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
    ebm = await existinggetBankList(context);
    isloadingbank = false;
    notifyListeners();
  }

  Future addBank(
      context, String bankId, String bankAccount, String accountName) async {
    try {
      final response = await http.post(
        Uri.parse('${memberBaseUrl}bank/createAccount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          "Authorization":
              "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2Njk4MTQwNjUsImlzcyI6IiIsImV4cCI6MTY2OTkwMDQ2NSwidXNlclRva2VuIjoiRDFvRlRiYTcxR0VQekNzRGhwbHMyeTNyVW5LM1hkZHc1YTF4b2JtYkxTUlNkaHFEMnpSM2dmUUZpdGNwQk1sQlFITDBVVkxpTGlWbFpKUWdhTW1yUXB3NEtBaVdVOVJLSXdDem9lN0pWdTZvRnNZZTdNSDRBa3FLS1pjSEgxZVQwVGw1M0w4QTdta2VPdVdpcGVJQnhYSlJPcGpGRmZLbnREWFhKaXd6ejhWVE9aZTlBbUY2dXBjd1Yyb0p2WjRnOG1yN2Qwd1QiLCJ1c2VyVHlwZSI6Im1lbWJlciIsInVzZXJBdXRoIjoiZjRyVzhhTWxNQXg4azVBbEF6WVl2dk80SlNnYmdiZHBwZUFkZXMwS2g0eDIxYnFqZnBrZ3BIdTF3OGFnSDdaNjZBZ3h6RFRQdkREM1RCa1hLdXBjWXJMeUY4dmlZTHpzWXJxUHNqZWpZQnRRYlJwUndaWkVxbEZzVUpKYUpuZExWYkVweENDSEh4eG1kQ05PSWZ5Wlg4Vk9OcXlwSktQbmFSamdOcjZ6ZEhPY1R3dndxMnBHZlhKbEVvZFRXa0h0eTA2ZW5JOFcifQ.GeVzO5d-vpR3Ci7p2YX6suu0r5Fs1wSB4QCJ4-E7u1Y",

          // 'Authorization':
        },
        body: jsonEncode(<String, dynamic>{
          "data": {
            "bankId": "$bankId",
            "bankAccount": "$bankAccount",
            "bankAccountName": "$accountName"
          }
        }),
      );
      switch (response.statusCode) {
        case 200:
          Map<String, dynamic> data = await json.decode(response.body);
          CustomToast.customToast(context, data['msg']);

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
    }
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


// 