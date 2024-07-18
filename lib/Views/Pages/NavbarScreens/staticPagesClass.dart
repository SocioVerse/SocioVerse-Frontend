import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityChoicePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/createPostPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Search/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityPage.dart';

class NavigatorPage {
  static List<Widget> pages = [
    const FeedsPage(),
    const SearchFeedsPage(),
    const CreatePostPage(),
    Activitychoicepage(),
    UserProfilePage(
      owner: true,
      userId: null,
    ),
  ];
}
