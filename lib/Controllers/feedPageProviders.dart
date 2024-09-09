import 'package:flutter/material.dart';

class ShowBackToTopProvider with ChangeNotifier {
  bool _showBackToTopButton = false;
  bool get showBackToTopButton => _showBackToTopButton;

  set showBackToTopButton(bool val) {
    _showBackToTopButton = val;
    notifyListeners();
  }
}

class FeedPageProvider with ChangeNotifier {
  bool _isLoading = false;
  int _value = 1;
  int _messageCount = 0;
  bool get isLoading => _isLoading;
  int get value => _value;
  int get messageCount => _messageCount;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set value(int val) {
    _value = val;
    notifyListeners();
  }

  set messageCount(int val) {
    _messageCount = val;
    notifyListeners();
  }
}
