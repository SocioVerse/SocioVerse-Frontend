import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/userProfilePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/NewThread/newThread.dart';

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
