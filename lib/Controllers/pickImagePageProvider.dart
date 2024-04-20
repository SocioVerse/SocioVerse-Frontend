import 'package:flutter/foundation.dart';
import 'package:photo_manager/photo_manager.dart';

class PickImageLoadingProvider extends ChangeNotifier {
  bool _loading = true;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }
}

class PickImagePageProvider extends ChangeNotifier {
  int _singleImageIndex = 0;
  List<int> _selectedIndex = [];
  int _imageCount = 0;
  bool _multiSelect = false;
  List<AssetEntity> _assets = [];
  AssetEntity? _selectedAsset;

  int get singleImageIndex => _singleImageIndex!;
  List<AssetEntity> get assets => _assets;
  List<int> get selectedIndex => _selectedIndex;
  int get imageCount => _imageCount;
  bool get multiSelect => _multiSelect;
  AssetEntity get selectedAsset => _selectedAsset!;

  dispose() {
    _singleImageIndex = 0;
    _selectedIndex = [];
    _imageCount = 0;
    _multiSelect = false;
    _assets = [];
    _selectedAsset = null;
    notifyListeners();
  }

  set singleImageIndex(int value) {
    _singleImageIndex = value;
    notifyListeners();
  }

  set selectedAsset(AssetEntity value) {
    _selectedAsset = value;
    notifyListeners();
  }

  set selectedIndex(List<int> value) {
    _selectedIndex = value;
    notifyListeners();
  }

  set imageCount(int value) {
    _imageCount = value;
    notifyListeners();
  }

  set multiSelect(bool value) {
    _multiSelect = value;
    notifyListeners();
  }

  set assets(List<AssetEntity> value) {
    _assets = value;
    notifyListeners();
  }

  void addSelectedIndex(int index) {
    _selectedIndex.add(index);
    notifyListeners();
  }

  void removeSelectedIndex(int index) {
    _selectedIndex.remove(index);
    notifyListeners();
  }

  void clearSelectedIndex() {
    _selectedIndex.clear();
    notifyListeners();
  }

  void addAsset(List<AssetEntity> asset) {
    _assets.addAll(asset);
    notifyListeners();
  }
}
