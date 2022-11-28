import 'dart:convert';
import 'package:flutter_application_lucky_town/main.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/web/transactions/all_wallet_transaction_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/web/transactions/all_game_transaction_model.dart';

class TransactionProvider extends ChangeNotifier {
  AllGameTransactionModel agt = AllGameTransactionModel();
  AllWalletTransactionModel agwt = AllWalletTransactionModel();

  bool isLoading = false;
  bool isLoadingWallet = false;

  getAllTransaction(context) async {
    isLoadingWallet = true;
    agwt = await apicallforWallet(context);
    isLoadingWallet = false;
    notifyListeners();
  }

  getAllWalletTransaction(context) async {
    isLoading = true;
    agt = await apicallforTransaction(context);
    isLoading = false;
    notifyListeners();
  }
}

Future<AllWalletTransactionModel> apicallforWallet(context) async {
  AllWalletTransactionModel? sm;
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}user/allWalletTransaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": await um!.response!.authToken!,
      },
      body: jsonEncode(<String, dynamic>{
        "data": {
          "type": "all",
          "fromDate": "2021-07-22",
          "toDate": "2022-07-22",
          "page": 1,
          "pageSize": 10
        }
      }),
    );
    switch (response.statusCode) {
      case 200:
        final item = json.decode(response.body);
        sm = AllWalletTransactionModel.fromJson(item);
        break;
      case 400:
        final item = json.decode(response.body);
        CustomToast.customToast(context, item['msg']);
        // sm = SelectCountryModel.fromJson(item);
        break;
      default:
        final item = json.decode(response.body);
        CustomToast.customToast(context, item['msg']);
    }
  } catch (e) {
    print(e);
    CustomToast.customToast(context, e.toString());
  }
  return sm!;
}

Future<AllGameTransactionModel> apicallforTransaction(context) async {
  AllGameTransactionModel? sm;
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}user/allGameTransaction'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        "Authorization": await um!.response!.authToken!,
      },
      body: jsonEncode(<String, dynamic>{
        "data": {
          "productId": "all",
          "fromDate": "2021-07-25",
          "toDate": "2022-07-31",
          "page": 1,
          "pageSize": 1
        }
      }),
    );
    switch (response.statusCode) {
      case 200:
        final item = json.decode(response.body);
        sm = AllGameTransactionModel.fromJson(item);
        break;
      case 400:
        final item = json.decode(response.body);
        CustomToast.customToast(context, item['msg']);
        // sm = SelectCountryModel.fromJson(item);
        break;
      default:
        final item = json.decode(response.body);
        CustomToast.customToast(context, item['msg']);
    }
  } catch (e) {
    print(e);
    CustomToast.customToast(context, e.toString());
  }
  return sm!;
}
