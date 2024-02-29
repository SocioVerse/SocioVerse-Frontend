import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

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
}
