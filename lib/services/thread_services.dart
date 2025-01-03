import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/threadModel.dart';

class ThreadServices {
  static ApiResponse _response = ApiResponse();
  static Future<ApiResponse> createThread(
      {required CreateThreadModel createThreadModel}) async {
    try {
      _response = await ApiHelper.post(
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

  static Future<List<ThreadModel>> getFollowingThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await ApiHelper.get(ApiStringConstants.getFollowingThread);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  static Future<bool> toggleLikeThreads({
    required String threadId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleLikeThread,
        querryParam: {'threadId': threadId});
    return _response.success;
  }

  static Future<String> toggleSaveThreads({
    required String threadId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleSaveThread,
        querryParam: {'threadId': threadId});
    return _response.data;
  }

  static Future<void> createComment(
      {required CreateThreadModel createThreadModel}) async {
    try {
      _response = await ApiHelper.post(
        ApiStringConstants.createComment,
        isPublic: false,
        querryParam: createThreadModel.toJson(),
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> deleteThread({required String threadId}) async {
    log("here2");
    try {
      _response = await ApiHelper.delete(
        ApiStringConstants.deleteThreads,
        queryParam: {'threadId': threadId},
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<String> toggleRepostThreads({
    required String threadId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleRepostThread,
        querryParam: {'threadId': threadId});
    return _response.data;
  }

  static Future<List<ThreadModel>> getSavedThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchAllSavedThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  static Future<List<ThreadModel>> getLikedThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchAllLikedThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }

  static Future<ThreadModel?> getThreadById({required String threadId}) async {
    _response = await ApiHelper.get(ApiStringConstants.getThreadById,
        querryParam: {'threadId': threadId});
    if (_response.success == false) {
      FlutterToast.flutterWhiteToast(_response.message);
      return null;
    }
    return ThreadModel.fromJson(_response.data);
  }

  static Future<List<User>> fetchThreadLikes({
    required String threadId,
  }) async {
    _response = await ApiHelper.get(ApiStringConstants.fetchThreadLikes,
        querryParam: {'threadId': threadId});
    List<User> fetchedUsers = [];
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  static Future<List<ThreadModel>> getTrendingThreads() async {
    List<ThreadModel> fetchedThreads = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchTrendingThreads);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedThreads.add(ThreadModel.fromJson(thread));
      }
    }
    return fetchedThreads;
  }
}
