import 'package:socioverse/Views/Pages/NavbarScreens/Activity/FollowRequests/followRequestModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class FollowRequestsServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<List<FollowRequestModel>> fetchAllFolloweRequests() async {
    _response = await _helper.get(
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

  Future<void> acceptFollowRequest(String id) async {
    _response = await _helper.put(
      ApiStringConstants.acceptFollowRequest,
      querryParam: {
        "targetUserId": id,
      },
    );
  }

  Future<void> rejectFollowRequest(String id) async {
    _response = await _helper.delete(
      ApiStringConstants.rejectFollowRequest,
      querryParam: {
        "targetUserId": id,
      },
    );
  }
}
