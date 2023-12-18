// To parse this JSON data, do
//
//     final userProfileDetailsModel = userProfileDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:socioverse/Models/threadModel.dart';

UserProfileDetailsModel userProfileDetailsModelFromJson(String str) => UserProfileDetailsModel.fromJson(json.decode(str));

String userProfileDetailsModelToJson(UserProfileDetailsModel data) => json.encode(data.toJson());

class UserProfileDetailsModel {
    UserProfileDetailsModelUser user;
    List<ThreadModel> threadsWithUserDetails;

    UserProfileDetailsModel({
        required this.user,
        required this.threadsWithUserDetails,
    });

    factory UserProfileDetailsModel.fromJson(Map<String, dynamic> json) => UserProfileDetailsModel(
        user: UserProfileDetailsModelUser.fromJson(json["user"]),
        threadsWithUserDetails: List<ThreadModel>.from(json["threadsWithUserDetails"].map((x) => ThreadModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
        "threadsWithUserDetails": List<dynamic>.from(threadsWithUserDetails.map((x) => x.toJson())),
    };
}

class UserProfileDetailsModelUser {
    String id;
    String name;
    String username;
    String occupation;
    String profilePic;
    int followersCount;
    int followingCount;
    int postCount;
    String? bio;
    int? state;

    UserProfileDetailsModelUser({
        required this.id,
        required this.name,
        required this.username,
        required this.occupation,
        required this.profilePic,
        required this.followersCount,
        required this.followingCount,
        required this.postCount,
         this.bio,
         this.state,
    });

    factory UserProfileDetailsModelUser.fromJson(Map<String, dynamic> json) => UserProfileDetailsModelUser(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
        followersCount: json["followers_count"],
        followingCount: json["following_count"],
        postCount: json["post_count"],
        bio: json["bio"],
        state: json["state"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
        "followers_count": followersCount,
        "following_count": followingCount,
        "post_count": postCount,
        "bio": bio,
        "state": state,
    };
}
