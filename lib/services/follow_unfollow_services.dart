import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class FollowUnfollowServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<void> toogleFollow({
    required String userId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleFollowReq,
        querryParam: {'targetUserId': userId});
  }

  Future<void> unFollow({
    required String userId,
  }) async {
    _response = await _helper.delete(ApiStringConstants.unFollow,
        querryParam: {'targetUserId': userId});
  }
}
