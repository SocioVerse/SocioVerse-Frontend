// To parse this JSON data, do
//
//     final followersModel = followersModelFromJson(jsonString);

import 'dart:convert';

FollowersModel followersModelFromJson(String str) =>
    FollowersModel.fromJson(json.decode(str));

String followersModelToJson(FollowersModel data) => json.encode(data.toJson());

class FollowersModel {
  User user;
  int state;

  FollowersModel({
    required this.user,
    required this.state,
  });

  factory FollowersModel.fromJson(Map<String, dynamic> json) => FollowersModel(
        user: User.fromJson(json["user"]),
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "state": state,
      };
}

class User {
  String id;
  String name;
  String username;
  String occupation;
  String profilePic;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.occupation,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
      };
}
