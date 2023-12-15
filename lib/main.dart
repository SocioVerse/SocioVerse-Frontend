import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignInPage.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Pages/Welcome/welcome.dart';
import 'package:socioverse/Views/UI/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/get_Routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      home: LoadingOverlayAlt(child: GetInitPage()),
    );
  }
}
