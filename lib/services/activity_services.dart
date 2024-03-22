import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/activityModels.dart';

class ActivityServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<LatestFollowRequestModel> fetchLatestFolloweRequests() async {
    _response = await _helper.get(
      ApiStringConstants.fetchLatestFolloweRequests,
      isPublic: false,
    );
    return LatestFollowRequestModel.fromJson(_response.data);
  }
}
