import 'dart:convert';

import 'dart:convert';

import 'dart:convert';

class ThreadModel {
  User user;
  int likeCount;
  String id;
  String userId;
  String content;
  
  List<dynamic> images;
  bool isPrivate;
  bool isBase;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ThreadModel({
    required this.user,
    required this.likeCount,
    required this.id,
    required this.userId,
    required this.content,
    required this.images,
    required this.isPrivate,
    required this.isBase,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ThreadModel.fromRawJson(String str) =>
      ThreadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
        user: User.fromJson(json["user"]),
        likeCount: json["like_count"],
        id: json["_id"],
        userId: json["user_id"],
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "like_count": likeCount,
        "_id": id,
        "user_id": userId,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_private": isPrivate,
        "isBase": isBase,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  String id;
  String username;
  String occupation;
  String profilePic;

  User({
    required this.id,
    required this.username,
    required this.occupation,
    required this.profilePic,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
      };
}

class CreateThreadModel {
  String content;
  List<dynamic> images;
  bool isPrivate;
  bool isBase;
  List<CommentModel> comments;

  CreateThreadModel({
    required this.content,
    required this.images,
    required this.isPrivate,
    required this.isBase,
    required this.comments,
  });

  factory CreateThreadModel.fromRawJson(String str) =>
      CreateThreadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateThreadModel.fromJson(Map<String, dynamic> json) =>
      CreateThreadModel(
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        comments: List<CommentModel>.from(
            json["comments"].map((x) => CommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_private": isPrivate,
        "isBase": isBase,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class CommentModel {
  String content;
  List<dynamic> images;

  CommentModel({
    required this.content,
    required this.images,
  });

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
