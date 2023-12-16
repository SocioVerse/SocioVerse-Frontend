import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

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
