import 'dart:developer';

import 'package:socioverse/Views/Pages/SocioVerse/Inbox/inboxModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

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
