import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/chatModels.dart';

class ChattingServices {
  static Future<RoomModel> getChatroomInfoByUser(
      String userId, String ownerUserId) async {
    Map<String, String> querryParam = {"userId": userId};
    ApiResponse response = await ApiHelper.get(
      ApiStringConstants.getChatroomInfoByUser,
      querryParam: querryParam,
    );
    log(ownerUserId);
    return RoomModel.fromJson(response.data, ownerUserId);
  }

  static Future<Room> createRoom(String userId) async {
    Map<String, String> querryParam = {"userId": userId};
    ApiResponse response = await ApiHelper.post(
      ApiStringConstants.createRoom,
      querryParam: querryParam,
    );
    return Room.fromJson(response.data);
  }
}
