import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class UserProfileSettingsServices{
  final ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();

  Future<ApiResponse> updateProfile(UserProfileDetailsModelUser user) async {

    _response = await _helper.put(
      ApiStringConstants.updateProfile,
      querryParam: user.toJson(),
    );
    return _response;
  }
}