import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ValidationHelper {
  static bool validateEmailAndPassword(
      BuildContext context, String email, String password) {
    if (!isEmailValid(email)) {
      showToast(context, "Email is not valid");
      return false;
    }

    if (!isStrongPassword(password)) {
      showToast(context,
          "Password should contain at least 8 characters, 1 uppercase, 1 lowercase, 1 number and 1 special character");
      return false;
    }
    return true;
  }

  static bool isEmailValid(String email) {
    RegExp emailPattern = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );
    return emailPattern.hasMatch(email);
  }

  static bool isStrongPassword(String password) {
    RegExp passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    return passwordPattern.hasMatch(password);
  }

  static void showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
