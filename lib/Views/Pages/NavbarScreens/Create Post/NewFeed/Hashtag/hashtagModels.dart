// To parse this JSON data, do
//
//     final hashtagsSearchModel = hashtagsSearchModelFromJson(jsonString);

import 'dart:convert';

List<HashtagsSearchModel> hashtagsSearchModelFromJson(String str) =>
    List<HashtagsSearchModel>.from(
        json.decode(str).map((x) => HashtagsSearchModel.fromJson(x)));

String hashtagsSearchModelToJson(List<HashtagsSearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HashtagsSearchModel {
  String id;
  int postCount;
  String hashtag;

  HashtagsSearchModel({
    required this.id,
    required this.postCount,
    required this.hashtag,
  });

  factory HashtagsSearchModel.fromJson(Map<String, dynamic> json) =>
      HashtagsSearchModel(
        id: json["_id"],
        postCount: json["post_count"],
        hashtag: json["hashtag"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "post_count": postCount,
        "hashtag": hashtag,
      };
}
