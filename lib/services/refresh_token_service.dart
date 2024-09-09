import 'package:flutter/material.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/main.dart';

class RefreshToken {
 static Future<String?> updateToken() async {
    String token =
        await getStringFromCache(SharedPreferenceString.refreshToken);
    print("here 5");
    ApiResponse response = await ApiHelper.post(ApiStringConstants.refreshToken,
        querryParam: {"refresh_token": token}, isPublic: true);
    if (response.success == false) {
      setStringIntoCache(SharedPreferenceString.accessToken, null);
      setBooleanIntoCache(SharedPreferenceString.isLoggedIn, false);
      setStringIntoCache(SharedPreferenceString.refreshToken, null);
      setStringIntoCache(SharedPreferenceString.userId, null);
      FlutterToast.flutterWhiteToast("Session Expired");
      NavigationService.navigationKey.currentState!.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => GetInitPage(),
          ),
          (route) => false);
      return null;
    }
    print("here 3");
    setStringIntoCache(
        SharedPreferenceString.refreshToken, response.data["refresh_token"]);
    setStringIntoCache(
        SharedPreferenceString.accessToken, response.data["access_token"]);
    SocketHelper.socketHelper.dispose();
    await SocketHelper.initSocketIO();
    return response.data["access_token"];
  }

  static Future<Map<String, String>> GetContentType(dynamic header, CTtype) async {
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
