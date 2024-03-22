// To parse this JSON data, do
//
//     final feedComment = feedCommentFromJson(jsonString);

import 'dart:convert';

import 'package:socioverse/Models/threadModel.dart';

FeedComment feedCommentFromJson(String str) =>
    FeedComment.fromJson(json.decode(str));

String feedCommentToJson(FeedComment data) => json.encode(data.toJson());

class FeedComment {
  String id;
  User userId;
  String parentFeed;
  String content;
  int likeCount;
  int commentCount;
  String parentComment;
  DateTime createdAt;
  bool isLiked;

  FeedComment({
    required this.id,
    required this.userId,
    required this.isLiked,
    required this.parentFeed,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.parentComment,
    required this.createdAt,
  });

  factory FeedComment.fromJson(Map<String, dynamic> json) => FeedComment(
        id: json["_id"],
        userId: User.fromJson(json["user_id"]),
        isLiked: json["isLiked"],
        parentFeed: json["parent_feed"],
        content: json["content"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        parentComment: json["parent_comment"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId.toJson(),
        "parent_feed": parentFeed,
        "content": content,
        "like_count": likeCount,
        "comment_count": commentCount,
        "parent_comment": parentComment,
        "createdAt": createdAt.toIso8601String(),
      };
}
