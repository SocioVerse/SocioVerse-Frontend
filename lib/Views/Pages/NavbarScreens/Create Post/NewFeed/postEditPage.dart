import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/searchHashtagsPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationSearchPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Tag%20People/tagPeoplePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/newFeedModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/services/feed_services.dart';
import 'package:socioverse/services/user_services.dart';
import 'package:uuid/uuid.dart';

class PostEditPage extends StatefulWidget {
  final List<File> images;
  const PostEditPage({super.key, required this.images});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  bool autoEnhance = false;
  bool public = false;
  bool allowComments = false;
  bool allowSave = false;
  LocationSearchModel? selectedLocation;
  List<SearchedUser> taggedUser = [];
  List<HashtagsSearchModel> hashtagList = [];
  String? userEmail;
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    autoEnhance = true;
    public = true;
    allowComments = true;
    allowSave = true;
    getUserInfo();
    super.initState();
  }

  getUserInfo() async {
    userEmail =
        await UserServices().getUserDetails().then((value) => value[0].email);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
        ),
        toolbarHeight: 65,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  if (userEmail == null) {
                    return;
                  }
                  LoadingOverlayAlt.of(context).show();
                  List<String> images = [];
                  //use for loop
                  for (var i = 0; i < widget.images.length; i++) {
                    log(widget.images[i].path.toString());
                    String url = await FirebaseHelper.uploadFile(
                        widget.images[i].path,
                        "${Uuid().v4()}.jpg",
                        "$userEmail/feeds",
                        FirebaseHelper.Image);
                    images.add(url);
                  }
                  await FeedServices().createFeed(
                      postData: FeedData(
                          caption: captionController.text,
                          allowComments: allowComments,
                          allowSave: allowSave,
                          autoEnhanced: autoEnhance,
                          isPrivate: !public,
                          location: selectedLocation,
                          images: images,
                          mentions: taggedUser.map((e) => e.username).toList(),
                          tags: hashtagList.map((e) => e.hashtag).toList()));
                  if (context.mounted) {
                    LoadingOverlayAlt.of(context).hide();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage(
                                  index: 0,
                                )),
                        (route) => false);
                  }
                },
                icon: Icon(
                  Icons.done,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                )),
          ),
        ],
      ),
      body: userEmail == null
          ? SpinKitRing(
              color: Theme.of(context).colorScheme.tertiary,
              lineWidth: 1,
              duration: const Duration(seconds: 1),
            )
          : SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width - 40,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.width - 40,
                                  width: MediaQuery.of(context).size.width - 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(widget.images[index]),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFieldBuilder2(
                        tcontroller: captionController,
                        hintTexxt: "Write a caption...",
                        onChangedf: () {},
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Text(
                          "#",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        onTap: () async {
                          dynamic taggedUser = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchHashtagPage(
                              hashtagList: hashtagList,
                            );
                          }));
                          if (taggedUser != null) {
                            setState(() {
                              hashtagList = hashtagList;
                            });
                          }
                        },
                        title: hashtagList.isEmpty
                            ? Text(
                                "Add Hashtags",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              )
                            : SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: hashtagList.length,
                                  itemBuilder: (context, index) {
                                    return Chip(
                                      label: Text(hashtagList[index].hashtag,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 12,
                                              )),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onDeleted: () {
                                        setState(() {
                                          hashtagList.removeWhere((element) =>
                                              element.id ==
                                              hashtagList[index].id);
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.person_add,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onTap: () async {
                          dynamic taggedUser = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return TagPeoplePage(
                              taggedUser: this.taggedUser,
                            );
                          }));
                          if (taggedUser != null) {
                            setState(() {
                              this.taggedUser = taggedUser;
                            });
                          }
                        },
                        title: taggedUser.isEmpty
                            ? Text(
                                "Tag People",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              )
                            : SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: taggedUser.length,
                                  itemBuilder: (context, index) {
                                    return Chip(
                                      label: Text(taggedUser[index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 12,
                                              )),
                                      backgroundColor: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      onDeleted: () {
                                        setState(() {
                                          taggedUser.removeWhere((element) =>
                                              element.id ==
                                              taggedUser[index].id);
                                        });
                                      },
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () async {
                          dynamic location = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const LocationSearchPage();
                          }));
                          if (location != null) {
                            location = location as LocationSearchModel;
                            setState(() {
                              selectedLocation = location;
                            });
                          }
                        },
                        leading: Icon(
                          Ionicons.location,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                          selectedLocation == null
                              ? "Add Location"
                              : selectedLocation!.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.grey[600],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Additional Features"),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.sparkles,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                          "Auto Enhance",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        trailing: Switch(
                          value: autoEnhance,
                          onChanged: (value) {
                            setState(() {
                              autoEnhance = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.people,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                          "Public",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        trailing: Switch(
                          value: public,
                          onChanged: (value) {
                            setState(() {
                              public = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.chatbubble_ellipses,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                          "Allow Comments",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        trailing: Switch(
                          value: allowComments,
                          onChanged: (value) {
                            setState(() {
                              allowComments = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        leading: Icon(
                          Ionicons.bookmark_outline,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        title: Text(
                          "Allow Save",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        trailing: Switch(
                          value: allowSave,
                          onChanged: (value) {
                            setState(() {
                              allowSave = value;
                            });
                          },
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ))),
    );
  }
}
