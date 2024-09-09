import 'package:flutter/material.dart';
import 'package:socioverse/Utils/CountryList.dart';

import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityChoicePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/createPostPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Search/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';

class NavigatorPageProvider with ChangeNotifier {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const FeedsPage(),
    const SearchFeedsPage(),
    const CreatePostPage(),
    Activitychoicepage(),
    UserProfilePage(
      owner: true,
      userId: null,
    ),
  ];

  List<Widget> get pages => _pages;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
