import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/newFeedModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

class FeedServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<ApiResponse> createFeed({required FeedData postData}) async {
    _response = await _helper.post(
      ApiStringConstants.createFeed,
      querryParam: postData.toJson(),
    );
    log(_response.data.toString());
    return _response;
  }

  Future<List<FeedModel>> getFollowingFeeds() async {
    List<FeedModel> fetchedFeeds = [];
    _response = await _helper.get(ApiStringConstants.getFollowingFeed);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedModel.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  Future<FeedModel> getFeed({required String feedId}) async {
    _response = await _helper
        .get(ApiStringConstants.getFeedById, querryParam: {'feedId': feedId});

    return FeedModel.fromJson(_response.data);
  }

  Future<bool> toogleLikeFeeds({
    required String feedId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleLikeFeed,
        querryParam: {'feedId': feedId});
    return _response.success;
  }

  Future<String> toogleSaveFeeds({
    required String feedId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toogleSaveFeed,
        querryParam: {'feedId': feedId});
    return _response.data;
  }

  Future<List<User>> fetchFeedMentions({
    required String feedId,
  }) async {
    _response = await _helper.get(ApiStringConstants.fetchFeedsMentions,
        querryParam: {'feedId': feedId});
    List<User> fetchedUsers = [];
    if (_response.success == true) {
      for (var user in _response.data) {
        fetchedUsers.add(User.fromJson(user));
      }
    }
    return fetchedUsers;
  }

  Future<FeedComment> createComment(
      {required String content, required String feedId}) async {
    _response = await _helper.post(
      ApiStringConstants.createFeedComment,
      isPublic: false,
      querryParam: {'content': content, 'feedId': feedId},
    );
    return FeedComment.fromJson(_response.data['comment']);
  }

  Future<List<FeedComment>> fetchFeedComments({required String feedId}) async {
    List<FeedComment> fetchedComments = [];
    _response = await _helper.get(ApiStringConstants.fetchFeedComments,
        querryParam: {'feedId': feedId});

    if (_response.success == true) {
      for (int i = 0; i < _response.data.length; i++) {
        fetchedComments.add(FeedComment.fromJson(_response.data[i]));
      }
    }
    return fetchedComments;
  }

  Future<void> deleteFeed({required String feedId}) async {
    _response = await _helper.delete(
      ApiStringConstants.deleteFeeds,
      queryParam: {'feedId': feedId},
    );
    if (_response.success == true) {
      Fluttertoast.showToast(
        msg: "Feed Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<void> deleteFeedComment({required String commentId}) async {
    _response = await _helper.delete(
      ApiStringConstants.deleteFeedComment,
      queryParam: {'commentId': commentId},
    );
    if (_response.success == true) {
      Fluttertoast.showToast(
        msg: "Comment Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0,
      );
    }
  }

  Future<String> toggleFeedCommentLike({
    required String commentId,
  }) async {
    _response = await _helper.post(ApiStringConstants.toggleFeedCommentLike,
        querryParam: {'commentId': commentId});
    return _response.data;
  }

  Future<List<FeedThumbnail>> getSavedFeeds() async {
    List<FeedThumbnail> fetchedFeeds = [];
    _response = await _helper.get(ApiStringConstants.fetchAllSavedFeeds);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedThumbnail.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }

  Future<List<FeedComment>> fetchcommentReplies(
      {required String commentId}) async {
    List<FeedComment> fetchedComments = [];
    _response = await _helper.get(ApiStringConstants.fetchcommentReplies,
        querryParam: {'commentId': commentId});

    if (_response.success == true) {
      for (int i = 0; i < _response.data.length; i++) {
        fetchedComments.add(FeedComment.fromJson(_response.data[i]));
      }
    }
    return fetchedComments;
  }

  Future<FeedComment> createCommentReply(
      {required String content, required String commentId}) async {
    _response = await _helper.post(ApiStringConstants.createCommentReply,
        querryParam: {'commentId': commentId, 'content': content});
    return FeedComment.fromJson(_response.data);
  }

  Future<List<FeedThumbnail>> getLikedFeeds() async {
    List<FeedThumbnail> fetchedFeeds = [];
    _response = await _helper.get(ApiStringConstants.fetchAllLikedFeeds);
    if (_response.success == true) {
      for (var thread in _response.data) {
        fetchedFeeds.add(FeedThumbnail.fromJson(thread));
      }
    }
    return fetchedFeeds;
  }
}
