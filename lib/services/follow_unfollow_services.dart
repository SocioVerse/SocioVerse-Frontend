import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';

class FollowUnfollowServices {
  static ApiResponse _response = ApiResponse();

  static Future<void> toggleFollow({
    required String userId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleFollowReq,
        querryParam: {'targetUserId': userId});
  }

  static Future<void> unFollow({
    required String userId,
  }) async {
    _response = await ApiHelper.delete(ApiStringConstants.unFollow,
        queryParam: {'targetUserId': userId});
  }
}
