import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageController.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageWidgets.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/bottomSheets.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../Widgets/buttons.dart';
import 'package:socioverse/Models/inboxModel.dart' as inbox;

class StoryPage extends StatefulWidget {
  final User user;
  const StoryPage({required this.user});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  StoryController storyController = StoryController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<ReadStoryModel>>(
          future: StoriesServices.getUserStory(userId: widget.user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            } else {
              List<ReadStoryModel> fetchedStories =
                  snapshot.data as List<ReadStoryModel>;
              List<StoryItem> storyItems = fetchedStories
                  .map((e) => StoryItem.pageImage(
                        url: e.image,
                        controller: storyController,
                        imageFit: BoxFit.contain,
                      ))
                  .toList();

              return ChangeNotifierProvider<StoryIndexProvider>(
                create: (_) => StoryIndexProvider(),
                child: StoryPageContent(
                  storyItems: storyItems,
                  fetchedStories: fetchedStories,
                  storyController: storyController,
                  user: widget.user,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class StoryPageContent extends StatelessWidget {
  final List<ReadStoryModel> fetchedStories;
  final List<StoryItem> storyItems;
  final StoryController storyController;
  final User user;
  StoryPageContent({
    required this.fetchedStories,
    required this.storyItems,
    required this.storyController,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final storyIndexProvider =
        Provider.of<StoryIndexProvider>(context, listen: false);

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              StoryView(
                storyItems: storyItems,
                onStoryShow: (s) async {
                  storyIndexProvider.updateIndex(storyItems.indexOf(s));
                  await StoriesServices.storySeen(
                      storyId:
                          fetchedStories[storyIndexProvider.currentIndex].id);
                },
                onComplete: () async {
                  await StoriesServices.storySeen(
                          storyId:
                              fetchedStories[storyIndexProvider.currentIndex]
                                  .id)
                      .then(
                    (value) => Navigator.pop(context),
                  );
                },
                progressPosition: ProgressPosition.top,
                repeat: false,
                controller: storyController,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UserProfilePage(
                        owner: user.isOwner,
                        userId: user.id,
                      );
                    }));
                  },
                  leading: CircularNetworkImageWithSizeWithoutPhotoView(
                      imageUrl: user.profilePic, height: 60, width: 60),
                  title: Text(
                    user.username,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            offset: Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  subtitle: Text(
                    user.occupation,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            offset: Offset(0, 0),
                            blurRadius: 5,
                          ),
                        ],
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  trailing: user.isOwner == true
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            storyController.pause();
                            showOptions(context)
                                .then((value) => storyController.play());
                          },
                          icon: Icon(
                            Ionicons.ellipsis_horizontal_circle_outline,
                            shadows: const [
                              Shadow(
                                  color: Colors.black,
                                  offset: Offset(0, 0),
                                  blurRadius: 5)
                            ],
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Consumer<StoryIndexProvider>(
          builder: (context, storyIndexProvider, _) {
            return StoryPageControllers(
              storyController: storyController,
              isOwner: user.isOwner,
              readStoryModel: fetchedStories[storyIndexProvider.currentIndex],
            );
          },
        ),
      ],
    );
  }

  Future<dynamic> showOptions(BuildContext context) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.horizontal_rule_rounded,
                size: 50,
                color: Theme.of(context).colorScheme.secondary,
              ),
              ListTile(
                leading: const Icon(
                  Ionicons.warning,
                  color: Colors.red,
                ),
                title: Text(
                  'Report',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  ReportBottomSheet(
                          reportType: "Story",
                          context: context,
                          userId: user.id,
                          storyId: fetchedStories[0].id)
                      .showReportBottomSheet();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.person_remove,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  'Unfollow',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  storyController.pause();
                  UnfollowUserAlertBox(
                      context: context,
                      username: user.username,
                      userId: user.id,
                      onReject: () {});
                },
              ),
              ListTile(
                leading: Icon(
                  Ionicons.eye_off,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                title: Text(
                  user.isStoryHidden == false
                      ? 'Hide My Story'
                      : 'Unhide My Story',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  if (user.isStoryHidden == false) {
                    StoriesServices.hideStory(userId: user.id);
                  } else {
                    StoriesServices.unhideStory(userId: user.id);
                  }
                },
              ),
            ],
          );
        });
  }
}
