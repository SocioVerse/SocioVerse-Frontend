import 'dart:developer';

import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

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


  Future<void> createComment({required CreateThreadModel createThreadModel
  }) async {
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


  Future<void> deleteThread({required String threadId
  }) async {
    try {
      _response = await _helper.delete(
        ApiStringConstants.deleteThreads,
        querryParam: {'threadId': threadId},
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

 

}
