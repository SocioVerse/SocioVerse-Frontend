import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/commentModel.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/newFeedModels.dart';
import 'package:socioverse/Models/inboxModel.dart' as inbox;

class FeedServices {
  static ApiResponse _response = ApiResponse();
  static Future<ApiResponse> createFeed({required FeedData postData}) async {
    _response = await ApiHelper.post(
      ApiStringConstants.createFeed,
      querryParam: postData.toJson(),
    );
    log(_response.data.toString());
    return _response;
  }

  static Future<List<FeedModel>> getFollowingFeeds() async {
    List<FeedModel> fetchedFeeds = [];
    _response = await ApiHelper.get(ApiStringConstants.getFollowingFeed);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedModel.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  static Future<FeedModel?> getFeed({required String feedId}) async {
    _response = await ApiHelper.get(ApiStringConstants.getFeedById,
        querryParam: {'feedId': feedId});
    if (_response.success == false) {
      FlutterToast.flutterWhiteToast(_response.message);
      return null;
    }
    return FeedModel.fromJson(_response.data);
  }

  static Future<bool> toggleLikeFeeds({
    required String feedId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleLikeFeed,
        querryParam: {'feedId': feedId});
    return _response.success;
  }

  static Future<String> toggleSaveFeeds({
    required String feedId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleSaveFeed,
        querryParam: {'feedId': feedId});
    return _response.data;
  }

  static Future<List<User>> fetchFeedMentions({
    required String feedId,
  }) async {
    _response = await ApiHelper.get(ApiStringConstants.fetchFeedsMentions,
        querryParam: {'feedId': feedId});
    List<User> fetchedUsers = [];
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  static Future<List<User>> fetchFeedLikes({
    required String feedId,
  }) async {
    _response = await ApiHelper.get(ApiStringConstants.fetchFeedLikes,
        querryParam: {'feedId': feedId});
    List<User> fetchedUsers = [];
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  static Future<FeedComment> createComment(
      {required String content, required String feedId}) async {
    _response = await ApiHelper.post(
      ApiStringConstants.createFeedComment,
      isPublic: false,
      querryParam: {'content': content, 'feedId': feedId},
    );
    return FeedComment.fromJson(_response.data['comment']);
  }

  static Future<List<FeedComment>> fetchFeedComments(
      {required String feedId}) async {
    List<FeedComment> fetchedComments = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchFeedComments,
        querryParam: {'feedId': feedId});

    if (_response.success == true) {
      for (int i = 0; i < _response.data.length; i++) {
        fetchedComments.add(FeedComment.fromJson(_response.data[i]));
      }
    }
    return fetchedComments;
  }

  static Future<void> deleteFeed({required String feedId}) async {
    _response = await ApiHelper.delete(
      ApiStringConstants.deleteFeeds,
      queryParam: {'feedId': feedId},
    );
    if (_response.success == true) {
      FlutterToast.flutterWhiteToast("Feed Deleted Successfully");
    }
  }

  static Future<void> deleteFeedComment({required String commentId}) async {
    _response = await ApiHelper.delete(
      ApiStringConstants.deleteFeedComment,
      queryParam: {'commentId': commentId},
    );
    if (_response.success == true) {
      FlutterToast.flutterWhiteToast("Comment Deleted Successfully");
    }
  }

  static Future<String> toggleFeedCommentLike({
    required String commentId,
  }) async {
    _response = await ApiHelper.post(ApiStringConstants.toggleFeedCommentLike,
        querryParam: {'commentId': commentId});
    return _response.data;
  }

  static Future<List<FeedThumbnail>> getSavedFeeds() async {
    List<FeedThumbnail> fetchedFeeds = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchAllSavedFeeds);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedThumbnail.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  static Future<List<FeedComment>> fetchcommentReplies(
      {required String commentId}) async {
    List<FeedComment> fetchedComments = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchcommentReplies,
        querryParam: {'commentId': commentId});

    if (_response.success == true) {
      for (int i = 0; i < _response.data.length; i++) {
        fetchedComments.add(FeedComment.fromJson(_response.data[i]));
      }
    }
    return fetchedComments;
  }

  static Future<FeedComment> createCommentReply(
      {required String content, required String commentId}) async {
    _response = await ApiHelper.post(ApiStringConstants.createCommentReply,
        querryParam: {'commentId': commentId, 'content': content});
    return FeedComment.fromJson(_response.data);
  }

  static Future<List<FeedThumbnail>> getLikedFeeds() async {
    List<FeedThumbnail> fetchedFeeds = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchAllLikedFeeds);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedThumbnail.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  static Future<List<FeedModel>> getTrendingFeeds() async {
    List<FeedModel> fetchedFeeds = [];
    _response = await ApiHelper.get(ApiStringConstants.fetchTrendingFeeds);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedModel.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  static Future<FeedComment> fetchCommentById(
      {required String commentId}) async {
    _response = await ApiHelper.get(ApiStringConstants.fetchCommentById,
        querryParam: {'commentId': commentId});
    return FeedComment.fromJson(_response.data);
  }
}
