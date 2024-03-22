import 'package:flutter/material.dart';

class PasswordSignUpPageProvider with ChangeNotifier {
  bool _isObscure = true;
  bool _isRememberMe = false;
  bool get isObscure => _isObscure;
  bool get isRememberMe => _isRememberMe;
  set isObscure(bool val) {
    _isObscure = val;
    notifyListeners();
  }

  set isRememberMe(bool val) {
    _isRememberMe = val;
    notifyListeners();
  }
}
