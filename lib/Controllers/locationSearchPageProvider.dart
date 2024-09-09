import 'package:flutter/material.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Services/location_services.dart';

class LocationSearchProvider with ChangeNotifier {
  bool _isSearching = false;
  List<LocationSearchModel> _searchedLocation = [];
  TextEditingController _searchText = TextEditingController();
  bool get isSearching => _isSearching;
  List<LocationSearchModel> get searchedLocation => _searchedLocation;
  TextEditingController get searchText => _searchText;
  set isSearching(bool value) {
    _isSearching = value;
    notifyListeners();
  }

  set searchedLocation(List<LocationSearchModel> value) {
    _searchedLocation = value;
    notifyListeners();
  }

  void getQueryLocation() async {
    isSearching = true;
    if (searchText.text.trim().isNotEmpty) {
      searchedLocation =
          await LocationServices.getLocation(location: searchText.text);
    }
    isSearching = false;

    notifyListeners();
  }
}
