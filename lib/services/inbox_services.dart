import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Sockets/messageSockets.dart';

class InboxServices {
  static Future<List<InboxModel>> fetchInbox(BuildContext context) async {
    List<InboxModel> inboxModel = [];
    ApiResponse response = await ApiHelper.get(
      ApiStringConstants.fetchInbox,
    );
    log(response.data.toString());
    response.data.forEach((element) {
      if (element['lastMessage'] != null) {
        inboxModel.add(InboxModel.fromJson(element));
      }
    });
    return inboxModel;
  }
}
