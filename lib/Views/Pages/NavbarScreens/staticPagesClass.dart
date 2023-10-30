import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SettingsPages/activityPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/newThread.dart';

class NavigatorPage {
  static List<Widget> pages = [
    FeedsPage(),
    SearchFeedsPage(),
    NewThread(),
    ActivityPage(),
    UserProfilePage(
      owner: true,
    ),
  ];
}
