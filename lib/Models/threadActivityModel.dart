class ThreadActivity {
  String id;
  String content;
  List<dynamic> images;
  int likeCount;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  ThreadActivity({
    required this.id,
    required this.content,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });
}

class ThreadCommentsActivity extends ThreadActivity {
  LatestComment latestComment;

  ThreadCommentsActivity({
    required this.latestComment,
    required super.id,
    required super.content,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ThreadCommentsActivity.fromJson(Map<String, dynamic> json) =>
      ThreadCommentsActivity(
        id: json["_id"],
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestComment: LatestComment.fromJson(json["latestComment"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestComment": latestComment.toJson(),
      };
}

class LatestComment {
  String id;
  User userId;
  DateTime createdAt;
  DateTime updatedAt;

  LatestComment({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LatestComment.fromJson(Map<String, dynamic> json) => LatestComment(
        id: json["_id"],
        userId: User.fromJson(json["user_id"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class User {
  String id;
  String username;
  String profilePic;

  User({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class ThreadLikesActivity extends ThreadActivity {
  LatestLike latestLike;

  ThreadLikesActivity({
    required this.latestLike,
    required super.id,
    required super.content,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ThreadLikesActivity.fromJson(Map<String, dynamic> json) =>
      ThreadLikesActivity(
        id: json["_id"],
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        latestLike: LatestLike.fromJson(json["latestLike"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestLike": latestLike.toJson(),
      };
}

class LatestLike {
  String id;
  String threadId;
  LikedBy likedBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  LatestLike({
    required this.id,
    required this.threadId,
    required this.likedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LatestLike.fromJson(Map<String, dynamic> json) => LatestLike(
        id: json["_id"],
        threadId: json["thread_id"],
        likedBy: LikedBy.fromJson(json["liked_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "thread_id": threadId,
        "liked_by": likedBy.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class LikedBy {
  String id;
  String username;
  String profilePic;

  LikedBy({
    required this.id,
    required this.username,
    required this.profilePic,
  });

  factory LikedBy.fromJson(Map<String, dynamic> json) => LikedBy(
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
