import 'package:flutter/material.dart';

class CreateNewThreadAlertBoxProvider with ChangeNotifier {
  bool _privateThread = false;

  bool get privateThread => _privateThread;
  set privateThread(bool value) {
    _privateThread = value;
    notifyListeners();
  }
}
