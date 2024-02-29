// To parse this JSON data, do
//
//     final locationSearchModel = locationSearchModelFromJson(jsonString);

import 'dart:convert';

LocationSearchModel locationSearchModelFromJson(String str) =>
    LocationSearchModel.fromJson(json.decode(str));

String locationSearchModelToJson(LocationSearchModel data) =>
    json.encode(data.toJson());

class LocationSearchModel {
  String name;
  String type;
  String country;
  String state;
  int postCount;
  Geometry geometry;

  LocationSearchModel({
    required this.name,
    required this.type,
    required this.country,
    required this.state,
    required this.postCount,
    required this.geometry,
  });

  factory LocationSearchModel.fromJson(Map<String, dynamic> json) =>
      LocationSearchModel(
        name: json["name"],
        type: json["type"],
        country: json["country"] ?? "",
        state: json["state"] == null ? "" : json["state"] + ',',
        postCount: json["post_count"],
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "country": country,
        "state": state,
        "latitude": geometry.coordinates[0],
        "longitude": geometry.coordinates[1],
      };
}

class Geometry {
  List<double> coordinates;

  Geometry({
    required this.coordinates,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
