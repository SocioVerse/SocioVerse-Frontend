
import 'package:face_camera/face_camera.dart';
import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/Authentication/passwordSignUpPage.dart';
import 'package:socioverse/Views/UI/theme.dart';

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
      home: PasswordSignUpPage(),
      // home: LocationProfilePage(
      //     locationName: "New York",
      //     city: "New York",
      //     state: "New York",
      //     country: "United States",
      //     postsCount: 3570000540),
    );
  }
}
