import 'package:flutter/material.dart';
import 'package:socioverse/Models/followRequestModel.dart';
import 'package:socioverse/Services/follow_request_services.dart';

class FollowRequestPageProvider with ChangeNotifier {
  late List<FollowRequestModel> _followRequestModel;
  List<FollowRequestModel> get followRequestModel => _followRequestModel;

  getFollowRequest() async {
    _followRequestModel =
        await FollowRequestsServices.fetchAllFolloweRequests();
  }

  // removeAt
  removeAt(int index) {
    _followRequestModel.removeAt(index);
    notifyListeners();
  }
}
