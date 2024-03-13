import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';

class FollowersServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<List<FollowersModel>> fetchFollowers(String? userId) async {
    _response = userId != null
        ? await _helper.get(
            ApiStringConstants.fetchFollowers,
            querryParam: {
              "userId": userId,
            },
            isPublic: false,
          )
        : await _helper.get(
            ApiStringConstants.fetchFollowers,
            isPublic: false,
          );
    if (_response.success) {
      return List<FollowersModel>.from(
          _response.data.map((x) => FollowersModel.fromJson(x)));
    } else {
      return [];
    }
  }

  Future<List<FollowersModel>> fetchFollowing(String? userId) async {
    _response = userId != null
        ? await _helper.get(
            ApiStringConstants.fetchFollowing,
            querryParam: {
              "userId": userId,
            },
            isPublic: false,
          )
        : await _helper.get(
            ApiStringConstants.fetchFollowing,
            isPublic: false,
          );
    if (_response.success) {
      return List<FollowersModel>.from(
          _response.data.map((x) => FollowersModel.fromJson(x)));
    } else {
      return [];
    }
  }
}
