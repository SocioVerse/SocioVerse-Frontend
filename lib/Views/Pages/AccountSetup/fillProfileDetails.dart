import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:face_camera/face_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/fillProfileDetailsPageProvider.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/ServiceHelpers/apiResponse.dart';
import 'package:socioverse/Models/authUserModels.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Services/authentication_services.dart';
import 'package:uuid/uuid.dart';
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
  File? currentImage;
  List<String>? faceImages;
  String initValue = "Select your Birth Date";
  File? faceDetectImages;
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
      keyboardType: hintTexxt == "Phone number*"
          ? TextInputType.phone
          : TextInputType.text,
      readOnly: readOnly ?? false,
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      maxLength: hintTexxt == "Phone number*" ? 10 : null,
      decoration: InputDecoration(
        suffixIcon: suffixxIcon,
        counter: const Offstage(),
        contentPadding: const EdgeInsets.all(20),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        Consumer<FillProfileProvider>(
                            builder: (context, prov, child) {
                          return CircleAvatar(
                            radius: 150,
                            backgroundColor:
                                Theme.of(context).colorScheme.onBackground,
                            child: currentImage == null
                                ? Icon(
                                    Ionicons.person,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                    size: 100,
                                  )
                                : prov.profileImageLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : ClipOval(
                                        child: Image.file(currentImage!,
                                            fit: BoxFit.cover),
                                      ),
                          );
                        }),
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
                            child: Consumer<FillProfileProvider>(
                                builder: (context, prov, child) {
                              return IconButton(
                                iconSize: 30,
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  prov.profileImageLoading = true;
                                  currentImage =
                                      await ImagePickerFunctionsHelper
                                          .requestPermissionsAndPickFile(
                                              context);

                                  log(currentImage.toString());
                                  prov.profileImageLoading = false;
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).colorScheme.shadow,
                                ),
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                textFieldBuilder(
                    tcontroller: fullName,
                    hintTexxt: "Full Name*",
                    onChangedf: () {}),
                textFieldBuilder(
                    tcontroller: username,
                    hintTexxt: "Username*",
                    onChangedf: () {}),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: textFieldBuilder(
                            tcontroller: cCode,
                            hintTexxt: "+91",
                            onChangedf: () {})),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: textFieldBuilder(
                        tcontroller: phone,
                        hintTexxt: "Phone number*",
                        onChangedf: () {},
                        suffixxIcon: const Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                textFieldBuilder(
                    tcontroller: occupation,
                    hintTexxt: "Occupation*",
                    onChangedf: () {}),
                Consumer<FillProfileProvider>(builder: (context, prov, child) {
                  return textFieldBuilder(
                      tcontroller: prov.dob,
                      hintTexxt: "DOB*",
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
                                      surfaceTint: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      surface: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onSurface: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                                    dialogBackgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: child!,
                                );
                              },
                            );

                            if (picked != null && picked != prov.birthDate) {
                              prov.birthDate = picked;
                              prov.birthDateInString =
                                  "${prov.birthDate!.day}/${prov.birthDate!.month}/${prov.birthDate!.year}";
                              prov.isDateSelected = true;
                              prov.dob.text = prov.birthDateInString!;
                            }
                          },
                          child: const Icon(
                            Ionicons.calendar,
                            color: Colors.white,
                          )),
                      readOnly: true,
                      onChangedf: () {});
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Consumer<FillProfileProvider>(
                        builder: (context, prov, child) {
                      return TextButton(
                        onPressed: () async {
                          prov.faceImageLoading = true;
                          List<dynamic>? image = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const FaceDetectionPage()));
                          if (image != null) {
                            faceDetectImages = image[0] as File;

                            log(faceDetectImages!.path.toString());
                          } else {
                            faceDetectImages = null;
                          }
                          prov.faceImageLoading = false;
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.face_2,
                              color: Theme.of(context).colorScheme.primary,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add Face Search (Optional)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }),
                    Consumer<FillProfileProvider>(
                        builder: (context, prov, child) {
                      return prov.faceImageLoading == true
                          ? SpinKit.threeBounce
                          : faceDetectImages != null
                              ? Icon(
                                  Icons.done,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 15,
                                )
                              : Icon(
                                  Icons.info_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 15,
                                );
                    }),
                  ],
                ),
                Consumer<FillProfileProvider>(builder: (context, prov, child) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: MyElevatedButton1(
                        title: "Continue",
                        onPressed: () async {
                          if (prov.faceImageLoading == true) {
                            FlutterToast.flutterWhiteToast(
                                "Wait for face images to upload");
                            return;
                          }
                          if (fullName.text.isEmpty ||
                              username.text.isEmpty ||
                              phone.text.isEmpty ||
                              occupation.text.isEmpty ||
                              prov.dob.text.isEmpty ||
                              currentImage == null) {
                            FlutterToast.flutterWhiteToast("Fill all details");
                            return;
                          } else {
                            context.loaderOverlay.show();
                            String? faceImage, dp;
                            if (faceDetectImages != null) {
                              faceImage = await FirebaseHelper.uploadFile(
                                  faceDetectImages!.path,
                                  "${signupUser.email!}\$${const Uuid().v4()}.jpg",
                                  "Faces",
                                  FirebaseHelper.Image);
                            }
                            if (currentImage != null) {
                              await FirebaseHelper.deleteFolder(
                                  "${signupUser!.email!}/profilepic");
                              dp = await FirebaseHelper.uploadFile(
                                  currentImage!.path,
                                  signupUser.email!,
                                  "${signupUser.email!}/profilepic",
                                  FirebaseHelper.Image);
                            }
                            signupUser.name = fullName.text;
                            signupUser.username = username.text;
                            signupUser.phoneNumber = phone.text;
                            signupUser.occupation = occupation.text;
                            signupUser.dob = prov.birthDate;
                            signupUser.profilePic = dp;
                            signupUser.faceImageDataset =
                                faceDetectImages == null ? null : [faceImage];
                            log(signupUser.toJson().toString());

                            ApiResponse? response =
                                await AuthServices.userSignUp(
                              signupUser: signupUser,
                            );
                            context.loaderOverlay.hide();
                            if (response!.success == true && context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                  (route) => false);
                            } else {
                              FlutterToast.flutterWhiteToast(
                                  response!.message.toString());
                            }
                          }
                        },
                        ctx: context),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
