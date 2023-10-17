import 'package:flutter/material.dart';
import 'package:socioverse/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Pages/NavbarScreens/userProfilePage.dart';
import 'package:socioverse/Pages/SettingsPages/activityPage.dart';

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
