import 'package:flutter/material.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Services/user_services.dart';

class PostEditAdditionalFeatureProvider extends ChangeNotifier {
  bool _autoEnhance = false;
  bool _public = false;
  bool _allowComments = false;
  bool _allowSave = false;

  bool get autoEnhance => _autoEnhance;
  bool get public => _public;
  bool get allowComments => _allowComments;
  bool get allowSave => _allowSave;

  void init() {
    _autoEnhance = true;
    _public = true;
    _allowComments = true;
    _allowSave = true;
    notifyListeners();
  }

  set public(bool value) {
    _public = value;
    notifyListeners();
  }

  set allowComments(bool value) {
    _allowComments = value;
    notifyListeners();
  }

  set allowSave(bool value) {
    _allowSave = value;
    notifyListeners();
  }

  set autoEnhance(bool value) {
    _autoEnhance = value;
    notifyListeners();
  }
}

class PostEditProvider extends ChangeNotifier {
  LocationSearchModel? _selectedLocation; //
  List<SearchedUser> _taggedUser = []; //
  List<HashtagsSearchModel> _hashtagList = []; //

  LocationSearchModel? get selectedLocation => _selectedLocation;
  List<SearchedUser> get taggedUser => _taggedUser;
  List<HashtagsSearchModel> get hashtagList => _hashtagList;

  Future<void> init() async {
    _selectedLocation = null;
    _taggedUser = [];
    _hashtagList = [];
    notifyListeners();
  }

  set selectedLocation(LocationSearchModel? value) {
    _selectedLocation = value;
    notifyListeners();
  }

  set taggedUser(List<SearchedUser> value) {
    _taggedUser = value;
    notifyListeners();
  }

  set hashtagList(List<HashtagsSearchModel> value) {
    _hashtagList = value;
    notifyListeners();
  }

  void addTaggedUser(SearchedUser user) {
    _taggedUser.add(user);
    notifyListeners();
  }

  void removeTaggedUser(SearchedUser user) {
    _taggedUser.removeWhere(
      (element) => element.id == user.id,
    );
    notifyListeners();
  }

  void addHashtag(HashtagsSearchModel hashtag) {
    _hashtagList.add(hashtag);
    notifyListeners();
  }

  void removeHashtag(HashtagsSearchModel hashtag) {
    _hashtagList.removeWhere(
      (element) => element.id == hashtag.id,
    );
    notifyListeners();
  }

  void clearAll() {
    _selectedLocation = null;
    _taggedUser = [];
    _hashtagList = [];
    notifyListeners();
  }
}

class PostEditingEmailProvider extends ChangeNotifier {
  String? _userEmail;

  String? get userEmail => _userEmail;

  set userEmail(String? value) {
    _userEmail = value;
    notifyListeners();
  }

  getUserInfo() async {
    userEmail =
        await UserServices.getUserDetails().then((value) => value[0].email);
  }
}
