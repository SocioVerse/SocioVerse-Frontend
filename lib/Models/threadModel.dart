import 'dart:convert';

class ThreadModel {
  String id;
  String content;
  List<dynamic> images;
  int likeCount;
  bool isPrivate;
  bool isBase;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String parentThread;
  List<dynamic> userLikes;
  List<CommentUser> commentUsers;
  int commentCount;
  User user;
  bool isLiked = false;
  bool isReposted = false;
  ThreadModel({
    required this.id,
    required this.content,
    required this.images,
    required this.likeCount,
    required this.isPrivate,
    required this.isBase,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.parentThread,
    required this.userLikes,
    required this.commentUsers,
    required this.commentCount,
    required this.user,
    required this.isLiked,
    required this.isReposted,
  });

  factory ThreadModel.fromRawJson(String str) =>
      ThreadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
        id: json["_id"],
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        likeCount: json["like_count"],
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        parentThread: json["parent_thread"],
        userLikes: json["userLikes"] != null
            ? List<dynamic>.from(json["userLikes"].map((x) => x))
            : [],
        commentUsers: List<CommentUser>.from(
            json["commentUsers"].map((x) => CommentUser.fromJson(x))),
        commentCount: json["comment_count"],
        user: User.fromJson(json["user"]),
        isLiked: json["isLiked"] ?? false,
        isReposted: json["isReposted"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "like_count": likeCount,
        "is_private": isPrivate,
        "isBase": isBase,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "parent_thread": parentThread,
        "userLikes": List<dynamic>.from(userLikes.map((x) => x)),
        "commentUsers": List<dynamic>.from(commentUsers.map((x) => x.toJson())),
        "comment_count": commentCount,
        "user": user.toJson(),
        "isLiked": isLiked,
      };
}

class CommentUser {
  String id;
  String profilePic;

  CommentUser({
    required this.id,
    required this.profilePic,
  });

  factory CommentUser.fromRawJson(String str) =>
      CommentUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentUser.fromJson(Map<String, dynamic> json) => CommentUser(
        id: json["_id"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profile_pic": profilePic,
      };
}

class User {
  String id;
  String username;
  String occupation;
  String profilePic;
  bool isOwner = false;
  User({
    required this.id,
    required this.username,
    required this.occupation,
    required this.profilePic,
    required this.isOwner,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
        isOwner: json["isOwner"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
      };
}

class CreateThreadModel {
  String? threadId;
  String content;
  List<dynamic> images;
  bool isPrivate;
  bool isBase;
  List<CommentModel> comments;

  CreateThreadModel({
    this.threadId,
    required this.content,
    required this.images,
    required this.isPrivate,
    required this.isBase,
    required this.comments,
  });

  factory CreateThreadModel.fromRawJson(String str) =>
      CreateThreadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateThreadModel.fromJson(Map<String, dynamic> json) =>
      CreateThreadModel(
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        comments: List<CommentModel>.from(
            json["comments"].map((x) => CommentModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "threadId": threadId,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_private": isPrivate,
        "isBase": isBase,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class CommentModel {
  String content;
  List<dynamic> images;

  CommentModel({
    required this.content,
    required this.images,
  });

  factory CommentModel.fromRawJson(String str) =>
      CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
