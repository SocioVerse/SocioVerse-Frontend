import 'dart:convert';

class ThreadModel {
  String userId;
  String content;
  List<dynamic> images;
  bool isPrivate;
  bool isBase;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  ThreadModel({
    required this.userId,
    required this.content,
    required this.images,
    required this.isPrivate,
    required this.isBase,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ThreadModel.fromRawJson(String str) =>
      ThreadModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ThreadModel.fromJson(Map<String, dynamic> json) => ThreadModel(
        userId: json["user_id"],
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "content": content,
        "images": List<dynamic>.from(images.map((x) => x)),
        "is_private": isPrivate,
        "isBase": isBase,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
class CreateThreadModel {
    String content;
    List<dynamic> images;
    bool isPrivate;
    bool isBase;
    List<CommentModel> comments;

    CreateThreadModel({
        required this.content,
        required this.images,
        required this.isPrivate,
        required this.isBase,
        required this.comments,
    });

    factory CreateThreadModel.fromRawJson(String str) => CreateThreadModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CreateThreadModel.fromJson(Map<String, dynamic> json) => CreateThreadModel(
        content: json["content"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        isPrivate: json["is_private"],
        isBase: json["isBase"],
        comments: List<CommentModel>.from(json["comments"].map((x) => CommentModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
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

    factory CommentModel.fromRawJson(String str) => CommentModel.fromJson(json.decode(str));

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
