// To parse this JSON data, do
//
//     final FeedActivity = FeedActivityFromJson(jsonString);

import 'dart:convert';

class FeedActivity {
  String id;
  List<String> images;
  int likeCount;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  FeedActivity({
    required this.id,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });
}

class FeedLikeActivity extends FeedActivity {
  LatestLike latestLikes;
  FeedLikeActivity({
    required super.id,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.createdAt,
    required super.updatedAt,
    required this.latestLikes,
  });

  factory FeedLikeActivity.fromJson(Map<String, dynamic> json) =>
      FeedLikeActivity(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestLikes: LatestLike.fromJson(json["latestLike"]),
      );
}

class FeedCommentsActivity extends FeedActivity {
  LatestComment latestComment;
  FeedCommentsActivity({
    required super.id,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.createdAt,
    required super.updatedAt,
    required this.latestComment,
  });

  factory FeedCommentsActivity.fromJson(Map<String, dynamic> json) =>
      FeedCommentsActivity(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestComment: LatestComment.fromJson(json["latestComment"]),
      );
}

class LatestComment {
  String id;
  User userId;
  DateTime createdAt;
  DateTime updatedAt;

  LatestComment({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LatestComment.fromJson(Map<String, dynamic> json) => LatestComment(
        id: json["_id"],
        userId: User.fromJson(json["user_id"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class User {
  String id;
  String username;
  String profilePic;

  User({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "profile_pic": profilePic,
      };
}

class LatestLike {
  String id;
  String feedId;
  LikedBy likedBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  LatestLike({
    required this.id,
    required this.feedId,
    required this.likedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LatestLike.fromJson(Map<String, dynamic> json) => LatestLike(
        id: json["_id"],
        feedId: json["feed_id"],
        likedBy: LikedBy.fromJson(json["liked_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "feed_id": feedId,
        "liked_by": likedBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class LikedBy {
  String id;
  String username;
  String profilePic;

  LikedBy({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory LikedBy.fromJson(Map<String, dynamic> json) => LikedBy(
        id: json["_id"],
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "profile_pic": profilePic,
      };
}
