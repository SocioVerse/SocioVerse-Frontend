import 'package:flutter/material.dart';

class CreateNewPasswordPageProvider with ChangeNotifier {
  bool _isChecked = false;
  bool get isChecked => _isChecked;

  set isChecked(bool value) {
    _isChecked = value;
    notifyListeners();
  }
}
