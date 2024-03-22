import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/chatModels.dart';

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
