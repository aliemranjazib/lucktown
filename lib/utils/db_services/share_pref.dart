import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_lucky_town/models/user_model.dart';
import 'package:flutter_application_lucky_town/models/user_session_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LuckySharedPef extends ChangeNotifier {
  static SharedPreferences? sharedPreferences;
  static const authToken = 'authToken';
  static const userKey = 'userKey';
  UserSessionModel? um;
  // String get usersData => _userData!;
  UserSessionModel get _um => um!;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static String getAuthToken() {
    return sharedPreferences!.getString(authToken) ?? "";
  }

  forAll(String data) async {
    // data = getAuthToken();
    Map<String, dynamic> decodedata = jsonDecode(data);
    um = UserSessionModel.fromJson(decodedata);
    notifyListeners();
  }

  getAll() {}

  static Future saveMapValues(String data) {
    Map<String, dynamic> json = jsonDecode(data);
    String user = jsonEncode(json);
    return sharedPreferences!.setString(userKey, user);
  }

  // static Response getMapValues() {
  //   // Map<String, dynamic> json = jsonDecode(data);
  //   Map<String, dynamic> userjson =
  //       jsonDecode(sharedPreferences!.getString(userKey) ?? "");
  //   // Response s = Response.fromJson(userjson);
  //   return s;
  // }

  static Future saveAuthToken(String token) {
    return sharedPreferences!.setString(authToken, token);
  }

  static Future<bool> removeAuthToken() async {
    return sharedPreferences!.remove(authToken);
  }
}
