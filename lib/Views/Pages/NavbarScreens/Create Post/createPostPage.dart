import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Helper/get_Routes.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/pickImagePage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThread.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "What's on your mind?",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return const PickImagePage();
                  }));
                },
                leading: Icon(
                  Icons.photo,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "New Feed",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) {
                    return const NewThread();
                  }));
                },
                leading: Icon(
                  Ionicons.text,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "New Thread",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                ),
              ),
            ),

            // new story
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: ListTile(
                onTap: () async {
                  String email =
                      await getStringFromCache(SharedPreferenceString.email);
                  String? storyImage =
                      await ImagePickerFunctionsHelper.requestStoryPicker(
                              context)
                          .then((value) async {
                    if (value != null) {
                      context.loaderOverlay.show();
                      return await FirebaseHelper.uploadFile(value.path, email,
                          "${email}/stories", FirebaseHelper.Image);
                    }
                    return null;
                  });
                  if (storyImage != null) {
                    await StoriesServices.uploadStory(storyImage: [storyImage]);
                    context.loaderOverlay.hide();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GetInitPage()),
                        (route) => false);
                  }
                },
                leading: Icon(
                  Ionicons.time_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  "New Story",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
