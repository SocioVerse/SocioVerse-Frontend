import 'dart:convert';

class SignupUser {
  String? name;
  String? email;
  String? phoneNumber;
  String? password;
  String? username;
  String? occupation;
  String? country;
  DateTime? dob;
  List<String>? faceImageDataset;
  String? profilePic;

  SignupUser({
    this.name,
    this.email,
    this.phoneNumber,
    this.password,
    this.username,
    this.occupation,
    this.country,
    this.dob,
    this.profilePic,
  });

  factory SignupUser.fromRawJson(String str) =>
      SignupUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SignupUser.fromJson(Map<String, dynamic> json) => SignupUser(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        password: json["password"],
        username: json["username"],
        occupation: json["occupation"],
        country: json["country"],
        dob: DateTime.parse(json["dob"]),
        profilePic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "username": username,
        "occupation": occupation,
        "country": country,
        "dob": dob!.toIso8601String(),
        "profile_pic": profilePic,
        "face_image_dataset": faceImageDataset,
      };
}

class LoginUser {
  String usernameAndEmail;
  String password;
  String fcmtoken;

  LoginUser({
    required this.usernameAndEmail,
    required this.password,
    required this.fcmtoken,
  });

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "usernameOrEmail": usernameAndEmail,
        "password": password,
        "fcmToken": fcmtoken,
      };
}
