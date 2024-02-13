import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/createPostPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Search/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThread.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';

class NavigatorPage {
  static List<Widget> pages = [
    LoadingOverlayAlt(child: const FeedsPage()),
    LoadingOverlayAlt(child: const SearchFeedsPage()),
    LoadingOverlayAlt(child: const CreatePostPage()),
    LoadingOverlayAlt(child: const ActivityPage()),
    LoadingOverlayAlt(
      child: UserProfilePage(
        owner: true,
        userId: null,
      ),
    ),
  ];
}
