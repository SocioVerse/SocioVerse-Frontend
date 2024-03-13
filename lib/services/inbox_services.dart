import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/inboxModel.dart';

class InboxServices {
  ApiHelper _helper = ApiHelper();
  Future<List<InboxModel>> fetchInbox() async {
    List<InboxModel> inboxModel = [];
    ApiResponse response = await _helper.get(
      ApiStringConstants.fetchInbox,
    );
    log(response.data.toString());
    response.data.forEach((element) {
      inboxModel.add(InboxModel.fromJson(element));
    });
    return inboxModel;
  }
}
