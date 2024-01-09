// To parse this JSON data, do
//
//     final profileStoryModel = profileStoryModelFromJson(jsonString);

import 'dart:convert';

ProfileStoryModel profileStoryModelFromJson(String str) =>
    ProfileStoryModel.fromJson(json.decode(str));

String profileStoryModelToJson(ProfileStoryModel data) =>
    json.encode(data.toJson());

class ProfileStoryModel {
  User user;
  bool? isAllSeen;

  ProfileStoryModel({
    required this.user,
    this.isAllSeen,
  });

  factory ProfileStoryModel.fromJson(Map<String, dynamic> json) =>
      ProfileStoryModel(
        user: User.fromJson(json["user"]),
        isAllSeen: json["is_all_seen"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "is_all_seen": isAllSeen,
      };
}

class User {
  String id;
  String name;
  String username;
  String occupation;
  String profilePic;
  String email;
  bool isOwner;
  bool? isLiked;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.occupation,
    required this.profilePic,
    required this.email,
    required this.isOwner,
    this.isLiked,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
        isOwner: json["isOwner"],
        email: json["email"],
        isLiked: json["isLiked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
        "isOwner": isOwner,
      };
}

ReadStoryModel readStoryModelFromJson(String str) =>
    ReadStoryModel.fromJson(json.decode(str));

String readStoryModelToJson(ReadStoryModel data) => json.encode(data.toJson());

class ReadStoryModel {
  String id;
  String userId;
  String image;
  int viewCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  bool isLiked;

  ReadStoryModel({
    required this.id,
    required this.userId,
    required this.image,
    required this.viewCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isLiked,
  });

  factory ReadStoryModel.fromJson(Map<String, dynamic> json) => ReadStoryModel(
        id: json["_id"],
        userId: json["user_id"],
        image: json["image"],
        viewCount: json["view_count"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        v: json["__v"],
        isLiked: json["is_liked"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "image": image,
        "view_count": viewCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "is_liked": isLiked,
      };
}

StorySeensModel storySeensModelFromJson(String str) =>
    StorySeensModel.fromJson(json.decode(str));

String storySeensModelToJson(StorySeensModel data) =>
    json.encode(data.toJson());

class StorySeensModel {
  int likeCount;
  List<User> users;

  StorySeensModel({
    required this.likeCount,
    required this.users,
  });

  factory StorySeensModel.fromJson(Map<String, dynamic> json) =>
      StorySeensModel(
        likeCount: json["likeCount"],
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "likeCount": likeCount,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
