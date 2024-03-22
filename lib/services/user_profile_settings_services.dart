import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';

class UserProfileSettingsServices {
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
