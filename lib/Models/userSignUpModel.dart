import 'dart:convert';

class UserSignUpModel {
  String message;
  String name;
  String email;
  String phoneNumber;
  String username;
  String occupation;
  String profilePic;
  String country;
  DateTime dob;
  List<dynamic> faceImageDataset;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String refreshToken;
  String accessToken;

  UserSignUpModel({
    required this.message,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.username,
    required this.occupation,
    required this.profilePic,
    required this.country,
    required this.dob,
    required this.faceImageDataset,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.refreshToken,
    required this.accessToken,
  });

  factory UserSignUpModel.fromRawJson(String str) =>
      UserSignUpModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpModel(
        message: json["message"],
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        username: json["username"],
        occupation: json["occupation"],
        profilePic: json["profile_pic"],
        country: json["country"],
        dob: DateTime.parse(json["dob"]),
        faceImageDataset:
            List<dynamic>.from(json["face_image_dataset"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]).toLocal(),
        updatedAt: DateTime.parse(json["updatedAt"]).toLocal(),
        v: json["__v"],
        refreshToken: json["refresh_token"],
        accessToken: json["access_token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "username": username,
        "occupation": occupation,
        "profile_pic": profilePic,
        "country": country,
        "dob": dob.toIso8601String(),
        "face_image_dataset":
            List<dynamic>.from(faceImageDataset.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "refresh_token": refreshToken,
        "access_token": accessToken,
      };
}
