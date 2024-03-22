import 'package:flutter/material.dart';
import 'package:socioverse/Utils/CountryList.dart';

class CountryListProvider with ChangeNotifier {
  List<MapEntry<String, String>> _countryList = Country.entries.toList();
  get countryList => _countryList;

  onChangedDSearch(String value) {
    _countryList = Country.entries
        .where((element) =>
            element.value.toLowerCase().startsWith(value.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
