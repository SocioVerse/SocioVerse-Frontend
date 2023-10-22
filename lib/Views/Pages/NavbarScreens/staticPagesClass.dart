import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SettingsPages/activityPage.dart';

class NavigatorPage {
  static List<Widget> pages = [
    FeedsPage(),
    SearchFeedsPage(),
    PickImagePage(),
    ActivityPage(),
    UserProfilePage(
      owner: true,
    ),
  ];
}
