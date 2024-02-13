import 'dart:developer';

import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/newFeedModels.dart';
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

  // Future<bool> toogleLikeFeeds({
  //   required String threadId,
  // }) async {
  //   _response = await _helper.post(ApiStringConstants.toogleLikeFeed,
  //       querryParam: {'threadId': threadId});
  //   return _response.success;
  // }

  // Future<String> toogleSaveFeeds({
  //   required String threadId,
  // }) async {
  //   _response = await _helper.post(ApiStringConstants.toogleSaveFeed,
  //       querryParam: {'threadId': threadId});
  //   return _response.data;
  // }

  // Future<void> createComment(
  //     {required CreateFeedModel createFeedModel}) async {
  //   try {
  //     _response = await _helper.post(
  //       ApiStringConstants.createComment,
  //       isPublic: false,
  //       querryParam: createFeedModel.toJson(),
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future<void> deleteFeed({required String feedId}) async {
    // log("here2");
    // try {
    //   _response = await _helper.delete(
    //     ApiStringConstants.deleteFeeds,
    //     queryParam: {'threadId': threadId},
    //   );
    // } catch (e) {
    //   print(e);
    // }
  }

  // Future<String> toogleRepostFeeds({
  //   required String threadId,
  // }) async {
  //   _response = await _helper.post(ApiStringConstants.toogleRepostFeed,
  //       querryParam: {'threadId': threadId});
  //   return _response.data;
  // }

  // Future<List<FeedModel>> getSavedFeeds() async {
  //   List<FeedModel> fetchedFeeds = [];
  //   _response = await _helper.get(ApiStringConstants.fetchAllSavedFeeds);
  //   if (_response.success == true) {
  //     for (var thread in _response.data) {
  //       fetchedFeeds.add(FeedModel.fromJson(thread));
  //     }
  //   }
  //   return fetchedFeeds;
  // }

  // Future<List<FeedModel>> getLikedFeeds() async {
  //   List<FeedModel> fetchedFeeds = [];
  //   _response = await _helper.get(ApiStringConstants.fetchAllLikedFeeds);
  //   if (_response.success == true) {
  //     for (var thread in _response.data) {
  //       fetchedFeeds.add(FeedModel.fromJson(thread));
  //     }
  //   }
  //   return fetchedFeeds;
  // }
}
