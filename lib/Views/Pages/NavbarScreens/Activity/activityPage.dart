import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/activityPageProvider.dart';
import 'package:socioverse/Controllers/feedPageProviders.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Services/activity_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityWidgets.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ActivityPageProvider>(context, listen: false)
          .getLatestFollowRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Activity",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Consumer<ActivityPageProvider>(builder: (context, prov, child) {
        return prov.isLoading
            ? Center(
                child: SpinKit.ring,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    prov.latestFollowRequestModel.followRequestCount == 0
                        ? const SizedBox.shrink()
                        : RequestsTile(
                            latestFollowRequestModel:
                                prov.latestFollowRequestModel,
                            onTap: prov.getLatestFollowRequest,
                          ),
                    tabSlider(context),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: FutureBuilder<List<RecentLikesModel>>(
                        future: ActivityServices().getRecentLikes("likes"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SpinKit.ring;
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text("${snapshot.error.toString()}"),
                            );
                          } else {
                            List<RecentLikesModel> recentLikes = snapshot.data!;
                            return ListView.builder(
                              itemCount: recentLikes.length,
                              itemBuilder: (context, index) {
                                return ActivityTile(
                                  type: "Lik",
                                  feed: recentLikes[index].feed,
                                  dateTime: recentLikes[index].latestLike ??
                                      recentLikes[index].latestComment ??
                                      DateTime.now(),
                                  imgUrl: recentLikes[index]
                                      .users
                                      .map((e) => e.profilePic)
                                      .toList(),
                                  postType: recentLikes[index].type,
                                  postId: recentLikes[index].feed?.id ??
                                      recentLikes[index].thread?.id ??
                                      "",
                                  users: recentLikes[index].users,
                                  thread: recentLikes[index].thread,
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  SizedBox tabSlider(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSlidingSegmentedControl<int>(
            initialValue: 1,
            children: {
              1: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Ionicons.heart_outline,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Likes",
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
                      Ionicons.chatbubble_outline,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Comments",
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
                      Ionicons.people_outline,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Others",
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
            onValueChanged: (v) {},
          ),
        ],
      ),
    );
  }
}
