import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Models/userSignUpModel.dart';

class RefreshToken {
  final ApiHelper _helper = ApiHelper();
  Future<String> updateToken() async {
    String token =
        await getStringFromCache(SharedPreferenceString.refreshToken);
    print("here 5");
    ApiResponse response = await _helper.post(ApiStringConstants.refreshToken,
        querryParam: {"refresh_token": token}, isPublic: true);
    print("here 3");
    setStringIntoCache(
        SharedPreferenceString.refreshToken, response.data["refresh_token"]);
    setStringIntoCache(
        SharedPreferenceString.accessToken, response.data["access_token"]);
    return response.data["access_token"];
  }

  Future<Map<String, String>> GetContentType(dynamic header, CTtype) async {
    dynamic contentType;
    switch (CTtype) {
      case ContentType.Text:
        contentType = {'Content-Type': 'text/plain'};
        break;
      default:
        contentType = {'Content-Type': 'application/json'};
    }
    header.addAll(contentType);
    return header;
  }
}

enum ContentType { Json, Text }
