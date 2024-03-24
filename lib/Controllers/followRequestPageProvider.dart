import 'package:flutter/material.dart';
import 'package:socioverse/Models/followRequestModel.dart';
import 'package:socioverse/Services/follow_request_services.dart';

class FollowRequestPageProvider with ChangeNotifier {
  bool _isLoading = true;
  late List<FollowRequestModel> _followRequestModel;
  bool get isLoading => _isLoading;
  List<FollowRequestModel> get followRequestModel => _followRequestModel;

  getFollowRequest() async {
    isLoading = true;
    _followRequestModel =
        await FollowRequestsServices().fetchAllFolloweRequests();
    isLoading = false;
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
