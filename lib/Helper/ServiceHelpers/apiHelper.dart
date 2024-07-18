import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Services/refresh_token_service.dart';
import 'apiResponse.dart';
import 'package:http/http.dart' as http;
import '../ServiceHelpers/appExceptions.dart';

class ApiHelper {
  late ApiResponse _response;
  Future<dynamic> get(String path,
      {dynamic querryParam, bool isPublic = false}) async {
    Map<String, String>? headers;
    String token = await getStringFromCache(SharedPreferenceString.accessToken);

    if (!isPublic) headers = ({"Authorization": "Bearer $token"});
    try {
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path", querryParam);
      log(uri.toString());
      final response = await http.get(
        uri,
        headers: headers,
      );

      if (response.statusCode == 401) {
        String? updatedToken = await RefreshToken().updateToken();
        if (updatedToken == null) return null;
        final response = await http.get(
          uri,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $updatedToken"
          },
        );
        _response = _returnResponse(response, uri, querryParam);
      } else {
        _response = _returnResponse(response, uri, querryParam);
      }
    } catch (e) {
      log(e.toString());
    }

    return _response;
  }

  ApiResponse _returnResponse(
      http.Response response, dynamic uri, dynamic querryParam) {
    ApiResponse baseRes =
        ApiResponse.fromJson(json.decode(response.body.toString()));
    log(baseRes.toJson().toString());

    switch (response.statusCode) {
      case 200:
        dynamic msg = baseRes.message;

        return baseRes;
      case 400:
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
    try {
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path");
      log(uri.toString());
      String token =
          await getStringFromCache(SharedPreferenceString.accessToken);
      Map<String, String>? headers;
      if (!isPublic) headers = ({"Authorization": "Bearer $token"});
      if (!isPublic) headers = await GetContentType(headers);
      if (isPublic) headers = {'Content-Type': 'application/json'};
      log(querryParam.toString());
      var response =
          await http.post(uri, body: jsonEncode(querryParam), headers: headers);
      if (response.statusCode == 401) {
        headers = null;
        String? updatedToken = await RefreshToken().updateToken();

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
    } catch (e) {
      log(e.toString());
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
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path");
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
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path");
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
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path");
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
        String? updatedToken = await RefreshToken().updateToken();

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

  Future<dynamic> delete(String path,
      {dynamic queryParam, bool isPublic = false}) async {
    Map<String, String>? headers;
    String token = await getStringFromCache(SharedPreferenceString.accessToken);

    if (!isPublic) headers = ({"Authorization": "Bearer $token"});
    try {
      Uri uri = Uri.http(ApiStringConstants.baseUrl, "/api/$path", queryParam);
      final response = await http.delete(
        uri,
        headers: headers,
      );

      if (response.statusCode == 401) {
        String? updatedToken = await RefreshToken().updateToken();

        final response = await http.delete(
          uri,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: "Bearer $updatedToken"
          },
        );
        return _returnResponse(response, uri, queryParam);
      } else {
        return _returnResponse(response, uri, queryParam);
      }
    } catch (e) {
      // Handle errors here
      return null;
    }
  }
}
