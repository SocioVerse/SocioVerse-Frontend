import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/userModel.dart';

class ReportServices {
  
  static ApiResponse response = ApiResponse();
  static Future<String> createReport({
    required String reportType,
    required String reason,
    required String userId,
    String? feedId,
    String? threadId,
    String? storyId,
  }) async {
    response = await ApiHelper.post(
      ApiStringConstants.createReport,
      querryParam: {
        "reportType": reportType,
        "reason": reason,
        "user_id": userId,
        "feed_id": feedId,
        "thread_id": threadId,
        "story_id": storyId,
      },
      isPublic: false,
    );
    return response.data;
  }
}
