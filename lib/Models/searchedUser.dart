import 'dart:convert';

class SearchedUser {
  String id;
  String name;
  String username;
  String occupation;
  String profilePic;
  bool? isConfirmed;

  SearchedUser({
    required this.id,
    required this.name,
    required this.username,
    required this.occupation,
    required this.profilePic,
    this.isConfirmed,
  });

  factory SearchedUser.fromRawJson(String str) =>
      SearchedUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchedUser.fromJson(Map<String, dynamic> json) => SearchedUser(
        id: json["_id"],
        name: json["name"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],

        isConfirmed: json["isFollowed"],

      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
        "isFollowed": isConfirmed,
      };
}