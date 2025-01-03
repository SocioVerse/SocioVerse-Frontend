import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Models/userModel.dart';

class UserServices {
  static ApiResponse _response = ApiResponse();
  static Future<List<UserModel>> getUserDetails() async {
    List<UserModel> userList = [];
    try {
      _response = await ApiHelper.get(
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

  static Future<List<User>> getShareList({required String query}) async {
    List<User> fetchedUsers = [];
    _response = query.isEmpty
        ? await ApiHelper.get(ApiStringConstants.getShareList)
        : await ApiHelper.get(ApiStringConstants.searchUser,
            querryParam: {'query': query});

    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  static Future<Room> getRoomId(String userId) async {
    _response = await ApiHelper.get(ApiStringConstants.fetchRoomId,
        querryParam: {"userId": userId});
    return Room.fromJson(_response.data);
  }

  static Future<ApiResponse> changePassword(
      {required String? oldPassword, required String newPassword}) async {
    _response =
        await ApiHelper.post(ApiStringConstants.changePassword, querryParam: {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    });
    return _response;
  }
}
