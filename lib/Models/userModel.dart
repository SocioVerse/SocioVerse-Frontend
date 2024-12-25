import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String username;
  String occupation;
  String profilePic;
  String country;
  DateTime dob;
  String? faceImageDataset;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.occupation,
    required this.profilePic,
    required this.country,
    required this.dob,
    this.faceImageDataset,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
        country: json["country"],
        dob: DateTime.parse(json["dob"]),
        faceImageDataset: json["face_image_dataset"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
        "country": country,
        "dob": dob.toIso8601String(),
        "face_image_dataset": faceImageDataset,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
