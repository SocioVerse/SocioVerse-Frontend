import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Models/userModel.dart';

class UserServices {
  final ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<List<UserModel>> getUserDetails() async {
    List<UserModel> userList = [];
    try {
      _response = await _helper.get(
        ApiStringConstants.fetchUser,
        isPublic: false,
      );

      if (_response.success) {
        UserModel user = UserModel.fromJson(_response.data);
        log(_response.data.toString());
        userList.add(user);
        return userList;
      } else {
        return userList;
      }
    } catch (e) {
      print(e);
      return userList;
    }
  }

  Future<List<User>> getShareList() async {
    List<User> fetchedUsers = [];
    _response = await _helper.get(ApiStringConstants.getShareList);
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  Future<Room> getRoomId(String userId) async {
    _response = await _helper
        .get(ApiStringConstants.fetchRoomId, querryParam: {"userId": userId});
    return Room.fromJson(_response.data);
  }
}
