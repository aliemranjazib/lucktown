import 'package:shared_preferences/shared_preferences.dart';

class LuckySharedPef {
  static SharedPreferences? sharedPreferences;
  static const authToken = 'authToken';

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  }

  static Future saveAuthToken(String token) {
    return sharedPreferences!.setString(authToken, token);
  }

  static String getAuthToken() {
    return sharedPreferences!.getString(authToken) ?? "";
  }

  static Future<bool> removeAuthToken() async {
    return sharedPreferences!.remove(authToken);
  }
}
