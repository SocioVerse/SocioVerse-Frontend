import 'dart:developer';

import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/helpers/api_constants.dart';

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

  Future<void> toogleStoryLike({required String storyId}) async {
    _response = await _helper.post(
      ApiStringConstants.toogleStoryLike,
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
}
