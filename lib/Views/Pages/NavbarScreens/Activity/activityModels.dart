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
