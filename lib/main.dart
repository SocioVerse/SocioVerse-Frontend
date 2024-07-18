import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/countryListPageProvider.dart';
import 'package:socioverse/Controllers/fillProfileDetailsPageProvider.dart';
import 'package:socioverse/Controllers/multiProviderList.dart';
import 'package:socioverse/Controllers/passwordSignUpPageProvider.dart';
import 'package:socioverse/Controllers/passwordSingInPageProvider.dart';
import 'package:socioverse/Controllers/welcomePageProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Views/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Views/Pages/welcome.dart';
import 'package:socioverse/Views/UI/theme.dart';
import 'package:socioverse/push_notifications.dart';
import 'Views/Pages/SocioVerse/StoryPage/storyPageController.dart';
import 'firebase_options.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FaceCamera.initialize();

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
    }
  });

  PushNotifications.init();
  PushNotifications.localNotiInit();
  // Listen to background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
          title: message.notification!.title!,
          body: message.notification!.body!,
          payload: payloadData);
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
      await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(const Duration(seconds: 1), () {});
  }
  runApp(MultiProvider(providers: Providers.providers, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static double? width;
  static double? height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return GlobalLoaderOverlay(
      overlayColor: Colors.transparent,
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) {
        //ignored progress for the moment
        return Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
              child: SizedBox.expand(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            Center(
              child: SpinKit.ring,
            ),
          ],
        );
      },
      child: MaterialApp(
        navigatorKey: NavigationService.navigationKey,
        debugShowCheckedModeBanner: false,
        title: 'SocioVerse',
        theme: MyTheme.theme(),
        home: GetInitPage(),
      ),
    );
  }
}
