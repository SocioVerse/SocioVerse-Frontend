import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Pages/welcome.dart';

class GetInitPage extends StatefulWidget {
  const GetInitPage({super.key});

  @override
  State<GetInitPage> createState() => _GetInitPageState();
}

class _GetInitPageState extends State<GetInitPage> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  Future<bool?> isLoggedIn() async {
    return await getBooleanFromCache(SharedPreferenceString.isLoggedIn);
  }

  Future<bool?> isIntroDone() async {
    return await getBooleanFromCache(SharedPreferenceString.isIntroDone);
  }

  Future<void> _requestNotificationPermission() async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      log('Requesting Notification Permission');
      await Permission.notification.request();
    }
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
