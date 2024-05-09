// To parse this JSON data, do
//
//     final roomModel = roomModelFromJson(jsonString);

import 'dart:convert';

String roomModelToJson(RoomModel data) => json.encode(data.toJson());

class RoomModel {
  Room? room;
  List<Message> messages;

  RoomModel({
    required this.room,
    required this.messages,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json, String? userId) =>
      RoomModel(
        room: json["room"] == null ? null: Room.fromJson(json["room"]),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x, userId))),
      );

  Map<String, dynamic> toJson() => {
        "room": room!.toJson(),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
      };
}

class Message {
  String id;
  String? message;
  String? image;
  String? thread;
  DateTime createdAt;
  Sender sender;
  bool isSeenByAll;

  Message({
    required this.id,
    this.message,
    this.image,
    this.thread,
    required this.createdAt,
    required this.sender,
    required this.isSeenByAll,
  });

  factory Message.fromJson(Map<String, dynamic> json, String? userId) =>
      Message(
        id: json["_id"],
        message: json["message"],
        image: json["image"],
        thread: json["thread"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        sender: Sender.fromJson(json["sender"], userId),
        isSeenByAll: json["isSeenByAll"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "message": message,
        "image": image,
        "thread": thread,
        "createdAt": createdAt.toIso8601String(),
        "sender": sender.toJson(),
        "isSeenByAll": isSeenByAll,
      };
}

class Sender {
  String id;
  String profilePic;
  String username;
  String name;
  String occupation;
  String email;
  bool isOwner;

  Sender({
    required this.id,
    required this.profilePic,
    required this.username,
    required this.name,
    required this.occupation,
    required this.email,
    required this.isOwner,
  });

  factory Sender.fromJson(Map<String, dynamic> json, String? userId) => Sender(
        id: json["_id"],
        profilePic: json["profile_pic"],
        username: json["username"],
        name: json["name"],
        occupation: json["occupation"],
        email: json["email"],
        isOwner: json["_id"] == userId,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profile_pic": profilePic,
        "username": username,
        "name": name,
        "occupation": occupation,
        "email": email,
        "isOwner": isOwner,
      };
}

class Room {
  bool isGroup;
  List<String> participants;
  String id;
  String roomId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Room({
    required this.isGroup,
    required this.participants,
    required this.id,
    required this.roomId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        isGroup: json["isGroup"],
        participants: List<String>.from(json["participants"].map((x) => x)),
        id: json["_id"],
        roomId: json["roomId"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isGroup": isGroup,
        "participants": List<dynamic>.from(participants.map((x) => x)),
        "_id": id,
        "roomId": roomId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
