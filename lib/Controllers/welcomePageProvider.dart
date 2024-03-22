import 'package:flutter/foundation.dart';

class WelcomePageProvider extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    _currentPage = value;
    notifyListeners();
  }
}
