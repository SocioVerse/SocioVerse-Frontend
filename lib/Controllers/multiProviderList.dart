import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:socioverse/Controllers/countryListPageProvider.dart';
import 'package:socioverse/Controllers/fillProfileDetailsPageProvider.dart';
import 'package:socioverse/Controllers/passwordSignUpPageProvider.dart';
import 'package:socioverse/Controllers/passwordSingInPageProvider.dart';
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
  ];
}
