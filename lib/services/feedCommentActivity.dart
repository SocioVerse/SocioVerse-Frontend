class FeedCommentActivity {
  String id;
  String userId;
  ParentFeed parentFeed;
  String content;
  int likeCount;
  int commentCount;
  String parentComment;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  FeedCommentActivity({
    required this.id,
    required this.userId,
    required this.parentFeed,
    required this.content,
    required this.likeCount,
    required this.commentCount,
    required this.parentComment,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });
}

class FeedCommentCommentsActivity extends FeedCommentActivity {
  LatestComment latestComment;

  FeedCommentCommentsActivity({
    required this.latestComment,
    required super.id,
    required super.userId,
    required super.parentFeed,
    required super.content,
    required super.likeCount,
    required super.commentCount,
    required super.parentComment,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory FeedCommentCommentsActivity.fromJson(Map<String, dynamic> json) =>
      FeedCommentCommentsActivity(
        id: json["_id"],
        userId: json["user_id"],
        parentFeed: ParentFeed.fromJson(json["parent_feed"]),
        content: json["content"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        parentComment: json["parent_comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestComment: LatestComment.fromJson(json["latestComment"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "parent_feed": parentFeed.toJson(),
        "content": content,
        "like_count": likeCount,
        "comment_count": commentCount,
        "parent_comment": parentComment,
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

class ParentFeed {
  String id;
  List<String> images;
  int likeCount;
  int commentCount;
  DateTime createdAt;
  DateTime updatedAt;

  ParentFeed({
    required this.id,
    required this.images,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ParentFeed.fromJson(Map<String, dynamic> json) => ParentFeed(
        id: json["_id"],
        images: List<String>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "comment_count": commentCount,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class FeedCommentLikesActivity extends FeedCommentActivity {
  LatestLike latestLike;

  FeedCommentLikesActivity({
    required this.latestLike,
    required super.id,
    required super.userId,
    required super.parentFeed,
    required super.content,
    required super.likeCount,
    required super.commentCount,
    required super.parentComment,
    required super.createdAt,
    required super.updatedAt,
    required super.v,
  });

  factory FeedCommentLikesActivity.fromJson(Map<String, dynamic> json) =>
      FeedCommentLikesActivity(
        id: json["_id"],
        userId: json["user_id"],
        parentFeed: ParentFeed.fromJson(json["parent_feed"]),
        content: json["content"],
        likeCount: json["like_count"],
        commentCount: json["comment_count"],
        parentComment: json["parent_comment"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestLike: LatestLike.fromJson(json["latestLike"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user_id": userId,
        "parent_feed": parentFeed.toJson(),
        "content": content,
        "like_count": likeCount,
        "comment_count": commentCount,
        "parent_comment": parentComment,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestLike": latestLike.toJson(),
      };
}

class LatestLike {
  String id;
  String commentId;
  LikedBy likedBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  LatestLike({
    required this.id,
    required this.commentId,
    required this.likedBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory LatestLike.fromJson(Map<String, dynamic> json) => LatestLike(
        id: json["_id"],
        commentId: json["comment_id"],
        likedBy: LikedBy.fromJson(json["liked_by"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "comment_id": commentId,
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
