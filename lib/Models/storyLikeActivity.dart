// To parse this JSON data, do
//
//     final storyLikeActivity = storyLikeActivityFromJson(jsonString);

import 'dart:convert';

StoryLikeActivity storyLikeActivityFromJson(String str) =>
    StoryLikeActivity.fromJson(json.decode(str));

String storyLikeActivityToJson(StoryLikeActivity data) =>
    json.encode(data.toJson());

class StoryLikeActivity {
  String id;
  String image;
  int likeCount;
  DateTime createdAt;
  DateTime updatedAt;
  LatestLike latestLike;

  StoryLikeActivity({
    required this.id,
    required this.image,
    required this.likeCount,
    required this.createdAt,
    required this.updatedAt,
    required this.latestLike,
  });

  factory StoryLikeActivity.fromJson(Map<String, dynamic> json) =>
      StoryLikeActivity(
        id: json["_id"],
        image: json["image"],
        likeCount: json["like_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestLike: LatestLike.fromJson(json["latestLike"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "like_count": likeCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestLike": latestLike.toJson(),
      };
}

class LatestLike {
  String id;
  LikedBy likedBy;
  String storyId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  LatestLike({
    required this.id,
    required this.likedBy,
    required this.storyId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LatestLike.fromJson(Map<String, dynamic> json) => LatestLike(
        id: json["_id"],
        likedBy: LikedBy.fromJson(json["liked_by"]),
        storyId: json["story_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "liked_by": likedBy.toJson(),
        "story_id": storyId,
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
