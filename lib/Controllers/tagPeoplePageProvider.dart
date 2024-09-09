import 'package:flutter/material.dart';
import 'package:socioverse/Models/searchedUser.dart';

class TagPeoplePageProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<SearchedUser> _searchedUser = [];
  bool get isLoading => _isLoading;
  List<SearchedUser> get searchedUser => _searchedUser;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearUsers() {
    _searchedUser = [];
    notifyListeners();
  }

  set searchedUser(List<SearchedUser> value) {
    _searchedUser = value;
    notifyListeners();
  }
}
