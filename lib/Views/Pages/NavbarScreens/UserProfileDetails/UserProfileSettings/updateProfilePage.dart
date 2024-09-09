import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/fillProfileDetailsPageProvider.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Services/user_profile_settings_services.dart';
import 'package:socioverse/Views/Pages/AccountSetup/faceDetectionPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:uuid/uuid.dart';

class UpdateProfilePage extends StatefulWidget {
  final UserProfileDetailsModelUser user;

  const UpdateProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  File? faceDetectImages;
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String? currentImage;
  File? profileImage;
  bool? profileImageLoading;
  @override
  void initState() {
    fullName.text = widget.user.name;
    username.text = widget.user.username;
    occupation.text = widget.user.occupation;
    currentImage = widget.user.profilePic;
    bioController.text = widget.user.bio ?? "";

    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  TextField textFieldBuilder(
      {required TextEditingController tcontroller,
      required String lableText,
      required Function onChangedf,
      int maxLines = 1,
      bool? readOnly}) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
      },
      keyboardType: TextInputType.text,
      readOnly: readOnly ?? false,
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: maxLines,
      decoration: InputDecoration(
        counter: Offstage(),
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        label: Text(
          lableText,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16, color: Theme.of(context).colorScheme.tertiary),
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
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
          "Update Profile Details",
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
                        CircleAvatar(
                          radius: 150,
                          backgroundColor:
                              Theme.of(context).colorScheme.onBackground,
                          child: currentImage == null
                              ? Icon(
                                  Ionicons.person,
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  size: 100,
                                )
                              : profileImage == null
                                  ? profileImageLoading == true
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : CircularNetworkImageWithoutSize(
                                          imageUrl: currentImage!,
                                          fit: BoxFit.cover,
                                        )
                                  : ClipOval(
                                      child: Image.file(
                                      profileImage!,
                                      fit: BoxFit.cover,
                                    )),
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
                                profileImage = await ImagePickerFunctionsHelper
                                    .requestPermissionsAndPickFile(context);

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
                    lableText: "Full Name",
                    onChangedf: () {}),
                textFieldBuilder(
                    tcontroller: username,
                    lableText: "Username",
                    onChangedf: () {}),
                textFieldBuilder(
                    tcontroller: occupation,
                    lableText: "Occupation",
                    onChangedf: () {}),
                textFieldBuilder(
                    tcontroller: bioController,
                    lableText: "Bio",
                    onChangedf: () {},
                    maxLines: 5),
                Consumer<FillProfileProvider>(builder: (context, prov, child) {
                  return TextButton(
                    onPressed: () async {
                      prov.faceImageLoading = true;
                      List<dynamic>? image = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FaceDetectionPage()));
                      if (image != null) {
                        faceDetectImages = image[0] as File;

                        log(faceDetectImages!.path.toString());
                      } else {
                        faceDetectImages = null;
                      }
                      prov.faceImageLoading = false;
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                        prov.faceImageLoading == true
                            ? SpinKit.threeBounce
                            : faceDetectImages != null
                                ? Icon(
                                    Icons.done,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 15,
                                  )
                                : Icon(
                                    Icons.info_outline,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    size: 15,
                                  ),
                      ],
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: MyElevatedButton1(
                      title: "Update Profile",
                      onPressed: () async {
                        if (fullName.text.isEmpty ||
                            username.text.isEmpty ||
                            occupation.text.isEmpty ||
                            currentImage == null) {
                          FlutterToast.flutterWhiteToast("Fill all details");
                          return;
                        } else {
                          context.loaderOverlay.show();
                          String? faceImage;
                          if (profileImage != null) {
                            await FirebaseHelper.deleteFolder(
                                "${widget.user.email}/profilepic");
                            currentImage = await FirebaseHelper.uploadFile(
                                profileImage!.path,
                                widget.user.email,
                                "${widget.user.email}/profilepic",
                                FirebaseHelper.Image);
                          }
                          if (faceDetectImages != null) {
                            faceImage = await FirebaseHelper.uploadFile(
                                faceDetectImages!.path,
                                "${widget.user.email}\$${const Uuid().v4()}.jpg",
                                "Faces",
                                FirebaseHelper.Image);
                          }
                          widget.user.name = fullName.text;
                          widget.user.username = username.text;
                          widget.user.occupation = occupation.text;
                          widget.user.profilePic =
                              currentImage ?? widget.user.profilePic;
                          widget.user.bio = bioController.text;

                          await UserProfileSettingsServices.updateProfile(
                                  widget.user, faceImage)
                              .then((response) {
                            context.loaderOverlay.hide();
                            if (response.success == true && context.mounted) {
                              Navigator.pop(context);
                            } else {
                              FlutterToast.flutterWhiteToast(
                                  response.message.toString());
                            }
                          });
                        }
                      },
                      ctx: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
