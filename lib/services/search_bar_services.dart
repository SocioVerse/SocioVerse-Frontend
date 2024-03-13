import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Models/userSignUpModel.dart';

class SearchBarServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<List<SearchedUser>> fetchSearchedUser({
    required String searchQuery,
  }) async {
    List<SearchedUser> fetchedUsers = [];
    _response = await _helper.get(ApiStringConstants.searchUser,
        querryParam: {'query': searchQuery});
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(SearchedUser.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  Future<List<HashtagsSearchModel>> getHashtags(
      {required String hashtag}) async {
    _response = await _helper.get(
      ApiStringConstants.searchHashtags,
      querryParam: {'query': hashtag},
    );

    List<HashtagsSearchModel> hashtagsSearchModel = [];
    _response.data.forEach((element) {
      hashtagsSearchModel.add(HashtagsSearchModel.fromJson(element));
    });
    return hashtagsSearchModel;
  }

  Future<List<LocationSearchModel>> getLocation(
      {required String location}) async {
    _response = await _helper.get(
      ApiStringConstants.searchLocation,
      querryParam: {'query': location},
    );

    List<LocationSearchModel> locationList = [];
    _response.data.forEach((element) {
      locationList.add(LocationSearchModel.fromJson(element));
    });
    return locationList;
  }

  Future<List<FeedThumbnail>> getFeedsMetadata(
      {required String metadata}) async {
    _response = await _helper.get(
      ApiStringConstants.searchFeedsByMetadata,
      querryParam: {'query': metadata},
    );

    List<FeedThumbnail> mentionsList = [];
    _response.data.forEach((element) {
      mentionsList.add(FeedThumbnail.fromJson(element));
    });
    return mentionsList;
  }
}
