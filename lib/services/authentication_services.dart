import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Models/userSignUpModel.dart';

class AuthServices {
  static Future<ApiResponse> isEmailExists({required String email}) async {
    ApiResponse response = await ApiHelper.get(
      ApiStringConstants.isEmailExists,
      querryParam: {"email": email},
      isPublic: true,
    );
    return response;
  }

  static Future<ApiResponse?> userSignUp(
      {required SignupUser signupUser}) async {
    print(signupUser.toJson());
    ApiResponse? response = await ApiHelper.post(
      ApiStringConstants.userSignUp,
      querryParam: signupUser.toJson(),
      isPublic: true,
    );
    if (response.success) {
      UserSignUpModel user = UserSignUpModel.fromJson(response.data);
      setStringIntoCache(
          SharedPreferenceString.refreshToken, user.refreshToken);
      setStringIntoCache(SharedPreferenceString.email, user.email);
      setStringIntoCache(SharedPreferenceString.accessToken, user.accessToken);
      setBooleanIntoCache(SharedPreferenceString.isLoggedIn, true);
      setStringIntoCache(SharedPreferenceString.userId, user.id);
    }

    return response;
  }

  static Future<ApiResponse?> userLogin({required LoginUser loginUser}) async {
    print(loginUser.toJson().toString());
    ApiResponse? response = await ApiHelper.post(
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
      String at = await getStringFromCache(SharedPreferenceString.userId);
      log(at);
    }

    return response;
  }

  static Future<ApiResponse?> userLogout({required String? fcmToken}) async {
    ApiResponse? response = await ApiHelper.delete(
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

  static Future<ApiResponse?> generateOtp(bool isSignup,
      {required String email}) async {
    ApiResponse? response = await ApiHelper.get(
      querryParam: {"email": email, "isSignup": isSignup.toString()},
      ApiStringConstants.generateOtp,
      isPublic: true,
    );
    return response;
  }

  static Future<ApiResponse> verifyOtp(
      {required String email, required String otp}) async {
    ApiResponse response = await ApiHelper.get(
      ApiStringConstants.verifyOtp,
      querryParam: {"otp": otp, "email": email},
      isPublic: true,
    );
    return response;
  }
}
