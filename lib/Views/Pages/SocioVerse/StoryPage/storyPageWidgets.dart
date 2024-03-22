import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/main.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:story_view/controller/story_controller.dart';

class StoryPageControllers extends StatefulWidget {
  final StoryController storyController;
  final bool isOwner;
  final ReadStoryModel readStoryModel;

  const StoryPageControllers(
      {required this.readStoryModel,
      required this.isOwner,
      required this.storyController});
  @override
  _StoryPageControllersState createState() => _StoryPageControllersState();
}

class _StoryPageControllersState extends State<StoryPageControllers> {
  StorySeensModel? storySeensModel;
  bool isBottomSheetLoading = true;
  Future<void> toggleLike() async {
    await StoriesServices().toogleStoryLike(storyId: widget.readStoryModel.id);
    setState(() {
      widget.readStoryModel.isLiked = !widget.readStoryModel.isLiked;
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<void> getStorySeens() async {
    setState(() {
      isBottomSheetLoading = true;
    });
    storySeensModel = await StoriesServices().getStorySeens(
      storyId: widget.readStoryModel.id,
    );
    setState(() {
      isBottomSheetLoading = false;
    });
  }

  void showBottomSheet() {
    widget.storyController.pause();
    getStorySeens();
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        context: context,
        builder: (context) {
          return Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.horizontal_rule_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                // Assuming this is part of your build method
                FutureBuilder<StorySeensModel>(
                  future: StoriesServices().getStorySeens(
                    storyId: widget.readStoryModel.id,
                  ), // Your asynchronous function here
                  builder: (BuildContext context,
                      AsyncSnapshot<StorySeensModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Expanded(
                        child: Center(
                          child: SpinKit.ring,
                        ),
                      );
                    } else {
                      if (snapshot.hasError) {
                        // Handle error state
                        return const Center(
                          child: Text('Error loading data'),
                        );
                      } else {
                        // Data loaded successfully
                        StorySeensModel? storySeensModel = snapshot.data;
                        return Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.eye_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          size: 25,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          widget.readStoryModel.viewCount
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Ionicons.heart,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 25,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          storySeensModel!.likeCount.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Divider(
                                color: Theme.of(context).colorScheme.secondary,
                                thickness: 2,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: storySeensModel!.users.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: ListTile(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      UserProfilePage(
                                                        owner: storySeensModel!
                                                            .users[index]
                                                            .isOwner,
                                                        userId: storySeensModel!
                                                            .users[index].id,
                                                      )));
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        leading: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: CircularNetworkImageWithSize(
                                              imageUrl: storySeensModel!
                                                  .users[index].profilePic,
                                              height: 35,
                                              width: 35,
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          storySeensModel!
                                              .users[index].username,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary),
                                        ),
                                        subtitle: Text(
                                          storySeensModel!
                                              .users[index].occupation,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        trailing: storySeensModel!
                                                    .users[index].isLiked! ==
                                                true
                                            ? Icon(
                                                Ionicons.heart,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                              )
                                            : const SizedBox.shrink(),
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          );
        }).then((value) => widget.storyController.play());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.isOwner
                      ? Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              Icon(
                                Ionicons.eye_outline,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 25,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.readStoryModel.viewCount.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    // Add your logic here for the paper plane IconButton
                  },
                  icon: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
              ),
              widget.isOwner
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          widget.storyController.pause();
                          AlertBoxes.acceptRejectAlertBox(
                            context: context,
                            title: "Delete Story",
                            content: const Text(
                                "Are you sure you want to delete this Story?"),
                            onAccept: () async {
                              await StoriesServices()
                                  .deleteStory(
                                      storyId: widget.readStoryModel.id)
                                  .then((value) => Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const MyApp()),
                                      (route) => false));
                            },
                            onReject: () {
                              widget.storyController.play();
                            },
                          );
                        },
                        icon: const Icon(
                          Ionicons.trash_bin_outline,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: toggleLike, // Toggle the like button
                  icon: Icon(
                    widget.readStoryModel.isLiked
                        ? Ionicons.heart
                        : Ionicons.heart_outline,
                    color: widget.readStoryModel.isLiked
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onChanged;
  final Widget? prefixIcon;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.onChanged,
    this.prefixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      cursorOpacityAnimates: true,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
            fontSize: 16,
            color: Theme.of(context).colorScheme.surface,
          ),
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        contentPadding: const EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
              fontSize: 16,
            ),
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
}
