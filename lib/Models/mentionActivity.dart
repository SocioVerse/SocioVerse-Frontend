class MentionsActivity {
  String id;
  UserId userId;
  List<String> images;
  int likeCount;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  MentionsActivity({
    required this.id,
    required this.userId,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MentionsActivity.fromJson(Map<String, dynamic> json) =>
      MentionsActivity(
        id: json["_id"],
        userId: UserId.fromJson(json["user_id"]),
        images: List<String>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId.toJson(),
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class UserId {
  String id;
  String username;
  String profilePic;

  UserId({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["_id"],
        username: json["username"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "profile_pic": profilePic,
      };
}
