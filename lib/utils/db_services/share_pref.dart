import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/user_model.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LuckySharedPef extends ChangeNotifier {
  static SharedPreferences? sharedPreferences;
  static const authToken = 'authToken';
  static const onlyAuthToken = 'onlyAuthToken';

  // static const userKey = 'userKey';
  // UserSessionModel? um;
  // String get usersData => _userData!;
  // UserSessionModel get _um => um!;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static String getAuthToken() {
    return sharedPreferences!.getString(authToken) ?? "";
  }

  static Future saveOnlyAuthToken(String tokenonly) {
    return sharedPreferences!.setString(onlyAuthToken, tokenonly);
  }

  static String getOnlyAuthToken() {
    return sharedPreferences!.getString(onlyAuthToken) ?? "";
  }

  static Future<bool> removeOnlyAuthToken() async {
    return sharedPreferences!.remove(onlyAuthToken);
  }

  static Future saveAuthToken(String token) {
    return sharedPreferences!.setString(authToken, token);
  }

  static Future<bool> removeAuthToken() async {
    return sharedPreferences!.remove(authToken);
  }
}
