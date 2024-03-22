import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/userModel.dart';

class UserServices {
  final ApiHelper _helper = ApiHelper();
  ApiResponse response = ApiResponse();
  Future<List<UserModel>> getUserDetails() async {
    List<UserModel> userList = [];
    try {
      response = await _helper.get(
        ApiStringConstants.fetchUser,
        isPublic: false,
      );

      if (response.success) {
        UserModel user = UserModel.fromJson(response.data);
        log(response.data.toString());
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
}
