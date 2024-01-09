import 'package:flutter/material.dart';

class StoryIndexProvider extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void updateIndex(int newIndex) {
    // Schedule the notification for the next microtask
    Future.microtask(() {
      _currentIndex = newIndex;
      notifyListeners();
    });
  }
}
