import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';

class FollowUnfollowServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<void> toggleFollow({
    required String userId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toggleFollowReq,
        querryParam: {'targetUserId': userId});
  }

  Future<void> unFollow({
    required String userId,
  }) async {
    _response = await _helper.delete(ApiStringConstants.unFollow,
        queryParam: {'targetUserId': userId});
  }
}
