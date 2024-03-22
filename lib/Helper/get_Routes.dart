import 'package:flutter/material.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Pages/welcome.dart';

class GetInitPage extends StatelessWidget {
  const GetInitPage({super.key});

  Future<bool?> isLoggedIn() async {
    return await getBooleanFromCache(SharedPreferenceString.isLoggedIn);
  }

  Future<bool?> isIntroDone() async {
    return await getBooleanFromCache(SharedPreferenceString.isIntroDone);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([isLoggedIn(), isIntroDone()]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data![0] == true) {
            return const MainPage();
          } else {
            if (snapshot.data![1] == true) {
              return const PasswordSignInPage();
            } else {
              return WelcomePage();
            }
          }
        } else {
          return Scaffold(body: SpinKit.ring);
        }
      },
    );
  }
}
