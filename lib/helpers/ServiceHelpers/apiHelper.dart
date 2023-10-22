import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';
import 'package:socioverse/services/refresh_token_service.dart';
import 'package:http/http.dart' as http;

import '../ServiceHelpers/appExceptions.dart';
import '../SharedPreference/shared_preferences_constants.dart';

class ApiHelper {
  late ApiResponse _response;
  Future<dynamic> get(String path,
      {dynamic querryParam, bool isPublic = false}) async {
    Map<String, String>? headers;
    String token = await getStringFromCache(SharedPreferenceString.accessToken);
    log(token);
    if (!isPublic) headers = ({"Authorization": "Bearer $token"});
    try {
      Uri uri =
          Uri.https(ApiStringConstants.testBaseUrl, "/api/$path", querryParam);
      log(uri.toString());
      final response = await http.get(
        uri,
        headers: headers,
      );
      log(uri.toString());

      if (response.statusCode == 401) {
        print("here 1");
        String updatedToken = await RefreshToken().updateToken();

        log(updatedToken);
        final response = await http.get(
          uri,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $updatedToken"
          },
        );
        _response = _returnResponse(response, uri, querryParam);
      } else {
        print("here 2");
        print(response.statusCode);
        _response = _returnResponse(response, uri, querryParam);
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return _response;
  }

  ApiResponse _returnResponse(
      http.Response response, dynamic uri, dynamic? querryParam) {
    ApiResponse baseRes =
        ApiResponse.fromJson(json.decode(response.body.toString()));

    switch (response.statusCode) {
      case 200:
        dynamic msg = baseRes.message;

        return baseRes;
      case 400:
        dynamic msg = baseRes.message;
        return baseRes;
      case 401:
        throw UnauthorisedException("${uri}Url$querryParam${response.body}");
      case 403:
        throw UnauthorisedException("${uri}Url$querryParam${response.body}");
      case 500:
      //Todo ==> redirect
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<ApiResponse> post(String path,
      {dynamic querryParam, bool isPublic = false}) async {
    try {
      Uri uri = Uri.https(ApiStringConstants.testBaseUrl, "/api/$path");
      String token =
          await getStringFromCache(SharedPreferenceString.accessToken);
      Map<String, String>? headers;

      var response =
          await http.post(uri, body: jsonEncode(querryParam), headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "Authorization": "Bearer $token"
      });
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
        log(updatedToken);
        print(response.body);
        _response = _returnResponse(response, uri, querryParam);
      } else {
        print("here 2");
        print(response.body);
        print(response.statusCode);
        _response = _returnResponse(response, uri, querryParam);
      }
    } catch (e) {
      rethrow;
    }

    return _response;
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
      print(multipartReq.files.length);

      /// adding params to the request
      multipartReq.fields.addAll(queryParam ?? {});

      /// fetching response
      http.Response response =
          await http.Response.fromStream(await multipartReq.send());
      print(response.body);
      _response = await _returnResponse(response, uri, queryParam);
    } catch (e) {
      rethrow;
    }
    return _response;
  }

  Future<ApiResponse> postMultiPartWith2Files(String path,
      {Map<String, String>? queryParam,
      List<File>? files,
      File? file,
      String? fileParamName1,
      String? fileParamName2}) async {
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
              fileParamName1 ?? "", files![i].path);
          multipartReq.files.add(multipartFile);
        }
      }
      if (file != null) {
        var multipartFile =
            await http.MultipartFile.fromPath(fileParamName2 ?? "", file.path);
        multipartReq.files.add(multipartFile);
      }

      /// adding headers to the request
      multipartReq.headers.addAll(headers);
      print(multipartReq.files.length);

      /// adding params to the request
      multipartReq.fields.addAll(queryParam ?? {});

      /// fetching response
      http.Response response =
          await http.Response.fromStream(await multipartReq.send());
      print(queryParam);
      log(response.body);
      _response = await _returnResponse(response, uri, queryParam);
    } catch (e) {
      rethrow;
    }
    return _response;
  }
}
