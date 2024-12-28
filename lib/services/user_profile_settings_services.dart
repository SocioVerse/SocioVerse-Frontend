import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';

class UserProfileSettingsServices {
  static ApiResponse _response = ApiResponse();

  static Future<ApiResponse> updateProfile(
      UserProfileDetailsModelUser user, String? faceImage) async {
    user.toJson().addAll({
      'face_image_dataset': faceImage,
    });
    _response = await ApiHelper.put(
      ApiStringConstants.updateProfile,
      querryParam: {
        ...user.toJson(),
        'face_image_dataset': faceImage,
      },
    );
    return _response;
  }
}
