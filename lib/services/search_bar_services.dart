import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Models/searchedUser.dart';

class SearchBarServices {
  static ApiResponse _response = ApiResponse();

  static Future<List<SearchedUser>> fetchSearchedUser({
    required String searchQuery,
  }) async {
    List<SearchedUser> fetchedUsers = [];
    _response = await ApiHelper.get(ApiStringConstants.searchUser,
        querryParam: {'query': searchQuery});
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(SearchedUser.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  static Future<String> fetchSearchedUserByFace({
    required String faceImage,
  }) async {
    _response = await ApiHelper.get(ApiStringConstants.searchUserByFace,
        querryParam: {'faceImage': faceImage});
    return _response.data['label'];
  }

  static Future<List<HashtagsSearchModel>> getHashtags(
      {required String hashtag}) async {
    _response = await ApiHelper.get(
      ApiStringConstants.searchHashtags,
      querryParam: {'query': hashtag},
    );

    List<HashtagsSearchModel> hashtagsSearchModel = [];
    _response.data.forEach((element) {
      hashtagsSearchModel.add(HashtagsSearchModel.fromJson(element));
    });
    return hashtagsSearchModel;
  }

  static Future<List<LocationSearchModel>> getLocation(
      {required String location}) async {
    _response = await ApiHelper.get(
      ApiStringConstants.searchLocation,
      querryParam: {'query': location},
    );

    List<LocationSearchModel> locationList = [];
    _response.data.forEach((element) {
      locationList.add(LocationSearchModel.fromJson(element));
    });
    return locationList;
  }

  static Future<List<FeedThumbnail>> getFeedsMetadata(
      {required String metadata}) async {
    _response = await ApiHelper.get(
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
