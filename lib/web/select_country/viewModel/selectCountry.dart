import 'package:flutter/material.dart';

class SelectCountry extends ChangeNotifier {
  Map _selection = {};
  Map get getSelection => _selection;
  saveCountry(Map selection) {
    _selection = selection;
    notifyListeners();
  }
}
