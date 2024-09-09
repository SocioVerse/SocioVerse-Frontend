import 'package:flutter/material.dart';
import 'package:socioverse/Models/hashtagModels.dart';

class HashtagPageProvider extends ChangeNotifier {
  bool _isLoading = false;
  List<HashtagsSearchModel> _searchedHashtags = [];
  bool get isLoading => _isLoading;
  List<HashtagsSearchModel> get searchedHashtags => _searchedHashtags;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set searchedHashtags(List<HashtagsSearchModel> value) {
    _searchedHashtags = value;
    notifyListeners();
  }

  void clearHashtags() {
    _searchedHashtags = [];
    notifyListeners();
  }

  void insertHashtag(String tag) {
    _searchedHashtags.insert(
      0,
      HashtagsSearchModel(
        id: UniqueKey().toString(),
        hashtag: tag,
        postCount: 0,
      ),
    );
    notifyListeners();
  }
}
