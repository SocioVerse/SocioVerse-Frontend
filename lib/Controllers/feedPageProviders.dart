import 'package:flutter/material.dart';

class FeedPageProvider with ChangeNotifier {
  bool _isLoading = false;
  bool _showBackToTopButton = false;
  int _value = 1;
  bool get isLoading => _isLoading;
  int get value => _value;
  bool get showBackToTopButton => _showBackToTopButton;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set value(int val) {
    _value = val;
    notifyListeners();
  }

  set showBackToTopButton(bool val) {
    _showBackToTopButton = val;
    notifyListeners();
  }
}
