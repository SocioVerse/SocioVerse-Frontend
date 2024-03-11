import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Models/userSignUpModel.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';

class AuthServices {
  final ApiHelper _helper = ApiHelper();
  Future<ApiResponse> isEmailExists({required String email}) async {
    ApiResponse response = await _helper.get(
      ApiStringConstants.isEmailExists,
      querryParam: {"email": email},
      isPublic: true,
    );
    return response;
  }

  Future<ApiResponse?> userSignUp({required SignupUser signupUser}) async {
    print(signupUser.toJson());
    ApiResponse? response = await _helper.post(
      ApiStringConstants.userSignUp,
      querryParam: signupUser.toJson(),
      isPublic: true,
    );
    if (response.success) {
      UserSignUpModel user = UserSignUpModel.fromJson(response.data);
      setStringIntoCache(
          SharedPreferenceString.refreshToken, user.refreshToken);
      setStringIntoCache(SharedPreferenceString.accessToken, user.accessToken);
      setBooleanIntoCache(SharedPreferenceString.isLoggedIn, true);
      setStringIntoCache(SharedPreferenceString.userId, user.id);
    }

    return response;
  }

  Future<ApiResponse?> userLogin({required LoginUser loginUser}) async {
    print(loginUser.toJson().toString());
    ApiResponse? response = await _helper.post(
      ApiStringConstants.userLogin,
      querryParam: loginUser.toJson(),
      isPublic: true,
    );
    if (response.success) {
      UserSignUpModel user = UserSignUpModel.fromJson(response.data);
      setStringIntoCache(
          SharedPreferenceString.refreshToken, user.refreshToken);
      setStringIntoCache(SharedPreferenceString.accessToken, user.accessToken);
      setBooleanIntoCache(SharedPreferenceString.isLoggedIn, true);
      setStringIntoCache(SharedPreferenceString.userId, user.id);
      String at = await getStringFromCache(SharedPreferenceString.accessToken);
      log(at);
    }

    return response;
  }

  Future<ApiResponse?> userLogout({required String? fcmToken}) async {
    ApiResponse? response = await _helper.delete(
      ApiStringConstants.userLogout,
      queryParam: {"fcm_token": fcmToken},
      isPublic: false,
    );
    setStringIntoCache(SharedPreferenceString.accessToken, null);
    setBooleanIntoCache(SharedPreferenceString.isLoggedIn, false);
    setStringIntoCache(SharedPreferenceString.refreshToken, null);
    setStringIntoCache(SharedPreferenceString.userId, null);

    return response;
  }
}
