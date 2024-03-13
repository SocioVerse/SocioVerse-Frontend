import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';

class UserProfileDetailsServices {
  final ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<UserProfileDetailsModel?> fetchUserProfileDetails(String? id) async {
    _response = id != null
        ? await _helper.get(
            ApiStringConstants.fetchUserProfileDetails,
            querryParam: {
              "userId": id,
            },
            isPublic: false,
          )
        : await _helper.get(
            ApiStringConstants.fetchUserProfileDetails,
            isPublic: false,
          );
    if (_response.success) {
      return UserProfileDetailsModel.fromJson(_response.data);
    } else {
      return null;
    }
  }

  Future<void> addBio(String bio) async {
    _response = await _helper.post(ApiStringConstants.addBio, querryParam: {
      "bio": bio,
    });
  }

  Future<List<ThreadModel>> getRepostThreads(String? id) async {
    List<ThreadModel> fetchedThreads = [];
    _response = id != null
        ? await _helper.get(
            ApiStringConstants.fetchRepostThreads,
            querryParam: {
              "userId": id,
            },
            isPublic: false,
          )
        : await _helper.get(
            ApiStringConstants.fetchRepostThreads,
            isPublic: false,
          );
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  Future<List<FeedThumbnail>> getUserFeeds({String? userId}) async {
    List<FeedThumbnail> fetchedFeeds = [];
    _response = userId == null
        ? await _helper.get(
            ApiStringConstants.fetchUserFeeds,
            isPublic: false,
          )
        : await _helper.get(
            ApiStringConstants.fetchUserFeeds,
            querryParam: {
              "userId": userId,
            },
            isPublic: false,
          );
    if (_response.success == true) {
      for (var feed in _response.data) {
        fetchedFeeds.add(FeedThumbnail.fromJson(feed));
      }
    }
    return fetchedFeeds;
  }
}
