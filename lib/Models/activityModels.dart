// To parse this JSON data, do
//
//     final latestFollowRequestModel = latestFollowRequestModelFromJson(jsonString);

import 'dart:convert';

LatestFollowRequestModel latestFollowRequestModelFromJson(String str) =>
    LatestFollowRequestModel.fromJson(json.decode(str));

String latestFollowRequestModelToJson(LatestFollowRequestModel data) =>
    json.encode(data.toJson());

class LatestFollowRequestModel {
  List<String> profilePics;
  List<String> names;
  int followRequestCount;

  LatestFollowRequestModel({
    required this.profilePics,
    required this.names,
    required this.followRequestCount,
  });

  factory LatestFollowRequestModel.fromJson(Map<String, dynamic> json) =>
      LatestFollowRequestModel(
        profilePics: List<String>.from(json["profilePics"].map((x) => x)),
        names: List<String>.from(json["names"].map((x) => x)),
        followRequestCount: json["followRequestCount"],
      );

  Map<String, dynamic> toJson() => {
        "profilePics": List<dynamic>.from(profilePics.map((x) => x)),
        "names": List<dynamic>.from(names.map((x) => x)),
        "followRequestCount": followRequestCount,
      };
}

// User model
class User {
  final String id;
  final String profilePic;
  final String? username;
  User({
    required this.id,
    required this.profilePic,
    this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      profilePic: json['profile_pic'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'profile_pic': profilePic,
    };
  }
}

// Feed model
class Feed {
  final String id;
  final String userId;
  final List<String> images;
  final List<dynamic> mentions;
  final List<dynamic> tags;
  final dynamic location;
  final bool autoEnhanced;
  final String caption;
  final int likeCount;
  final int commentCount;
  final bool isPrivate;
  final bool allowComments;
  final bool allowSave;
  final int savedCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Feed({
    required this.id,
    required this.userId,
    required this.images,
    required this.mentions,
    required this.tags,
    required this.location,
    required this.autoEnhanced,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.isPrivate,
    required this.allowComments,
    required this.allowSave,
    required this.savedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      id: json['_id'],
      userId: json['user_id'],
      images: List<String>.from(json['images']),
      mentions: List<dynamic>.from(json['mentions']),
      tags: List<dynamic>.from(json['tags']),
      location: json['location'],
      autoEnhanced: json['auto_enhanced'],
      caption: json['caption'],
      likeCount: json['like_count'],
      commentCount: json['comment_count'],
      isPrivate: json['is_private'],
      allowComments: json['allow_comments'],
      allowSave: json['allow_save'],
      savedCount: json['saved_count'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'images': images,
      'mentions': mentions,
      'tags': tags,
      'location': location,
      'auto_enhanced': autoEnhanced,
      'caption': caption,
      'like_count': likeCount,
      'comment_count': commentCount,
      'is_private': isPrivate,
      'allow_comments': allowComments,
      'allow_save': allowSave,
      'saved_count': savedCount,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

// Thread model
class Thread {
  final String id;
  final String userId;
  final String content;
  final List<dynamic> images;
  final int likeCount;
  final int commentCount;
  final bool isPrivate;
  final bool isBase;
  final int savedCount;
  final String parentThread;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Thread({
    required this.id,
    required this.userId,
    required this.content,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.isPrivate,
    required this.isBase,
    required this.savedCount,
    required this.parentThread,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json['_id'],
      userId: json['user_id'],
      content: json['content'],
      images: List<dynamic>.from(json['images']),
      likeCount: json['like_count'],
      commentCount: json['comment_count'],
      isPrivate: json['is_private'],
      isBase: json['isBase'],
      savedCount: json['saved_count'],
      parentThread: json['parent_thread'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user_id': userId,
      'content': content,
      'images': images,
      'like_count': likeCount,
      'comment_count': commentCount,
      'is_private': isPrivate,
      'isBase': isBase,
      'saved_count': savedCount,
      'parent_thread': parentThread,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class RecentLikesModel {
  final String type;
  final Feed? feed;
  final Thread? thread;
  final List<User> users;
  final DateTime? latestLike;
  final DateTime? latestComment;

  RecentLikesModel({
    required this.type,
    this.feed,
    this.thread,
    required this.users,
    this.latestLike,
    this.latestComment,
  });

  factory RecentLikesModel.fromJson(Map<String, dynamic> json) {
    return RecentLikesModel(
      type: json['type'],
      feed: json['type'] == 'Feed' ? Feed.fromJson(json['feed']) : null,
      thread: json['type'] == 'Thread' ? Thread.fromJson(json['thread']) : null,
      users: (json['users'] as List).map((e) => User.fromJson(e)).toList(),
      latestLike: DateTime.parse(json['latestLike']),
      latestComment: DateTime.parse(json['latestComment']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'feed': feed?.toJson(),
      'thread': thread?.toJson(),
      'users': users.map((e) => e.toJson()).toList(),
    };
  }
}
