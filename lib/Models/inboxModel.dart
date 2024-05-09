// To parse this JSON data, do
//
//     final inboxModel = inboxModelFromJson(jsonString);

import 'dart:convert';

List<InboxModel> inboxModelFromJson(String str) =>
    List<InboxModel>.from(json.decode(str).map((x) => InboxModel.fromJson(x)));

String inboxModelToJson(List<InboxModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InboxModel {
  String id;
  bool isGroup;
  String roomId;
  DateTime createdAt;
  DateTime updatedAt;
  LastMessage? lastMessage;
  User user;
  bool isRequestMessage;
  int unreadMessages;

  InboxModel({
    required this.id,
    required this.isGroup,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.lastMessage,
    required this.isRequestMessage,
    required this.user,
    required this.unreadMessages,
  });

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        id: json["_id"],
        isGroup: json["isGroup"],
        roomId: json["roomId"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]),
        lastMessage:json["lastMessage"] == null? null: LastMessage.fromJson(json["lastMessage"]),
        user: User.fromJson(json["user"]),
        unreadMessages: json["unreadMessages"],
        isRequestMessage: json["isRequestMessage"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "isGroup": isGroup,
        "roomId": roomId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "lastMessage": lastMessage!.toJson(),
        "user": user.toJson(),
        "unreadMessages": unreadMessages,
        "isRequestMessage": isRequestMessage,
      };
}

class LastMessage {
  String id;
  String? message;
  String sentBy;
  dynamic image;
  dynamic thread;
  DateTime createdAt;
  DateTime updatedAt;

  LastMessage({
    required this.id,
    this.message,
    required this.image,
    required this.thread,
    required this.createdAt,
    required this.updatedAt,
    required this.sentBy,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        id: json["_id"],
        sentBy: json["sentBy"],
        message: json["message"],
        image: json["image"],
        thread: json["thread"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "image": image,
        "thread": thread,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class User {
  String id;
  String name;
  String email;
  String username;
  String occupation;
  String profilePic;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.occupation,
    required this.profilePic,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
      };
}
