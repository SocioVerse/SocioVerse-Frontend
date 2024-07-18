import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Services/activity_services.dart';

class ActivityPageProvider with ChangeNotifier {
  bool _isLoading = true;
  int _index = 0;

  late LatestFollowRequestModel _latestFollowRequestModel;
  bool get isLoading => _isLoading;
  LatestFollowRequestModel get latestFollowRequestModel =>
      _latestFollowRequestModel;

  Future<void> getLatestFollowRequest() async {
    isLoading = true;
    _latestFollowRequestModel =
        await ActivityServices().fetchLatestFolloweRequests();
    isLoading = false;
  }

  int get index => _index;
  set index(int i) {
    _index = i;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
