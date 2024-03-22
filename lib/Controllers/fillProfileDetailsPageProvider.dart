import 'package:flutter/material.dart';

class FillProfileProvider with ChangeNotifier {
  bool? _profileImageLoading;
  bool? _faceImageLoading;
  bool _isDateSelected = false;
  DateTime? _birthDate; // instance of DateTime
  String? _birthDateInString;
  final TextEditingController _dob = TextEditingController();

  bool get isDateSelected => _isDateSelected;
  DateTime? get birthDate => _birthDate;
  String? get birthDateInString => _birthDateInString;
  TextEditingController get dob => _dob;
  bool? get profileImageLoading => _profileImageLoading;
  bool? get faceImageLoading => _faceImageLoading;

  set profileImageLoading(bool? val) {
    _profileImageLoading = val;
    notifyListeners();
  }

  set faceImageLoading(bool? val) {
    _faceImageLoading = val;
    notifyListeners();
  }

  set isDateSelected(bool val) {
    _isDateSelected = val;
    notifyListeners();
  }

  set birthDate(DateTime? val) {
    _birthDate = val;
    notifyListeners();
  }

  set birthDateInString(String? val) {
    _birthDateInString = val;
    notifyListeners();
  }

  set dobText(String val) {
    _dob.text = val;
    notifyListeners();
  }
}
