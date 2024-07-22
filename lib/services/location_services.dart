import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/locationModel.dart';

class LocationServices {
  static ApiResponse _response = ApiResponse();
  static Future<List<LocationSearchModel>> getLocation(
      {required String location}) async {
    _response = await ApiHelper.get(
      ApiStringConstants.searchFeedsLocation,
      querryParam: {'query': location},
    );

    List<LocationSearchModel> locationList = [];
    _response.data.forEach((element) {
      locationList.add(LocationSearchModel.fromJson(element));
    });
    return locationList;
  }

  static Future<List<FeedThumbnail>> getLocationFeed(
      {required String locationId, required bool isRecent}) async {
    _response = await ApiHelper.get(
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
