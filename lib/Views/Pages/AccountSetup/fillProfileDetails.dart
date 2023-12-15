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
import 'package:socioverse/Models/authUser_models.dart';
import 'package:socioverse/Views/Pages/AccountSetup/SelectCountry.dart';
import 'package:socioverse/Views/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';
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
  List<String>? faceImages;
  bool? profileImageLoading;
  bool? faceImageLoading=false;
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
      keyboardType: hintTexxt == "Phone number*"
          ? TextInputType.phone
          : TextInputType.text,
      readOnly: readOnly == null ? false : readOnly,
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      maxLength: hintTexxt == "Phone number" ? 10 : null,
      decoration: InputDecoration(
        suffixIcon: suffixxIcon,
        counter: Offstage(),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        CircleAvatar(
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
                              : profileImageLoading == true
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ClipOval(
                                      child: Image.network(
                                        currentImage!,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent?
                                                loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
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
                                        value.path,
                                        signupUser.email!,
                                        "${signupUser.email!}/profilepic",
                                        FirebaseHelper.Image);
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
                    SizedBox(
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
                
                textFieldBuilder(
                    tcontroller: dob,
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
                                        surfaceTint: 
                                        Theme.of(context).colorScheme.background,
                                    surface: Theme.of(context)
                                        .colorScheme
                                        .secondary,
                                    onSurface:
                                        Theme.of(context).colorScheme.background,
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
                        child: Icon(Ionicons.calendar,color: Colors.white,)),
                    readOnly: true,
                    onChangedf: () {}),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                       
                       faceImages = await ImagePickerFunctionsHelper()
                                            .pickMultipleImage(
                                                context
                    
                                            ).then(
                                              (value) async {
                                                if(value!=null){
                                                  List<String> faceImagesList = [];
                                                  setState(() {
                                                      faceImageLoading = true;
                                                    });
                                                    await FirebaseHelper.deleteFolder(
                                                        "${signupUser.email!}/faceImages");
                                                  for(int i=0;i<value.length;i++){
                                                    
                                                    
                                                    String? faceImage = await FirebaseHelper.uploadFile(
                                                        value[i].path,
                                                        "${signupUser.email!}-face-dataset-$i",
                                                        "${signupUser.email!}/faceImages",
                                                        FirebaseHelper.Image);
                                                    faceImagesList.add(faceImage);
                                                  }
                                                  return faceImagesList;
                                                }else{
                                                  return null;
                                                }
                                              }
                                            
                                            );
                        if (faceImages != null) {
                                      setState(() {
                                        faceImageLoading = false;
                                      });
                                    }
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.face_2,
                            color: Theme.of(context).colorScheme.primary,
                            size: 15,
                          ), 
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Add Face Search (Optional)",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    faceImageLoading == true
                        ? SpinKitThreeBounce(
                            color: Theme.of(context).colorScheme.primary,
                            size: 20,
                          )
                        : faceImages != null
                            ? Icon(
                            Icons.done,
                            color: Theme.of(context).colorScheme.primary,
                            size: 15,
                          )
                            : Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                            size: 15,
                          ),
                  ],
                ),
                Padding(
              padding:
                  const EdgeInsets.only(bottom: 8),
              child: MyElevatedButton1(
                  title: "Continue",
                  onPressed: () async {
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
                      signupUser.faceImageDataset = faceImages;
                      log(signupUser.toJson().toString());
                      LoadingOverlayAlt.of(context).show();
                      ApiResponse? response = await AuthServices().userSignUp(
                        signupUser: signupUser,
                      );
                      LoadingOverlayAlt.of(context).hide();
                      if (response!.success == true && context.mounted) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                            (route) => false);
                      } else {
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
                
                
                
                
                
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
