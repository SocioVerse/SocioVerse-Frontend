import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';
import 'package:socioverse/services/refresh_token_service.dart';
import 'apiResponse.dart';
import 'package:http/http.dart' as http;

import '../ServiceHelpers/appExceptions.dart';

class ApiHelper {
  late ApiResponse _response;
  bool internetConnected = false;
  Future<dynamic> get(String path,
      {dynamic querryParam, bool isPublic = false}) async {
    Map<String, String>? headers;
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    await checkInternet();
    if (internetConnected) {
      try {
        await getRequest(path, querryParam, token);
      } catch (e) {}
    } else {
      // getD.Get.to(() => NoInternetScreen());
      // if (!(getD.Get.isBottomSheetOpen ?? false)) {
      //   await getD.Get.bottomSheet(
      //       Container(
      //         color:  Colors.white,
      //           child: Column(
      //             children: [
      //               Expanded(
      //                   child:
      //                       Image.asset("assets/no_internet/no-conexion.png")),
      //
      //             ],
      //           )),
      //       isDismissible: false);
      // }
    }

    return _response;
  }

  Future<void> getRequest(String path, querryParam, String token) async {
    Uri uri =
        Uri.https(ApiStringConstants.testBaseUrl, "/api/$path", querryParam);
    final response = await http.get(
      uri,
      headers: {"Authorization": "Bearer $token"},
    );

    if (response.statusCode == 401) {
      String updatedToken = await RefreshToken().updateToken();

      final response = await http.get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $updatedToken"
        },
      );
    }
    _response = _returnResponse(response, uri, querryParam);

    print(_response.toJson());
  }

  ApiResponse _returnResponse(
      http.Response response, dynamic uri, dynamic querryParam) {
    ApiResponse baseRes =
        ApiResponse.fromJson(json.decode(response.body.toString()));
    print(baseRes.toJson());
    switch (response.statusCode) {
      case 200:
        dynamic msg = baseRes.message;
        print(baseRes.toJson());
        return baseRes;
      case 400:
        dynamic msg = baseRes.message;
        return baseRes;
      case 403:
        dynamic msg = baseRes.message;
        return baseRes;
      case 401:
      // throw UnauthorisedException("${uri}Url$querryParam${response.body}");
      case 403:
        throw UnauthorisedException("${uri} Url $querryParam${response.body}");
      case 500:
      //Todo ==> redirect
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }

  Future<ApiResponse> post(String path,
      {dynamic querryParam, bool isPublic = false}) async {
    Uri uri = Uri.https(ApiStringConstants.testBaseUrl, "/api/$path");
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    await checkInternet();
    if (internetConnected) {
      try {
        await postRequest(isPublic, token, uri, querryParam);
      } catch (e) {}
    } else {
      // getD.Get.to(() => NoInternetScreen());
    }
    return _response;
  }

  Future<void> postRequest(
      bool isPublic, String token, Uri uri, querryParam) async {
    Map<String, String>? headers;
    if (!isPublic) headers = ({"Authorization": "Bearer $token"});
    if (!isPublic) headers = await GetContentType(headers);
    if (isPublic) headers = {'Content-Type': 'application/json'};

    var response =
        await http.post(uri, body: jsonEncode(querryParam), headers: headers);

    if (response.statusCode == 401) {
      headers = null;
      String updatedToken = await RefreshToken().updateToken();

      var response = await http.post(
        uri,
        body: jsonEncode(querryParam),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $updatedToken"
        },
      );
      _response = _returnResponse(response, uri, querryParam);
    } else {
      _response = _returnResponse(response, uri, querryParam);
    }
  }

  Future<Map<String, String>> GetContentType(dynamic header) async {
    dynamic contentType;
    contentType = {'Content-Type': 'application/json'};

    header.addAll(contentType);
    return header;
  }

  Future<ApiResponse> postMultiPart(String path,
      {Map<String, String>? queryParam,
      List<File>? files,
      String? fileParamName}) async {
    try {
      Uri uri = Uri.https(ApiStringConstants.testBaseUrl, "/api/$path");
      String token =
          await getStringFromCache(SharedPreferenceString.accessToken);
      Map<String, String>? headers;
      headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      // headers = {
      //   "Authorization": "Bearer $token",
      //   'Content-Type': 'application/json'
      // };

      /// creating the request
      var multipartReq = new http.MultipartRequest("POST", uri);

      /// creating multipartFile from the fileParam map
      // if (fileParam != null) {
      //   fileParam.forEach((key, file) async {
      //     http.MultipartFile multiPartFile = await http.MultipartFile.fromPath("$key", file.filePath);
      //     multipartReq.files.add(multiPartFile);
      //   });
      // }

      if (files != []) {
        for (int i = 0; i < (files?.length ?? 0); i++) {
          var multipartFile = await http.MultipartFile.fromPath(
              fileParamName ?? "", files![i].path);
          multipartReq.files.add(multipartFile);
        }
      }

      /// adding headers to the request
      multipartReq.headers.addAll(headers);
      print(queryParam);

      /// adding params to the request
      multipartReq.fields.addAll(queryParam ?? {});

      /// fetching response
      http.Response response =
          await http.Response.fromStream(await multipartReq.send());
      _response = await _returnResponse(response, uri, queryParam);
    } catch (e) {
      rethrow;
    }
    return _response;
  }

  Future<ApiResponse> putMultiPart(String path,
      {Map<String, String>? queryParam,
      List<File>? files,
      String? fileParamName}) async {
    try {
      Uri uri = Uri.https(ApiStringConstants.testBaseUrl, "/api/$path");
      String token =
          await getStringFromCache(SharedPreferenceString.accessToken);
      Map<String, String>? headers;
      headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      // headers = {
      //   "Authorization": "Bearer $token",
      //   'Content-Type': 'application/json'
      // };

      /// creating the request
      var multipartReq = new http.MultipartRequest("PUT", uri);

      /// creating multipartFile from the fileParam map
      // if (fileParam != null) {
      //   fileParam.forEach((key, file) async {
      //     http.MultipartFile multiPartFile = await http.MultipartFile.fromPath("$key", file.filePath);
      //     multipartReq.files.add(multiPartFile);
      //   });
      // }

      if (files != []) {
        for (int i = 0; i < (files?.length ?? 0); i++) {
          var multipartFile = await http.MultipartFile.fromPath(
              fileParamName ?? "", files![i].path);
          multipartReq.files.add(multipartFile);
        }
      }

      /// adding headers to the request
      multipartReq.headers.addAll(headers);

      /// adding params to the request
      multipartReq.fields.addAll(queryParam ?? {});

      /// fetching response
      http.Response response =
          await http.Response.fromStream(await multipartReq.send());
      print(multipartReq.fields);
      _response = await _returnResponse(response, uri, queryParam);
    } catch (e) {
      rethrow;
    }
    return _response;
  }

  Future<ApiResponse> put(String path, {dynamic querryParam}) async {
    try {
      Uri uri = Uri.https(ApiStringConstants.testBaseUrl, "/api/$path");
      String token =
          await getStringFromCache(SharedPreferenceString.accessToken);
      Map<String, String>? _headers;
      _headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };
      var response =
          await http.put(uri, headers: _headers, body: jsonEncode(querryParam));
      if (response.statusCode == 401) {
        String updatedToken = await RefreshToken().updateToken();

        var response = await http.put(
          uri,
          body: jsonEncode(querryParam),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $updatedToken"
          },
        );

        _response = _returnResponse(response, uri, querryParam);
      } else {
        _response = _returnResponse(response, uri, querryParam);
      }

      // _response = _returnResponse(response, uri, querryParam);
    } catch (e) {}

    return _response;
  }

  checkInternet() async {
    await execute(InternetConnectionChecker());

    // Create customized instance which can be registered via dependency injection
    final InternetConnectionChecker customInstance =
        InternetConnectionChecker.createInstance(
      checkTimeout: const Duration(seconds: 1),
      checkInterval: const Duration(seconds: 1),
    );

    // Check internet connection with created instance
    await execute(
      customInstance,
    );
  }

  Future<void> execute(
    InternetConnectionChecker internetConnectionChecker,
  ) async {
    // Simple check to see if we have Internet
    // ignore: avoid_print
    final bool isConnected = await InternetConnectionChecker().hasConnection;
    // ignore: avoid_print

    // returns a bool

    // We can also get an enum instead of a bool
    // ignore: avoid_print
    InternetConnectionStatus status =
        await InternetConnectionChecker().connectionStatus;
    if (status == InternetConnectionStatus.disconnected) {
      internetConnected = false;
    } else {
      internetConnected = true;
    }

    // Prints either InternetConnectionStatus.connected
    // or InternetConnectionStatus.disconnected

    // actively listen for status updates
    final StreamSubscription<InternetConnectionStatus> listener =
        InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            // ignore: avoid_print
            internetConnected = true;
            break;
          case InternetConnectionStatus.disconnected:
            // ignore: avoid_print
            internetConnected = false;
            break;
        }
      },
    );
    // // close listener after 30 seconds, so the program doesn't run forever
    await listener.cancel();
  }
}
