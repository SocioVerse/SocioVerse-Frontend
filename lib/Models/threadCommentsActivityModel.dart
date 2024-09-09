class ThreadCommentActivity {
  String id;
  String userId;
  ParentThread parentThread;
  String content;
  List<dynamic> images;
  int likeCount;
  int commentCount;
  bool isPrivate;
  bool isBase;
  int savedCount;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ThreadCommentActivity({
    required this.id,
    required this.userId,
    required this.parentThread,
    required this.content,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.isPrivate,
    required this.isBase,
    required this.savedCount,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}

class ThreadCommentCommentsActivity extends ThreadCommentActivity {
  LatestComment latestComment;

  ThreadCommentCommentsActivity({
    required this.latestComment,
    required super.id,
    required super.userId,
    required super.parentThread,
    required super.content,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.isPrivate,
    required super.isBase,
    required super.savedCount,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory ThreadCommentCommentsActivity.fromJson(Map<String, dynamic> json) =>
      ThreadCommentCommentsActivity(
        id: json["_id"],
        userId: json["user_id"],
        parentThread: ParentThread.fromJson(json["parent_thread"]),
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        savedCount: json["saved_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestComment: LatestComment.fromJson(json["latestComment"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "parent_thread": parentThread.toJson(),
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "is_private": isPrivate,
        "isBase": isBase,
        "saved_count": savedCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestComment": latestComment.toJson(),
      };
}

class LatestComment {
  String id;
  UserId userId;
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
        userId: UserId.fromJson(json["user_id"]),
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

class ParentThread {
  String id;
  int likeCount;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  ParentThread({
    required this.id,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParentThread.fromJson(Map<String, dynamic> json) => ParentThread(
        id: json["_id"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "like_count": likeCount,
        "comment_count": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class ThreadCommentLikesActivity extends ThreadCommentActivity {
  LatestLike latestLike;

  ThreadCommentLikesActivity({
    required this.latestLike,
    required super.id,
    required super.userId,
    required super.parentThread,
    required super.content,
    required super.images,
    required super.likeCount,
    required super.commentCount,
    required super.isPrivate,
    required super.isBase,
    required super.savedCount,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory ThreadCommentLikesActivity.fromJson(Map<String, dynamic> json) =>
      ThreadCommentLikesActivity(
        id: json["_id"],
        userId: json["user_id"],
        parentThread: ParentThread.fromJson(json["parent_thread"]),
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        savedCount: json["saved_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestLike: LatestLike.fromJson(json["latestLike"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "parent_thread": parentThread.toJson(),
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "is_private": isPrivate,
        "isBase": isBase,
        "saved_count": savedCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
