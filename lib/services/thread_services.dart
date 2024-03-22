import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/threadModel.dart';

class ThreadServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<ApiResponse> createThread(
      {required CreateThreadModel createThreadModel}) async {
    try {
      _response = await _helper.post(
        ApiStringConstants.createThread,
        isPublic: false,
        querryParam: createThreadModel.toJson(),
      );
      log(_response.data);
      return _response;
    } catch (e) {
      print(e);
      return _response;
    }
  }

  Future<List<ThreadModel>> getFollowingThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await _helper.get(ApiStringConstants.getFollowingThread);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  Future<bool> toogleLikeThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleLikeThread,
        querryParam: {'threadId': threadId});
    return _response.success;
  }

  Future<String> toogleSaveThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleSaveThread,
        querryParam: {'threadId': threadId});
    return _response.data;
  }

  Future<void> createComment(
      {required CreateThreadModel createThreadModel}) async {
    try {
      _response = await _helper.post(
        ApiStringConstants.createComment,
        isPublic: false,
        querryParam: createThreadModel.toJson(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteThread({required String threadId}) async {
    log("here2");
    try {
      _response = await _helper.delete(
        ApiStringConstants.deleteThreads,
        queryParam: {'threadId': threadId},
      );
    } catch (e) {
      print(e);
    }
  }

  Future<String> toogleRepostThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleRepostThread,
        querryParam: {'threadId': threadId});
    return _response.data;
  }

  Future<List<ThreadModel>> getSavedThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await _helper.get(ApiStringConstants.fetchAllSavedThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  Future<List<ThreadModel>> getLikedThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await _helper.get(ApiStringConstants.fetchAllLikedThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }
}
