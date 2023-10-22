import 'dart:developer';
import 'dart:io';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';

class AuthServices {
  final ApiHelper _helper = ApiHelper();
  Future<bool> isEmailExists({required String email}) async {
    ApiResponse response = await _helper.get(
      ApiStringConstants.isEmailExists,
      querryParam: {"email": email},
      isPublic: true,
    );
    log(response.data.toString());
    return response.data["email_exists"];
  }
  Future<bool> userSignUp({required File? Image,required String email,required String password,required String fullName,required String username,required String phone,required String occupation,required String cCode,required String face_image_dataset
  }) async {
    ApiResponse response = await _helper.post(
      ApiStringConstants.userSignUp,
      querryParam: {
        "email": email,
        "password": password,
        "full_name": fullName,
        "username": username,
        "phone": phone,
        "occupation": occupation,
        "country_code": cCode,
      },
      isPublic: true,
    );
    log(response.data.toString());
    if (response.data["success"]) {
      setStringIntoCache(SharedPreferenceString.refreshToken, response.data["refresh_token"]);
      setStringIntoCache(SharedPreferenceString.accessToken, response.data["access_token"]);
      setBooleanIntoCache(SharedPreferenceString.isLoggedIn,true);

      return true;
    } else {
      return false;
    }

    
  }
  
}
