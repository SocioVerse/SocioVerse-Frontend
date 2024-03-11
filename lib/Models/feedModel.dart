// To parse this JSON data, do
//
//     final feedThumbnail = feedThumbnailFromJson(jsonString);

import 'dart:convert';

import 'package:socioverse/Models/threadModel.dart';

FeedThumbnail feedThumbnailFromJson(String str) =>
    FeedThumbnail.fromJson(json.decode(str));

String feedThumbnailToJson(FeedThumbnail data) => json.encode(data.toJson());

class FeedThumbnail {
  String id;
  User userId;
  List<String> images;
  bool isPrivate;
  bool allowComments;
  bool allowSave;

  FeedThumbnail({
    required this.id,
    required this.userId,
    required this.images,
    required this.isPrivate,
    required this.allowComments,
    required this.allowSave,
  });

  factory FeedThumbnail.fromJson(Map<String, dynamic> json) => FeedThumbnail(
        id: json["_id"],
        userId: User.fromJson(json["user_id"]),
        images: List<String>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        allowComments: json["allow_comments"],
        allowSave: json["allow_save"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_private": isPrivate,
        "allow_comments": allowComments,
        "allow_save": allowSave,
      };
}

FeedModel feedModelFromJson(String str) => FeedModel.fromJson(json.decode(str));

String feedModelToJson(FeedModel data) => json.encode(data.toJson());

class FeedModel {
  String id;
  List<String> images;
  List<String> mentions;
  List<String> tags;
  String? location;
  bool autoEnhanced;
  String? caption;
  int likeCount;
  int commentCount;
  bool isPrivate;
  bool allowComments;
  bool allowSave;
  int savedCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isLiked;
  bool isSaved;
  User user;
  List<CommentUser> commentUsers;

  FeedModel({
    required this.id,
    required this.images,
    required this.mentions,
    required this.tags,
    this.location,
    required this.autoEnhanced,
    this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.isPrivate,
    required this.allowComments,
    required this.allowSave,
    required this.savedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
    required this.isSaved,
    required this.user,
    required this.commentUsers,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) => FeedModel(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        mentions: List<String>.from(json["mentions"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        location: json["location"],
        autoEnhanced: json["auto_enhanced"],
        caption: json["caption"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        isPrivate: json["is_private"],
        allowComments: json["allow_comments"],
        allowSave: json["allow_save"],
        savedCount: json["saved_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"] ?? 0,
        isLiked: json["isLiked"],
        isSaved: json["isSaved"],
        user: User.fromJson(json["user"]),
        commentUsers: List<CommentUser>.from(
            json["commentUsers"].map((x) => CommentUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "mentions": List<dynamic>.from(mentions.map((x) => x)),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "location": location,
        "auto_enhanced": autoEnhanced,
        "caption": caption,
        "like_count": likeCount,
        "comment_count": commentCount,
        "is_private": isPrivate,
        "allow_comments": allowComments,
        "allow_save": allowSave,
        "saved_count": savedCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "isLiked": isLiked,
        "isSaved": isSaved,
        "user": user.toJson(),
        "commentUsers": List<dynamic>.from(commentUsers.map((x) => x)),
      };
}
