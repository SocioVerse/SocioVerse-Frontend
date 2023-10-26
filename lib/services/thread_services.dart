import 'dart:developer';

import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class ThreadServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse response = ApiResponse();
  Future<ApiResponse> createThread(
      {required CreateThreadModel createThreadModel}) async {
    try {
      response = await _helper.post(
        ApiStringConstants.createThread,
        isPublic: false,
        querryParam: createThreadModel.toJson(),
      );
      log(response.data);
      return response;
    } catch (e) {
      print(e);
      return response;
    }
  }
}
