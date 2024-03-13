// To parse this JSON data, do
//
//     final followRequestModel = followRequestModelFromJson(jsonString);

import 'dart:convert';

List<FollowRequestModel> followRequestModelFromJson(String str) =>
    List<FollowRequestModel>.from(
        json.decode(str).map((x) => FollowRequestModel.fromJson(x)));

String followRequestModelToJson(List<FollowRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FollowRequestModel {
  String id;
  String name;
  String username;
  String occupation;
  String profilePic;

  FollowRequestModel({
    required this.id,
    required this.name,
    required this.username,
    required this.occupation,
    required this.profilePic,
  });

  factory FollowRequestModel.fromJson(Map<String, dynamic> json) =>
      FollowRequestModel(
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
