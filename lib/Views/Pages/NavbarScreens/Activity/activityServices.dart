import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class ActivityServices{
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