import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Inbox/inboxPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

import '../../../Widgets/feeds_widget.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> with TickerProviderStateMixin {
  bool _showAppbar = true;
  final ScrollController _scrollController = ScrollController();
  double _previousOffset = 0;
  List<ProfileStoryModel> profileStories = [];
  bool isLoading = false;
  List<FeedModel> allFeeds = [];
  @override
  void initState() {
    _showAppbar = true;
    _scrollController.addListener(() {
      _scrollListener();
    });
    getFeedData();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _scrollListener() {
    if (_scrollController.offset > _previousOffset) {
      // User is scrolling downward, hide the app bar
      if (_showAppbar) {
        setState(() {
          _showAppbar = false;
        });
      }
    } else {
      // User is scrolling upward, show the app bar
      if (!_showAppbar) {
        setState(() {
          _showAppbar = true;
        });
      }
    }
    _previousOffset = _scrollController.offset;
  }

  getFeedData() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> feeds = await Future.wait([
      StoriesServices().fetchAllStories(),
      FeedServices().getFollowingFeeds()
    ]);
    profileStories = feeds[0] as List<ProfileStoryModel>;
    allFeeds = feeds[1] as List<FeedModel>;
    setState(() {
      isLoading = false;
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

  Widget storyScroller() {
    return isLoading
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
                        }))).then((value) => getFeedData());
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
                                            getFeedData();
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

  Widget feedViewBuilder() {
    return isLoading == false
        ? allFeeds.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  AllCaughtUp(),
                ],
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10),
                itemCount: allFeeds.length,
                itemBuilder: (context, index) {
                  return FeedLayout(
                    feed: allFeeds[index],
                  );
                },
              )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ThreadShimmer();
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return getFeedData();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 70,
                floating:
                    true, // Set this to true to make AppBar scroll with content
                pinned:
                    false, // Set this to false to allow AppBar to fully collapse
                title: Text("SocioVerse",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        )),
                actions: [
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       _enableThread = !_enableThread;
                  //     });
                  //   },
                  //   icon: Icon(Ionicons.link),
                  // ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: ((context) {
                        return const InboxPage();
                      })));
                    },
                    icon: const Icon(Ionicons.chatbubble_ellipses_outline),
                  )
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 120,
                      child: storyScroller(),
                    ),
                    Divider(
                      thickness: 1,
                      height: 0,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                    feedViewBuilder(),
                    // Add more widgets as needed
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
