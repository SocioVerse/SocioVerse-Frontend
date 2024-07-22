import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';

class FollowersServices {
  static ApiResponse _response = ApiResponse();

  static Future<List<FollowersModel>> fetchFollowers(String? userId) async {
    _response = userId != null
        ? await ApiHelper.get(
            ApiStringConstants.fetchFollowers,
            querryParam: {
              "userId": userId,
            },
            isPublic: false,
          )
        : await ApiHelper.get(
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

  static Future<List<FollowersModel>> fetchFollowing(String? userId) async {
    _response = userId != null
        ? await ApiHelper.get(
            ApiStringConstants.fetchFollowing,
            querryParam: {
              "userId": userId,
            },
            isPublic: false,
          )
        : await ApiHelper.get(
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
