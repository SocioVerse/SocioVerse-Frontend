import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Models/inboxModel.dart' as InboxModel;

class StoriesServices {
  ApiHelper _helper = ApiHelper();
  ApiResponse _response = ApiResponse();
  Future<ApiResponse> createStory({required List<String> images}) async {
    try {
      _response = await _helper.post(
        ApiStringConstants.createStory,
        isPublic: false,
        querryParam: {'images': images},
      );
      log(_response.data);
      return _response;
    } catch (e) {
      print(e);
      return _response;
    }
  }

  Future<List<ProfileStoryModel>> fetchAllStories() async {
    List<ProfileStoryModel> fetchedStories = [];
    _response = await _helper.get(ApiStringConstants.fetchAllStories);
    if (_response.success == true) {
      for (var story in _response.data) {
        fetchedStories.add(ProfileStoryModel.fromJson(story));
      }
    }
    return fetchedStories;
  }

  Future<User?> getUserByStoryId({required String storyId}) async {
    _response = await _helper.get(
      ApiStringConstants.getUserByStoryId,
      querryParam: {'story_id': storyId},
    );
    if (_response.success == false) {
      FlutterToast.flutterWhiteToast(_response.message);
      return null;
    }
    return User.fromJson(_response.data);
  }

  Future<List<ReadStoryModel>> getUserStory({required String userId}) async {
    List<ReadStoryModel> fetchedStories = [];
    _response = await _helper
        .get(ApiStringConstants.readStory, querryParam: {'user_id': userId});

    if (_response.success == true) {
      for (var story in _response.data) {
        fetchedStories.add(ReadStoryModel.fromJson(story));
      }
    }
    return fetchedStories;
  }

  Future<void> storySeen({required String storyId}) async {
    _response = await _helper.post(
      ApiStringConstants.storySeen,
      isPublic: false,
      querryParam: {'story_id': storyId},
    );
  }

  Future<void> toggleStoryLike({required String storyId}) async {
    _response = await _helper.post(
      ApiStringConstants.toggleStoryLike,
      isPublic: false,
      querryParam: {'story_id': storyId},
    );
  }

  Future<void> uploadStory({required List<String> storyImage}) async {
    _response = await _helper.post(
      ApiStringConstants.createStory,
      isPublic: false,
      querryParam: {'images': storyImage},
    );
  }

  Future<void> deleteStory({required String storyId}) async {
    _response = await _helper.delete(
      ApiStringConstants.deleteStory,
      isPublic: false,
      queryParam: {'story_id': storyId},
    );
  }

  Future<StorySeensModel> getStorySeens({required String storyId}) async {
    _response = await _helper.get(
      ApiStringConstants.fetchAllStorySeen,
      querryParam: {'story_id': storyId},
    );
    return StorySeensModel.fromJson(_response.data);
  }

  Future<void> hideStory({required String userId}) async {
    _response = await _helper.post(
      ApiStringConstants.hideStory,
      isPublic: false,
      querryParam: {'hideFrom': userId},
    );
    FlutterToast.flutterWhiteToast("Story Hidden");
  }

  Future<void> unhideStory({required String userId}) async {
    _response = await _helper.post(
      ApiStringConstants.unhideStory,
      isPublic: false,
      querryParam: {'unhideFrom': userId},
    );
    FlutterToast.flutterWhiteToast("Story Unhidden");
  }

  Future<List<InboxModel.User>> fetchAllStoryHiddenUsers() async {
    List<InboxModel.User> fetchedUsers = [];
    _response = await _helper.get(ApiStringConstants.fetchAllStoryHiddenUsers);
    if (_response.success == true) {
      log("Hidden Users ${fetchedUsers.length} ${_response.data}");
      for (var user in _response.data) {
        fetchedUsers.add(InboxModel.User.fromJson(user));
      }
    }
    return fetchedUsers;
  }
}
