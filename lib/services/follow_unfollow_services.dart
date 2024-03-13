import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Models/userSignUpModel.dart';

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
        queryParam: {'targetUserId': userId});
  }
}
