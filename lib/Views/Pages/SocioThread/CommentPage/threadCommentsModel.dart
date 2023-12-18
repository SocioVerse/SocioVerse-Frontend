// To parse this JSON data, do
//
//     final threadRepliesModel = threadRepliesModelFromJson(jsonString);

import 'dart:convert';

ThreadRepliesModel threadRepliesModelFromJson(String str) => ThreadRepliesModel.fromJson(json.decode(str));

String threadRepliesModelToJson(ThreadRepliesModel data) => json.encode(data.toJson());

class ThreadRepliesModel {
    String commentId;
    String content;
    List<String> images;
    String username;
    String occupation;
    String userProfile;
    int likeCount;
    bool isLiked;
    int commentCount;
    String userId;
    DateTime createdAt;

    ThreadRepliesModel({
        required this.commentId,
        required this.content,
        required this.images,
        required this.username,
        required this.occupation,
        required this.userProfile,
        required this.likeCount,
        required this.isLiked,
        required this.commentCount,
        required this.userId,
        required this.createdAt,
    });

    factory ThreadRepliesModel.fromJson(Map<String, dynamic> json) => ThreadRepliesModel(
        commentId: json["commentId"],
        content: json["content"],
        images: List<String>.from(json["images"].map((x) => x)),
        username: json["username"],
        occupation: json["occupation"],
        userProfile: json["userProfile"],
        likeCount: json["likeCount"],
        isLiked: json["isLiked"],
        commentCount: json["commentCount"],
        userId: json["userId"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "username": username,
        "occupation": occupation,
        "userProfile": userProfile,
        "likeCount": likeCount,
        "isLiked": isLiked,
        "commentCount": commentCount,
        "userId": userId,
        "createdAt": createdAt.toIso8601String(),
    };
}
