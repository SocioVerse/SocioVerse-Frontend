import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/followRequestModel.dart';

class FollowRequestsServices {
  static ApiResponse _response = ApiResponse();

  static Future<List<FollowRequestModel>> fetchAllFolloweRequests() async {
    _response = await ApiHelper.get(
      ApiStringConstants.fetchAllFolloweRequests,
      isPublic: false,
    );

    List<FollowRequestModel> followRequestList = [];
    if (_response.success) {
      for (var item in _response.data) {
        followRequestList.add(FollowRequestModel.fromJson(item));
      }
      return followRequestList;
    } else {
      return followRequestList;
    }
  }

  static Future<void> acceptFollowRequest(String id) async {
    _response = await ApiHelper.put(
      ApiStringConstants.acceptFollowRequest,
      querryParam: {
        "targetUserId": id,
      },
    );
  }

  static Future<void> rejectFollowRequest(String id) async {
    _response = await ApiHelper.delete(
      ApiStringConstants.rejectFollowRequest,
      queryParam: {
        "targetUserId": id,
      },
    );
  }
}
