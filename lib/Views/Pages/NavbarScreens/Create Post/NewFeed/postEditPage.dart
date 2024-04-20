import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/postEditingProvider.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/searchHashtagsPage.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/locationSearchPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/tagPeoplePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/newFeedModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:uuid/uuid.dart';

class PostEditPage extends StatefulWidget {
  final List<File> images;
  const PostEditPage({super.key, required this.images});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PostEditAdditionalFeatureProvider>(context, listen: false)
          .init();
      Provider.of<PostEditProvider>(context, listen: false).init();
      Provider.of<PostEditingEmailProvider>(context, listen: false)
          .getUserInfo();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addtionalFeatureProvider =
        Provider.of<PostEditAdditionalFeatureProvider>(context, listen: false);
    var postEditProvider =
        Provider.of<PostEditProvider>(context, listen: false);

    var emailProvider =
        Provider.of<PostEditingEmailProvider>(context, listen: false);
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
                  if (emailProvider.userEmail == null) {
                    return;
                  }
                  context.loaderOverlay.show();
                  List<String> images = [];
                  //use for loop
                  for (var i = 0; i < widget.images.length; i++) {
                    log(widget.images[i].path.toString());
                    String url = await FirebaseHelper.uploadFile(
                        widget.images[i].path,
                        "${const Uuid().v4()}.jpg",
                        "${emailProvider.userEmail}/feeds",
                        FirebaseHelper.Image);
                    images.add(url);
                  }
                  await FeedServices().createFeed(
                      postData: FeedData(
                          caption: captionController.text,
                          allowComments: addtionalFeatureProvider.allowComments,
                          allowSave: addtionalFeatureProvider.allowSave,
                          autoEnhanced: addtionalFeatureProvider.autoEnhance,
                          isPrivate: !addtionalFeatureProvider.public,
                          location: postEditProvider.selectedLocation,
                          images: images,
                          mentions: postEditProvider.taggedUser
                              .map((e) => e.username)
                              .toList(),
                          tags: postEditProvider.hashtagList
                              .map((e) => e.hashtag)
                              .toList()));
                  if (context.mounted) {
                    context.loaderOverlay.hide();
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
      body: Consumer<PostEditingEmailProvider>(builder: (context, prov, child) {
        return prov.userEmail == null
            ? SpinKit.ring
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
                                    width:
                                        MediaQuery.of(context).size.width - 40,
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SearchHashtagPage(
                                hashtagList: postEditProvider.hashtagList,
                              );
                            }));
                          },
                          title: Consumer<PostEditProvider>(
                              builder: (context, prov, child) {
                            return prov.hashtagList.isEmpty
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
                                : Consumer<PostEditProvider>(
                                    builder: (context, prov, child) {
                                    return SizedBox(
                                      height: 40,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: prov.hashtagList.length,
                                        itemBuilder: (context, index) {
                                          return Chip(
                                            label: Text(
                                                prov.hashtagList[index].hashtag,
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
                                              prov.removeHashtag(
                                                  prov.hashtagList[index]);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                                    );
                                  });
                          }),
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return TagPeoplePage();
                            }));
                          },
                          title: Consumer<PostEditProvider>(
                              builder: (context, prov, child) {
                            return prov.taggedUser.isEmpty
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
                                : Consumer<PostEditProvider>(
                                    builder: (context, prov, child) {
                                    return SizedBox(
                                      height: 40,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: prov.taggedUser.length,
                                        itemBuilder: (context, index) {
                                          return Chip(
                                            label: Text(
                                                prov.taggedUser[index].name,
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
                                              prov.removeTaggedUser(
                                                  prov.taggedUser[index]);
                                            },
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                      ),
                                    );
                                  });
                          }),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ListTile(
                          onTap: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const LocationSearchPage();
                            }));
                          },
                          leading: Icon(
                            Ionicons.location,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          title: Consumer<PostEditProvider>(
                              builder: (context, prov, child) {
                            return Text(
                              prov.selectedLocation == null
                                  ? "Add Location"
                                  : prov.selectedLocation!.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            );
                          }),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Consumer<PostEditAdditionalFeatureProvider>(
                              builder: (context, prov, child) {
                            return Switch(
                              value: prov.autoEnhance,
                              onChanged: (value) {
                                prov.autoEnhance = value;
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            );
                          }),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Consumer<PostEditAdditionalFeatureProvider>(
                              builder: (context, prov, child) {
                            return Switch(
                              value: prov.public,
                              onChanged: (value) {
                                prov.public = value;
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            );
                          }),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Consumer<PostEditAdditionalFeatureProvider>(
                              builder: (context, prov, child) {
                            return Switch(
                              value: prov.allowComments,
                              onChanged: (value) {
                                prov.allowComments = value;
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            );
                          }),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                          trailing: Consumer<PostEditAdditionalFeatureProvider>(
                              builder: (context, prov, child) {
                            return Switch(
                              value: prov.allowSave,
                              onChanged: (value) {
                                prov.allowSave = value;
                              },
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    )));
      }),
    );
  }
}
