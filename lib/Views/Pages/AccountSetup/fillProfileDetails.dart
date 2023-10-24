import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/authUser_models.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/services/authentication_services.dart';
import '../../Widgets/buttons.dart';

class FillProfilePage extends StatefulWidget {
  final SignupUser signupUser;
  FillProfilePage({super.key, required this.signupUser});

  @override
  State<FillProfilePage> createState() => _FillProfilePageState();
}

class _FillProfilePageState extends State<FillProfilePage> {
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController cCode = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController dob = TextEditingController();
  String? currentImage;
  bool? profileImageLoading;
  String initValue = "Select your Birth Date";
  bool isDateSelected = false;
  DateTime? birthDate; // instance of DateTime
  String? birthDateInString;
  late SignupUser signupUser;
  @override
  void initState() {
    // TODO: implement initState
    signupUser = widget.signupUser;
    currentImage = null;
    super.initState();
    cCode.text = "+91";
  }

  TextField textFieldBuilder(
      {required TextEditingController tcontroller,
      required String hintTexxt,
      required Function onChangedf,
      Widget? suffixxIcon,
      bool? readOnly}) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
      },
      keyboardType: hintTexxt == "Phone number"
          ? TextInputType.phone
          : TextInputType.text,
      readOnly: readOnly == null ? false : readOnly,
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: suffixxIcon,
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintTexxt,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill Profile Details",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 150,
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground,
                            backgroundImage: currentImage == null
                                ? null
                                : NetworkImage(currentImage!),
                            child: currentImage == null
                                ? Icon(
                                    Ionicons.person,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    size: 100,
                                  )
                                : profileImageLoading == true
                                    ? Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : null,
                          ),
                          Positioned(
                            bottom: 10,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: IconButton(
                                iconSize: 30,
                                padding: EdgeInsets.all(0),
                                onPressed: () async {
                                  currentImage =
                                      await ImagePickerFunctionsHelper()
                                          .requestPermissionsAndPickFile(
                                              context)
                                          .then((value) async {
                                    if (value != null) {
                                      setState(() {
                                        profileImageLoading = true;
                                      });
                                      await FirebaseHelper.deleteFolder(
                                          "${signupUser!.email!}/profilepic");
                                      return await FirebaseHelper.uploadFile(
                                          value!.path,
                                          signupUser!.email!,
                                          "${signupUser!.email!}/profilepic");
                                    } else {
                                      return null;
                                    }
                                  });

                                  print(currentImage.toString());
                                  if (currentImage != null) {
                                    setState(() {
                                      profileImageLoading = false;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.shadow,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  textFieldBuilder(
                      tcontroller: fullName,
                      hintTexxt: "Full Name",
                      onChangedf: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                      tcontroller: username,
                      hintTexxt: "Username",
                      onChangedf: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: textFieldBuilder(
                              tcontroller: cCode,
                              hintTexxt: "+91",
                              onChangedf: () {})),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 5,
                        child: textFieldBuilder(
                          tcontroller: phone,
                          hintTexxt: "Phone number",
                          onChangedf: () {},
                          suffixxIcon: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                      tcontroller: occupation,
                      hintTexxt: "Occupation",
                      onChangedf: () {}),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldBuilder(
                      tcontroller: dob,
                      hintTexxt: "DOB",
                      suffixxIcon: GestureDetector(
                          onTap: () async {
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.dark().copyWith(
                                    colorScheme: ColorScheme.dark(
                                      primary:
                                          Theme.of(context).colorScheme.primary,
                                      onPrimary: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      surface: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onSurface:
                                          Theme.of(context).colorScheme.surface,
                                    ),
                                    dialogBackgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (picked != null && picked != birthDate) {
                              setState(() {
                                birthDate = picked;
                                birthDateInString =
                                    "${birthDate!.day}/${birthDate!.month}/${birthDate!.year}";
                                isDateSelected = true;
                                dob.text = birthDateInString!;
                              });
                            }
                          },
                          child: Icon(Ionicons.calendar)),
                      readOnly: true,
                      onChangedf: () {}),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 10, left: 8, right: 8, top: 0),
              child: MyElevatedButton1(
                  title: "Continue",
                  onPressed: () async {
                    print("here");
                    if (fullName.text.isEmpty ||
                        username.text.isEmpty ||
                        phone.text.isEmpty ||
                        occupation.text.isEmpty ||
                        dob.text.isEmpty ||
                        currentImage == null) {
                      Fluttertoast.showToast(
                        msg: "Fill all details",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 16.0,
                      );
                      return;
                    } else {
                      signupUser.name = fullName.text;
                      signupUser.username = username.text;
                      signupUser.phoneNumber = phone.text;
                      signupUser.occupation = occupation.text;
                      signupUser.dob = birthDate;
                      signupUser.profilePic = currentImage;
                      log(signupUser.toJson().toString());
                      showDialog(
                          context: context,
                          builder: (_) => SpinKitWave(
                              color: Colors.white,
                              type: SpinKitWaveType.center));
                      ApiResponse? response = await AuthServices().userSignUp(
                        signupUser: signupUser,
                      );
                      if (response!.success == true && context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false);
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: response!.message.toString(),
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          fontSize: 16.0,
                        );
                      }
                    }
                  },
                  ctx: context),
            ),
          ),
        ],
      ),
    );
  }
}
