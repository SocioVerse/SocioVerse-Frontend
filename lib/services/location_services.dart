import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/locationModel.dart';

class LocationServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<List<LocationSearchModel>> getLocation(
      {required String location}) async {
    _response = await _helper.get(
      ApiStringConstants.searchFeedsLocation,
      querryParam: {'query': location},
    );

    List<LocationSearchModel> locationList = [];
    _response.data.forEach((element) {
      locationList.add(LocationSearchModel.fromJson(element));
    });
    return locationList;
  }

  Future<List<FeedThumbnail>> getLocationFeed(
      {required String locationId, required bool isRecent}) async {
    _response = await _helper.get(
      ApiStringConstants.fetchLocationFeed,
      querryParam: {'locationID': locationId, 'isRecent': isRecent.toString()},
    );

    List<FeedThumbnail> feedThumbnail = [];
    _response.data.forEach((element) {
      feedThumbnail.add(FeedThumbnail.fromJson(element));
    });
    return feedThumbnail;
  }
}
