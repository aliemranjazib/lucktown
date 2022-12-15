import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/select_country_model.dart';
import 'package:flutter_application_lucky_town/utils/components/custom_toast.dart';
import 'package:flutter_application_lucky_town/utils/constants/api_constants.dart';
import 'package:flutter_application_lucky_town/web/select_country/model/selectCountryModel.dart';
import "package:http/http.dart" as http;

class SelectCountry extends ChangeNotifier {
  SelectCountryModel sm = SelectCountryModel();
  bool isLoading = false;
  getCountry(context) async {
    isLoading = true;
    sm = await apicallforCountry(context);
    isLoading = false;
    notifyListeners();
  }

  Map<String, dynamic> _selection = {};
  Map<String, dynamic> get getSelection => _selection;
  saveSelection(Map<String, dynamic> selection) {
    _selection = selection;
    notifyListeners();
  }
}

Future<SelectCountryModel> apicallforCountry(context) async {
  SelectCountryModel? sm;
  try {
    final response = await http.post(
      Uri.parse('${memberBaseUrl}country/listNoAuth'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"data": {}}),
    );
    switch (response.statusCode) {
      case 200:
        final item = json.decode(response.body);
        sm = SelectCountryModel.fromJson(item);
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
