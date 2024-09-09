import 'dart:developer';

import 'package:socioverse/Helper/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Helper/api_constants.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Models/feedActivityModels.dart';
import 'package:socioverse/Models/mentionActivity.dart';
import 'package:socioverse/Models/storyLikeActivity.dart';
import 'package:socioverse/Models/threadActivityModel.dart';
import 'package:socioverse/Models/threadCommentsActivityModel.dart';
import 'package:socioverse/Services/feedCommentActivity.dart';

class ActivityServices {
  static ApiResponse _response = ApiResponse();

  static Future<LatestFollowRequestModel> fetchLatestFolloweRequests() async {
    _response = await ApiHelper.get(
      ApiStringConstants.fetchLatestFolloweRequests,
      isPublic: false,
    );
    return LatestFollowRequestModel.fromJson(_response.data);
  }

  static Future<List<RecentLikesModel>> getRecentLikes(String type) async {
    _response = await ApiHelper.get(
      ApiStringConstants.getActivity,
      querryParam: {
        "type": type,
      },
      isPublic: false,
    );
    List<RecentLikesModel> recentLikes = [];
    for (var item in _response.data) {
      recentLikes.add(RecentLikesModel.fromJson(item));
      log(recentLikes.last.toJson().toString());
    }
    return recentLikes;
  }

  static Map<String, String> activityAPIMap = {
    'Feeds': ApiStringConstants.fetchFeedActivity,
    'Threads': ApiStringConstants.fetchThreadActivity,
    'Thread Comments': ApiStringConstants.fetchThreadCommentsActivity,
    'Feed Comments': ApiStringConstants.fetchFeedCommentsActivity,
  };

  static Future<List<dynamic>> getActivity(String title,
      {required String type}) async {
    _response = await ApiHelper.get(
      activityAPIMap[title]!,
      querryParam: {
        "type": type,
      },
      isPublic: false,
    );
    if (title == 'Feeds') {
      if (type == 'likes') {
        List<FeedLikeActivity> feedLikeActivities = [];
        for (var item in _response.data) {
          feedLikeActivities.add(FeedLikeActivity.fromJson(item));
        }
        return feedLikeActivities as List<FeedLikeActivity>;
      } else {
        List<FeedCommentsActivity> feedCommentActivities = [];
        for (var item in _response.data) {
          feedCommentActivities.add(FeedCommentsActivity.fromJson(item));
        }
        return feedCommentActivities as List<FeedCommentsActivity>;
      }
    } else if (title == 'Threads') {
      if (type == 'likes') {
        List<ThreadLikesActivity> threadLikeActivities = [];
        for (var item in _response.data) {
          threadLikeActivities.add(ThreadLikesActivity.fromJson(item));
        }
        return threadLikeActivities as List<ThreadLikesActivity>;
      } else {
        List<ThreadCommentsActivity> threadCommentActivities = [];
        for (var item in _response.data) {
          threadCommentActivities.add(ThreadCommentsActivity.fromJson(item));
        }
        return threadCommentActivities as List<ThreadCommentsActivity>;
      }
    } else if (title == 'Thread Comments') {
      if (type == 'likes') {
        List<ThreadCommentLikesActivity> threadLikeActivities = [];
        for (var item in _response.data) {
          threadLikeActivities.add(ThreadCommentLikesActivity.fromJson(item));
        }
        return threadLikeActivities as List<ThreadCommentLikesActivity>;
      } else {
        List<ThreadCommentCommentsActivity> threadCommentActivities = [];
        for (var item in _response.data) {
          threadCommentActivities
              .add(ThreadCommentCommentsActivity.fromJson(item));
        }
        return threadCommentActivities as List<ThreadCommentCommentsActivity>;
      }
    } else {
      if (type == 'likes') {
        List<FeedCommentLikesActivity> feedLikeActivities = [];
        for (var item in _response.data) {
          feedLikeActivities.add(FeedCommentLikesActivity.fromJson(item));
        }
        return feedLikeActivities as List<FeedCommentLikesActivity>;
      } else {
        List<FeedCommentCommentsActivity> feedCommentActivities = [];
        for (var item in _response.data) {
          feedCommentActivities.add(FeedCommentCommentsActivity.fromJson(item));
        }
        return feedCommentActivities as List<FeedCommentCommentsActivity>;
      }
    }
  }

  static Future<List<StoryLikeActivity>> getStoryLikes() async {
    _response = await ApiHelper.get(
      ApiStringConstants.fetchStoryLikesActivity,
      isPublic: false,
    );
    List<StoryLikeActivity> storyLikeActivities = [];
    for (var item in _response.data) {
      storyLikeActivities.add(StoryLikeActivity.fromJson(item));
    }
    return storyLikeActivities;
  }

  static Future<List<MentionsActivity>> getMentions() async {
    _response = await ApiHelper.get(
      ApiStringConstants.fetchMentionsActivity,
      isPublic: false,
    );
    List<MentionsActivity> mentionsActivities = [];
    for (var item in _response.data) {
      mentionsActivities.add(MentionsActivity.fromJson(item));
    }
    return mentionsActivities;
  }
}
