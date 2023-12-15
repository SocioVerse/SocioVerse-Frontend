import 'package:socioverse/Models/searchedUser.dart';
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
}
