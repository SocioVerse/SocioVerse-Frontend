import 'dart:developer';
import 'dart:ffi';

import 'package:after_layout/after_layout.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Controllers/feedPageProviders.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/storyModels.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Sockets/messageSockets.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Inbox/inboxPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/main.dart';

import '../../../Widgets/feeds_widget.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage>
    with TickerProviderStateMixin, AfterLayoutMixin<FeedsPage> {
  final ScrollController _scrollController = ScrollController();
  List<ProfileStoryModel> profileStories = [];
  List<FeedModel> allFeeds = [];
  List<ThreadModel> allThreads = [];
  FeedPageProvider? feedPageProvider;

  @override
  afterFirstLayout(BuildContext context) {
    feedPageProvider = Provider.of<FeedPageProvider>(context, listen: false);
    feedPageProvider!.value = 1;
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400) {
        Provider.of<ShowBackToTopProvider>(context, listen: false)
            .showBackToTopButton = true; // show the back-to-top button
      } else {
        Provider.of<ShowBackToTopProvider>(context, listen: false)
            .showBackToTopButton = false; // hide the back-to-top button
      }
    });
    getFeedData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Consumer<ShowBackToTopProvider>(builder: (context, prov, child) {
            return !prov.showBackToTopButton
                ? const SizedBox.shrink()
                : FloatingActionButton(
                    onPressed: () {
                      _scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                    },
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: const Icon(
                      Icons.arrow_upward,
                      color: Colors.white,
                    ),
                  );
          }),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: ((context) {
                return const InboxPage();
              }))).then((value) => getFeedData());
            },
            backgroundColor: Theme.of(context).colorScheme.secondary,
            child: Stack(
              children: [
                const Positioned.fill(
                  child: Icon(
                    Icons.chat_bubble_outline,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 10,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Consumer<FeedPageProvider>(
                        builder: (context, prov, child) {
                      return Text(
                        prov.messageCount.toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            getFeedData();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Consumer<FeedPageProvider>(builder: (context, prov, child) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    tabSlider(context),
                    prov.value == 1
                        ? feedViewBuilder()
                        : prov.value == 2
                            ? threadViewBuilder()
                            : storyScroller(),
                  ]);
            }),
          ),
        ),
      ),
    );
  }

  Future<void> socketInit() async {
    log('Here');
    await SocketHelper.initSocketIO();

    if (SocketHelper.socketHelper.active) {
      SocketHelper.socketHelper.dispose();
    }
    await SocketHelper.initSocketIO();
    String userId = await getStringFromCache(SharedPreferenceString.userId);
    print(userId);
    SocketHelper.socketHelper.emit('join-chat', {
      'roomId': userId,
    });
    SocketHelper.socketHelper.on('feed-page-count', (data) {
      log(data.toString());
      feedPageProvider!.messageCount = data['cnt'];
    });
    SocketHelper.socketHelper.emit('send-home-page', {
      'sentTo': userId,
    });
  }

  getFeedData() async {
    var prov = Provider.of<FeedPageProvider>(context, listen: false);
    prov.isLoading = true;
    socketInit();

    if (prov.value == 1) {
      allFeeds = await FeedServices().getFollowingFeeds();
    } else if (prov.value == 2) {
      allThreads = await ThreadServices().getFollowingThreads();
    } else {
      profileStories = await StoriesServices().fetchAllStories();
    }
    prov.isLoading = false;
  }

  Widget _buildLoadingShimmer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 20,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            childAspectRatio: 2 / 3,
            mainAxisSpacing: 5,
          ),
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Theme.of(context).colorScheme.tertiary,
              highlightColor: Colors.grey[100]!,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }),
    );
  }

  Widget storyScroller() {
    return Consumer<FeedPageProvider>(builder: (context, prov, child) {
      return prov.isLoading == false
          ? profileStories.isEmpty
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    AllCaughtUp(),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: profileStories.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        childAspectRatio: 2 / 3,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).colorScheme.secondary,
                            image: DecorationImage(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.2),
                                  BlendMode.dstATop),
                              image: CachedNetworkImageProvider(
                                  profileStories[index].user.profilePic),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (profileStories[index].isAllSeen !=
                                          null) {
                                        Navigator.push(context,
                                            CupertinoPageRoute(
                                                builder: ((context) {
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
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                      color: profileStories[
                                                                      index]
                                                                  .isAllSeen ==
                                                              null
                                                          ? Colors.transparent
                                                          : profileStories[
                                                                      index]
                                                                  .isAllSeen!
                                                              ? Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .tertiary
                                                              : Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary,
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child:
                                                      CircularNetworkImageWithSizeWithoutPhotoView(
                                                    imageUrl:
                                                        profileStories[index]
                                                            .user
                                                            .profilePic,
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
                                                              await ImagePickerFunctionsHelper
                                                                      .requestStoryPicker(
                                                                          context)
                                                                  .then(
                                                                      (value) async {
                                                            if (value != null) {
                                                              return await FirebaseHelper.uploadFile(
                                                                  value.path,
                                                                  profileStories[
                                                                          0]
                                                                      .user
                                                                      .email,
                                                                  "${profileStories[0].user.email}/stories",
                                                                  FirebaseHelper
                                                                      .Image);
                                                            }
                                                            return null;
                                                          });
                                                          if (storyImage !=
                                                              null) {
                                                            await StoriesServices()
                                                                .uploadStory(
                                                                    storyImage: [
                                                                  storyImage
                                                                ]);
                                                            getFeedData();
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            color: Theme.of(
                                                                    context)
                                                                .colorScheme
                                                                .primary,
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Theme.of(
                                                                    context)
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
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        );
                      }),
                )
          : _buildLoadingShimmer();
    });
  }

  Widget feedViewBuilder() {
    return Consumer<FeedPageProvider>(builder: (context, prov, child) {
      return prov.isLoading == false
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
                return FeedShimmer();
              },
            );
    });
  }

  Widget threadViewBuilder() {
    return Consumer<FeedPageProvider>(builder: (context, prov, child) {
      return prov.isLoading == false
          ? allThreads.isEmpty
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
                  itemCount: allThreads.length,
                  itemBuilder: (context, index) {
                    return ThreadLayout(
                      thread: allThreads[index],
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
    });
  }

  SizedBox tabSlider(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer<FeedPageProvider>(builder: (context, prov, child) {
            return CustomSlidingSegmentedControl<int>(
              initialValue: 1,
              children: {
                1: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Ionicons.grid_outline,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Feeds",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
                2: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Ionicons.text,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Threads",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
                3: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Ionicons.time_outline,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Stories",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              },
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              thumbDecoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    blurRadius: 4.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      2.0,
                    ),
                  ),
                ],
              ),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInToLinear,
              onValueChanged: (v) {
                prov.value = v;
                getFeedData();
              },
            );
          }),
        ],
      ),
    );
  }
}
