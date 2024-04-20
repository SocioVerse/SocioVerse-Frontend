import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileWidgets.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';

import '../../../Widgets/Global/imageLoadingWidgets.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  bool isLikedThreadLoading = false;
  bool isLikedPostLoading = false;
  List<ThreadModel> likedThreads = [];
  List<FeedThumbnail> likedFeeds = [];
  int selectedTab = 1;
  @override
  void initState() {
    getLikedFeeds();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getLikedThreads() async {
    setState(() {
      isLikedThreadLoading = true;
    });
    likedThreads = await ThreadServices().getLikedThreads();
    setState(() {
      isLikedThreadLoading = false;
    });
  }

  getLikedFeeds() async {
    setState(() {
      isLikedThreadLoading = true;
    });
    likedFeeds = await FeedServices().getLikedFeeds();
    setState(() {
      isLikedThreadLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _tabs = [
      isLikedPostLoading ? Center(child: SpinKit.ring) : likedPostBuilder(),
      isLikedThreadLoading
          ? Center(child: SpinKit.ring)
          : ThreadViewBuilder(
              allThreads: likedThreads,
            )
    ];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Liked",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomSlidingSegmentedControl<int>(
                initialValue: 1,
                padding: 35,
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
                  if (v == 1) {
                    getLikedFeeds();
                  } else {
                    getLikedThreads();
                  }
                  setState(() {
                    selectedTab = v;
                  });
                },
              )
            ]),
          ),
          Expanded(child: _tabs[selectedTab - 1]),
        ],
      ),
    );
  }

  Widget likedPostBuilder() {
    return likedFeeds.isEmpty
        ? NoPostYet()
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: likedFeeds.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentPage(
                                  feedId: likedFeeds[index].id,
                                ),
                              ),
                            );
                          },
                          child: RoundedNetworkImageWithLoading(
                            gestureEnabled: false,
                            imageUrl: likedFeeds[index].images[0],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: RoundedNetworkImageWithLoading(
                              imageUrl: likedFeeds[index].userId.profilePic,
                              borderRadius: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          );
  }
}
