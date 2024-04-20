import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:socioverse/Controllers/Widget/newThreadWidgetProvider.dart';
import 'package:socioverse/Controllers/activityPageProvider.dart';
import 'package:socioverse/Controllers/bottomNavigationProvider.dart';
import 'package:socioverse/Controllers/countryListPageProvider.dart';
import 'package:socioverse/Controllers/createNewPasswordPageProvider.dart';
import 'package:socioverse/Controllers/feedPageProviders.dart';
import 'package:socioverse/Controllers/fillProfileDetailsPageProvider.dart';
import 'package:socioverse/Controllers/followRequestPageProvider.dart';
import 'package:socioverse/Controllers/hashtagPostEditProvider.dart';
import 'package:socioverse/Controllers/locationSearchPageProvider.dart';
import 'package:socioverse/Controllers/newThreadPageProvider.dart';
import 'package:socioverse/Controllers/passwordSignUpPageProvider.dart';
import 'package:socioverse/Controllers/passwordSingInPageProvider.dart';
import 'package:socioverse/Controllers/pickImagePageProvider.dart';
import 'package:socioverse/Controllers/postEditingProvider.dart';
import 'package:socioverse/Controllers/tagPeoplePageProvider.dart';
import 'package:socioverse/Controllers/userProfileWidgetProvider.dart';
import 'package:socioverse/Controllers/welcomePageProvider.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageController.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<StoryIndexProvider>(
      create: (_) => StoryIndexProvider(),
    ),
    ChangeNotifierProvider<WelcomePageProvider>(
      create: (_) => WelcomePageProvider(),
    ),
    ChangeNotifierProvider<PasswordSignUpPageProvider>(
      create: (_) => PasswordSignUpPageProvider(),
    ),
    ChangeNotifierProvider<PasswordSignInPageProvider>(
      create: (_) => PasswordSignInPageProvider(),
    ),
    ChangeNotifierProvider<CountryListProvider>(
      create: (_) => CountryListProvider(),
    ),
    ChangeNotifierProvider<FillProfileProvider>(
      create: (_) => FillProfileProvider(),
    ),
    ChangeNotifierProvider<CreateNewPasswordPageProvider>(
      create: (_) => CreateNewPasswordPageProvider(),
    ),
    ChangeNotifierProvider<LocationSearchProvider>(
      create: (_) => LocationSearchProvider(),
    ),
    ChangeNotifierProvider<FollowRequestPageProvider>(
      create: (_) => FollowRequestPageProvider(),
    ),
    ChangeNotifierProvider<ActivityPageProvider>(
      create: (_) => ActivityPageProvider(),
    ),
    ChangeNotifierProvider<CreateNewThreadAlertBoxProvider>(
      create: (_) => CreateNewThreadAlertBoxProvider(),
    ),
    ChangeNotifierProvider<PickImagePageProvider>(
      create: (_) => PickImagePageProvider(),
    ),
    ChangeNotifierProvider<PickImageLoadingProvider>(
      create: (_) => PickImageLoadingProvider(),
    ),
    ChangeNotifierProvider<UserProfileWidgetBioProvider>(
      create: (_) => UserProfileWidgetBioProvider(),
    ),
    ChangeNotifierProvider<PostEditAdditionalFeatureProvider>(
      create: (_) => PostEditAdditionalFeatureProvider(),
    ),
    ChangeNotifierProvider<TagPeoplePageProvider>(
      create: (_) => TagPeoplePageProvider(),
    ),
    ChangeNotifierProvider<HashtagPageProvider>(
      create: (_) => HashtagPageProvider(),
    ),
    ChangeNotifierProvider<PostEditProvider>(
      create: (_) => PostEditProvider(),
    ),
    ChangeNotifierProvider<PostEditingEmailProvider>(
      create: (_) => PostEditingEmailProvider(),
    ),
    ChangeNotifierProvider<NewThreadPageProvider>(
      create: (_) => NewThreadPageProvider(),
    ),
    ChangeNotifierProvider<FeedPageProvider>(
      create: (_) => FeedPageProvider(),
    ),
    ChangeNotifierProvider<NavigatorPageProvider>(
      create: (_) => NavigatorPageProvider(),
    ),
  ];
}
