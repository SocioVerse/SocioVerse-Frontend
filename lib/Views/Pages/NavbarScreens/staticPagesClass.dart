import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/searchFeeds.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/NewThread/newThread.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';

class NavigatorPage {
  static List<Widget> pages = [
    LoadingOverlayAlt(child: const FeedsPage()),
    LoadingOverlayAlt(child: const SearchFeedsPage()),
    LoadingOverlayAlt(child: const NewThread()),
    LoadingOverlayAlt(child: const ActivityPage()),
    LoadingOverlayAlt(
      child: UserProfilePage(
        owner: true,
        userId: null,
      ),
    ),
  ];
}
