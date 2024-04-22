import 'package:flutter/material.dart';

class InboxPageProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isUserFetched = false;
  bool get isLoading => _isLoading;
  bool get isUserFetched => _isUserFetched;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isUserFetched(bool value) {
    _isUserFetched = value;
    notifyListeners();
  }
}
