import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationModel.dart';

class FeedData {
  List<String> mentions;
  List<String> tags;
  LocationSearchModel? location;
  bool autoEnhanced = false;
  String caption;
  bool isPrivate = false;
  bool allowComments = true;
  bool allowSave = true;
  List<String> images;

  FeedData({
    required this.mentions,
    required this.tags,
    this.location,
    required this.autoEnhanced,
    required this.caption,
    required this.isPrivate,
    required this.allowComments,
    required this.allowSave,
    required this.images,
  });

  factory FeedData.fromJson(Map<String, dynamic> json) {
    return FeedData(
      mentions: List<String>.from(json['mentions']),
      tags: List<String>.from(json['tags']),
      location: LocationSearchModel.fromJson(json['location']),
      autoEnhanced: json['auto_enhanced'],
      caption: json['caption'],
      isPrivate: json['is_private'],
      allowComments: json['allow_comments'],
      allowSave: json['allow_save'],
      images: List<String>.from(json['images']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mentions'] = mentions;
    data['tags'] = tags;
    data['location'] = location == null ? null : location!.toJson();
    data['auto_enhanced'] = autoEnhanced;
    data['caption'] = caption;
    data['is_private'] = isPrivate;
    data['allow_comments'] = allowComments;
    data['allow_save'] = allowSave;
    data['images'] = images;
    return data;
  }
}
