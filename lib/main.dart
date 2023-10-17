import 'package:socioverse/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Pages/AccountSetup/fillProfileDetails.dart';
import 'package:socioverse/Pages/AccountSetup/followSomeOne.dart';
import 'package:socioverse/Pages/Authentication/createNewPasswordPage.dart';
import 'package:socioverse/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Pages/Authentication/forgotPassword.dart';
import 'package:socioverse/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Pages/Authentication/socialMediaSignUp.dart';
import 'package:socioverse/Pages/SocioThread/threadSection.dart';
import 'package:socioverse/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Pages/Welcome/welcome.dart';
import 'package:socioverse/Pages/SettingsPages/activityPage.dart';
import 'package:socioverse/Pages/SocioVerse/chatPage.dart';
import 'package:socioverse/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Pages/SocioVerse/hashtagProfilePage.dart';
import 'package:socioverse/Pages/SocioVerse/inboxPage.dart';
import 'package:socioverse/Pages/SocioVerse/locationProfilePage.dart';
import 'package:socioverse/Pages/NavbarScreens/pickImagePage.dart';
import 'package:socioverse/Pages/SocioVerse/postEditPage.dart';
import 'package:socioverse/Pages/SocioVerse/storyPage.dart';
import 'package:socioverse/UI/theme.dart';
import 'package:socioverse/Pages/SocioVerse/commentPage.dart';
import 'package:socioverse/Widgets/feeds_widget.dart';
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'Pages/Authentication/forgotPasswordMotp.dart';
import 'Pages/NavbarScreens/searchFeeds.dart';
import 'Pages/NavbarScreens/userProfilePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this

  await FaceCamera.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static double? width;
  static double? height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SocioVerse',
      theme: theme(),
      home: MainPage(),
      // home: LocationProfilePage(
      //     locationName: "New York",
      //     city: "New York",
      //     state: "New York",
      //     country: "United States",
      //     postsCount: 3570000540),
    );
  }
}
