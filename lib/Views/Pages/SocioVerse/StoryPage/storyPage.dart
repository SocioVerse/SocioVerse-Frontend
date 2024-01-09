import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Models/story_models.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageController.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPageWidgets.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/services/stories_services.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../../Widgets/buttons.dart';

class StoryPage extends StatefulWidget {
  final User user;
  StoryPage({required this.user});

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
          future: StoriesServices().getUserStory(userId: widget.user.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
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

  TextEditingController storyMessage = TextEditingController();
  TextEditingController search = TextEditingController();
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
                  await StoriesServices().storySeen(
                      storyId:
                          fetchedStories[storyIndexProvider.currentIndex].id);
                },
                onComplete: () async {
                  await StoriesServices()
                      .storySeen(
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
                  contentPadding: EdgeInsets.all(0),
                  leading: CircularNetworkImageWithSizeWithoutPhotoView(
                      imageUrl: user.profilePic, height: 60, width: 60),
                  title: Text(
                    user.username,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                  subtitle: Text(
                    user.occupation,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.horizontal_rule_rounded,
                                  size: 50,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                ListTile(
                                  leading: const Icon(
                                    Ionicons.warning,
                                    color: Colors.red,
                                  ),
                                  title: Text(
                                    'Report',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 16),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Ionicons.copy_outline),
                                  title: Text(
                                    'Copy Link',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 16),
                                  ),
                                  onTap: () {},
                                ),
                                ListTile(
                                  leading: Icon(Ionicons.send),
                                  title: Text(
                                    'Share to...',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 16),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                        ),
                                        backgroundColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        context: context,
                                        builder: (context) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0, right: 15),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.horizontal_rule_rounded,
                                                  size: 50,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                CustomTextField(
                                                  controller: storyMessage,
                                                  hintText:
                                                      "Write a message...",
                                                  onChanged: (value) {},
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                  child: Divider(
                                                    height: 10,
                                                  ),
                                                ),
                                                CustomTextField(
                                                    controller: search,
                                                    hintText: "Search",
                                                    onChanged: (value) {},
                                                    prefixIcon: Icon(
                                                      Ionicons.search,
                                                      size: 20,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                  child: ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: 10,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return ListTile(
                                                          leading: CircleAvatar(
                                                            radius: 30,
                                                            backgroundColor:
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                            child: CircleAvatar(
                                                                radius: 28,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                  "assets/Country_flag/in.png",
                                                                )),
                                                          ),
                                                          title: Text(
                                                            "Fatima",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                  fontSize: 16,
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .onPrimary,
                                                                ),
                                                          ),
                                                          subtitle: Text(
                                                            "Occupation",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodySmall!
                                                                .copyWith(
                                                                  fontSize: 14,
                                                                ),
                                                          ),
                                                          trailing:
                                                              MyEleButtonsmall(
                                                                  title2:
                                                                      "Sent",
                                                                  title: "Send",
                                                                  onPressed:
                                                                      () {},
                                                                  ctx: context),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                ),
                                ListTile(
                                  leading: new Icon(Ionicons.volume_mute),
                                  title: Text(
                                    'Mute',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 16),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Ionicons.ellipsis_horizontal_circle_outline,
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
}
