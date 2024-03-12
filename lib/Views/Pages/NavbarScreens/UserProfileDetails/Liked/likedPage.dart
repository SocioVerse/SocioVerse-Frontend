import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileWidgets.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';

import '../../../../Widgets/Global/imageLoadingWidgets.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  bool isSavedThreadLoading = false;
  bool isSavedPostLoading = false;
  List<ThreadModel> likedThreads = [];
  List<FeedThumbnail> likedFeeds = [];
  @override
  void initState() {
    getLikedThreads();
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
      isSavedThreadLoading = true;
    });
    likedThreads = await ThreadServices().getLikedThreads();
    setState(() {
      isSavedThreadLoading = false;
    });
  }

  getLikedFeeds() async {
    setState(() {
      isSavedThreadLoading = true;
    });
    likedFeeds = await FeedServices().getLikedFeeds();
    setState(() {
      isSavedThreadLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Saved",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            dividerColor: Theme.of(context).colorScheme.onPrimary,
            onTap: (value) {
              if (value == 0) {
                getLikedThreads();
              } else {
                getLikedFeeds();
              }
            },
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.text,
                      size: 20,
                    ),
                    SizedBox(width: 5), // Add spacing between icon and text
                    Text("Threads"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.grid_outline,
                      size: 20,
                    ),
                    SizedBox(width: 5), // Add spacing between icon and text
                    Text("Feeds"),
                  ],
                ),
              ),
            ],
          ),
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            isSavedThreadLoading
                ? const Expanded(
                    child: Center(
                        child: SpinKitRing(
                      color: Colors.white,
                      lineWidth: 1,
                      duration: Duration(seconds: 1),
                    )),
                  )
                : ThreadViewBuilder(
                    allThreads: likedThreads,
                    shrinkWrap: true,
                  ),
            isSavedPostLoading
                ? const Expanded(
                    child: Center(
                        child: SpinKitRing(
                      color: Colors.white,
                      lineWidth: 1,
                      duration: Duration(seconds: 1),
                    )),
                  )
                : Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                      imageUrl:
                                          likedFeeds[index].userId.profilePic,
                                      borderRadius: 5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
