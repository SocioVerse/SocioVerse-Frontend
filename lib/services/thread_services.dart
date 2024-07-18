import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
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
      log(_response.data.toString());
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

  Future<bool> toggleLikeThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toggleLikeThread,
        querryParam: {'threadId': threadId});
    return _response.success;
  }

  Future<String> toggleSaveThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toggleSaveThread,
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

  Future<String> toggleRepostThreads({
    required String threadId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toggleRepostThread,
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

  Future<ThreadModel?> getThreadById({required String threadId}) async {
    _response = await _helper.get(ApiStringConstants.getThreadById,
        querryParam: {'threadId': threadId});
    if (_response.success == false) {
      FlutterToast.flutterWhiteToast(_response.message);
      return null;
    }
    return ThreadModel.fromJson(_response.data);
  }

  Future<List<User>> fetchThreadLikes({
    required String threadId,
  }) async {
    _response = await _helper.get(ApiStringConstants.fetchThreadLikes,
        querryParam: {'threadId': threadId});
    List<User> fetchedUsers = [];
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  Future<List<ThreadModel>> getTrendingThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await _helper.get(ApiStringConstants.fetchTrendingThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }
}
