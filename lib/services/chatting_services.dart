import 'dart:developer';

import 'package:socioverse/Models/chat_models.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';

class ChattingServices {
  final ApiHelper _helper = ApiHelper();
  Future<RoomModel> getChatroomInfoByUser(
      String userId, String ownerUserId) async {
    Map<String, String> querryParam = {"userId": userId};
    ApiResponse response = await _helper.get(
      ApiStringConstants.getChatroomInfoByUser,
      querryParam: querryParam,
    );
    log(ownerUserId);
    return RoomModel.fromJson(response.data, ownerUserId);
  }
}
