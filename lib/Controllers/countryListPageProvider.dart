import 'package:flutter/material.dart';
import 'package:socioverse/Utils/CountryList.dart';

class CountryListProvider with ChangeNotifier {
  List<MapEntry<String, String>> _countryList = Country.entries.toList();
  int _selectedCountry = 0;
  int get selectedCountryIndex => _selectedCountry;
  get countryList => _countryList;

  set selectedCountryIndex(int index) {
    _selectedCountry = index;
    notifyListeners();
  }

  onChangedDSearch(String value) {
    _countryList = Country.entries
        .where((element) =>
            element.value.toLowerCase().startsWith(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
