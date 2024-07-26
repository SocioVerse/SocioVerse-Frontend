import 'dart:ui';

import 'package:device_preview/device_preview.dart';
import 'package:face_camera/face_camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/multiProviderList.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/activityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/followRequestsPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/mentionsActivityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/storyLikesActivityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatPage.dart';
import 'package:socioverse/Views/UI/theme.dart';
import 'Models/inboxModel.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FaceCamera.initialize();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MultiProvider(
        providers: Providers.providers, child: const MyApp()), // Wrap your app
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    super.initState();
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        _handleMessage(message);
      },
    );
  }

  void _handleMessage(RemoteMessage message) {
    // if app is opened then return

    if (message.data['type'] == 'chat') {
      NavigationService.navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) => ChatPage(
                user: User.fromJson(message.data['user']),
              )));
    } else if (message.data['type'] == 'story-like') {
      NavigationService.navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) => const StoryLikesActivityPage()));
    } else if (message.data['type'] == 'activity') {
      NavigationService.navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) =>
              ActivityPage(title: message.data['activityType'])));
    } else if (message.data['type'] == 'mentions') {
      NavigationService.navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) => const MentionsActivityPage()));
    } else if (message.data['type'] == 'follow-request') {
      NavigationService.navigationKey.currentState!.push(
          MaterialPageRoute(builder: (context) => const FollowRequestsPage()));
    } else if (message.data['type'] == 'repost' ||
        message.data['type'] == 'follow-request-accepted') {
      NavigationService.navigationKey.currentState!.push(MaterialPageRoute(
          builder: (context) => UserProfilePage(
                userId: message.data['userId'],
              )));
    } else {
      // route to default page
      NavigationService.navigationKey.currentState!
          .push(MaterialPageRoute(builder: (context) => const GetInitPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GlobalLoaderOverlay(
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
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          title: 'SocioVerse',
          theme: MyTheme.theme(),
          home: const GetInitPage(),
        ),
      ),
    );
  }
}
