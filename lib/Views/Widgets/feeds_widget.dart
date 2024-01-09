import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Models/story_models.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/threadReply.dart';
import 'package:socioverse/Views/Pages/SocioVerse/commentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socioverse/services/stories_services.dart';
import 'package:socioverse/services/thread_services.dart';
import 'package:socioverse/Views/Pages/SocioThread/widgets.dart';

import 'buttons.dart';

class StoriesScroller extends StatefulWidget {
  const StoriesScroller({super.key});

  @override
  State<StoriesScroller> createState() => _StoriesScrollerState();
}

class _StoriesScrollerState extends State<StoriesScroller> {
  List<ProfileStoryModel> profileStories = [];
  bool isStoryLoading = false;

  @override
  void initState() {
    getProfileStories();
    super.initState();
  }

  getProfileStories() async {
    setState(() {
      isStoryLoading = true;
    });
    profileStories = await StoriesServices().fetchAllStories();
    setState(() {
      isStoryLoading = false;
    });
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.tertiary,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5, // Choose the number of shimmer placeholders
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  height: 80,
                  width: 80,
                ),
                const SizedBox(height: 10),
                Container(
                  height: 10,
                  width: 60,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isStoryLoading
        ? _buildLoadingShimmer()
        : ListView.builder(
            itemCount: profileStories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: GestureDetector(
                    onTap: () {
                      if (profileStories[index].isAllSeen != null) {
                        Navigator.push(context,
                            CupertinoPageRoute(builder: ((context) {
                          return StoryPage(
                            user: profileStories[index].user,
                          );
                        }))).then((value) => getProfileStories());
                      }
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: Stack(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: profileStories[index].isAllSeen ==
                                              null
                                          ? Colors.transparent
                                          : profileStories[index].isAllSeen!
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .tertiary
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                      width: 2,
                                    ),
                                  ),
                                  child:
                                      CircularNetworkImageWithSizeWithoutPhotoView(
                                    imageUrl:
                                        profileStories[index].user.profilePic,
                                    height: 80,
                                    width: 80,
                                  )),
                              index == 0
                                  ? Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: InkWell(
                                        onTap: () async {
                                          String? storyImage =
                                              await ImagePickerFunctionsHelper()
                                                  .requestStoryPicker(context)
                                                  .then((value) async {
                                            if (value != null) {
                                              return await FirebaseHelper
                                                  .uploadFile(
                                                      value.path,
                                                      profileStories[0]
                                                          .user
                                                          .email,
                                                      "${profileStories[0].user.email}/stories",
                                                      FirebaseHelper.Image);
                                            }
                                            return null;
                                          });
                                          if (storyImage != null) {
                                            await StoriesServices().uploadStory(
                                                storyImage: [storyImage]);
                                            getProfileStories();
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child: Icon(
                                            Icons.add,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        index != 0
                            ? Text(
                                profileStories[index].user.username,
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : Text(
                                "You",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                      ],
                    ),
                  ));
            });
  }
}

class UserProfileImageStackOf3 extends StatelessWidget {
  final List<CommentUser>? commenterProfilePics;
  UserProfileImageStackOf3({super.key, this.commenterProfilePics});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 31,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: CircularNetworkImageWithSize(
              imageUrl: commenterProfilePics![2].profilePic,
              height: 16,
              width: 16,
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: CircularNetworkImageWithSize(
              imageUrl: commenterProfilePics![1].profilePic,
              height: 10.5,
              width: 10.5,
            ),
          ),
          Positioned(
              right: 9.2,
              top: 21,
              child: CircularNetworkImageWithSize(
                imageUrl: commenterProfilePics![0].profilePic,
                height: 8.5,
                width: 8.5,
              )),
        ],
      ),
    );
  }
}

StatefulBuilder getFooter({
  required bool isPost,
  required Function onLike,
  required Function onComment,
  required Function onSave,
}) {
  TextEditingController postMessage = TextEditingController();
  TextEditingController search = TextEditingController();
  bool savedPost = false;
  bool isLiked = false;
  return StatefulBuilder(
    builder: (context, setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  onLike();
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                icon: Icon(
                  isLiked ? Ionicons.heart : Ionicons.heart_outline,
                  color: isLiked
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
              ),
              IconButton(
                onPressed: () {
                  onComment();
                },
                icon: Icon(
                  Ionicons.chatbubble_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
              ),
              IconButton(
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
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.horizontal_rule_rounded,
                                size: 50,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldBuilder(
                                tcontroller: postMessage,
                                hintTexxt: "Write a message...",
                                onChangedf: () {},
                              ),
                              const SizedBox(
                                height: 20,
                                child: Divider(
                                  height: 10,
                                ),
                              ),
                              TextFieldBuilder(
                                  tcontroller: search,
                                  hintTexxt: "Search",
                                  onChangedf: () {},
                                  prefixxIcon: Icon(
                                    Ionicons.search,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: CircleAvatar(
                                              radius: 28,
                                              backgroundImage: AssetImage(
                                                "assets/Country_flag/in.png",
                                              )),
                                        ),
                                        title: Text(
                                          "Fatima",
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
                                        subtitle: Text(
                                          "Occupation",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 14,
                                              ),
                                        ),
                                        trailing: MyEleButtonsmall(
                                            title2: "Sent",
                                            title: "Send",
                                            onPressed: () {},
                                            ctx: context),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  Ionicons.paper_plane_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() {
                savedPost = !savedPost;
              });
              onSave();
            },
            icon: Icon(
              savedPost ? Ionicons.bookmark : Ionicons.bookmark_outline,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 30,
            ),
          ),
        ],
      );
    },
  );
}

class PostLayout extends StatefulWidget {
  BuildContext ctx;
  PostLayout({super.key, required this.ctx});

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: Icon(
              Ionicons.person,
              color: Theme.of(context).colorScheme.background,
              size: 30,
            ),
          ),
          title: Text(
            "Username",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          subtitle: Text(
            "Occupation",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MyApp.width! / 1.2,
                height: MyApp.width! / 1.2,
                child: PageView(
                  controller: pageController,
                  children: [
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: SmoothPageIndicator(
                onDotClicked: (index) => pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                controller: pageController,
                count: 3,
                effect: WormEffect(
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  type: WormType.thin,
                  dotWidth: 6,
                  dotHeight: 6,
                  dotColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: getFooter(
            isPost: true,
            onLike: () {},
            onComment: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CommentPage()));
            },
            onSave: () {},
          ),
        ),
      ],
    );
  }
}

class PostViewBuilder extends StatefulWidget {
  const PostViewBuilder({super.key});

  @override
  State<PostViewBuilder> createState() => _PostViewBuilderState();
}

class _PostViewBuilderState extends State<PostViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return PostLayout(
          ctx: context,
        );
      },
    );
  }
}
