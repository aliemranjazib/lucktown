import 'package:flutter/cupertino.dart';

class SignInProvider extends ChangeNotifier {
  Map _selection = {};
  Map get getTokenAndPhone => _selection;
  saveTokenAndPhone(Map selection) {
    _selection = selection;
    notifyListeners();
  }
}
