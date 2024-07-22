import 'dart:developer';
import 'dart:math';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Models/hashtagModels.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Services/location_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/hashtagProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/locationProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/main.dart';
import 'package:socioverse/Services/follow_unfollow_services.dart';
import 'package:socioverse/Services/search_bar_services.dart';

import '../../../Widgets/buttons.dart';
import '../../../Widgets/textfield_widgets.dart';

class SearchFeedsPage extends StatefulWidget {
  const SearchFeedsPage({super.key});

  @override
  State<SearchFeedsPage> createState() => _SearchFeedsPageState();
}

class _SearchFeedsPageState extends State<SearchFeedsPage>
    with SingleTickerProviderStateMixin {
  List<SearchedUser> searchedUser = [];
  bool isUserFetched = false;
  List<LocationSearchModel> searchedLocation = [];
  bool isSearchingLocation = false;
  bool isSearchingHashtag = false;
  List<HashtagsSearchModel> searchedHashtags = [];
  late TabController _tabController;
  TextEditingController searchText = TextEditingController();
  int _value = 1;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  int selectedChip = 1;
  Widget allSearchFeeds() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            tabSlider(context),
            const SizedBox(
              height: 20,
            ),
            _value == 1
                ? FutureBuilder(
                    future: FeedServices.getTrendingFeeds(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return FeedShimmer();
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      List<FeedModel> allFeeds =
                          snapshot.data as List<FeedModel>;
                      return allFeeds.isEmpty
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
                            );
                    }))
                : FutureBuilder(
                    future: ThreadServices.getTrendingThreads(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return ThreadShimmer();
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            "Error: ${snapshot.error}",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      }
                      List<ThreadModel> allThreads =
                          snapshot.data as List<ThreadModel>;
                      return allThreads.isEmpty
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
                            );
                    }),
          ],
        ),
      ),
    );
  }

  Future<void> getQueryLocation() async {
    setState(() {
      isSearchingLocation = true;
    });
    if (searchText.text.trim().isNotEmpty) {
      searchedLocation =
          await SearchBarServices.getLocation(location: searchText.text);
    }
    setState(() {
      isSearchingLocation = false;
    });
  }

  Future<void> getQueryHashtag() async {
    setState(() {
      isSearchingHashtag = true;
    });
    if (searchText.text.trim().isNotEmpty) {
      searchedHashtags =
          await SearchBarServices.getHashtags(hashtag: searchText.text);
    }
    setState(() {
      isSearchingHashtag = false;
    });
  }

  Future<void> getQueryUser() async {
    setState(() {
      isUserFetched = false;
    });
    searchedUser = await SearchBarServices.fetchSearchedUser(
        searchQuery: searchText.text.trim());
    setState(() {
      isUserFetched = true;
    });
  }

  Future<String> getQueryUserByFace({required String faceImage}) async {
    String? userByFace;
    setState(() {
      isUserFetched = false;
    });
    userByFace =
        await SearchBarServices.fetchSearchedUserByFace(faceImage: faceImage);
    setState(() {
      isUserFetched = true;
    });
    return userByFace;
  }

  Widget searchEnabled() {
    List<Widget> _searchWidgets = [
      Expanded(
        child: searchText.text.isNotEmpty && isUserFetched == false
            ? Center(
                child: SpinKit.ring,
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: searchedUser.length,
                itemBuilder: (context, index) {
                  return Column(children: [
                    personListTile(
                        user: searchedUser[index],
                        ttl1: searchedUser[index].state == 0
                            ? "Follow"
                            : searchedUser[index].state == 2
                                ? "Following"
                                : "Requested",
                        isPressed:
                            searchedUser[index].state == 0 ? false : true,
                        ttl2: searchedUser[index].state == 0
                            ? "Requested"
                            : "Follow"),
                    const SizedBox(
                      height: 10,
                    ),
                  ]);
                },
              ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKit.ring,
              );
            }
            List<FeedThumbnail> feedThumbnail =
                snapshot.data as List<FeedThumbnail>;
            return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: feedThumbnail.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Positioned.fill(
                        child: RoundedNetworkImageWithLoading(
                          imageUrl: feedThumbnail[index].images[0],
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
                              imageUrl: feedThumbnail[index].userId.profilePic,
                              borderRadius: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
          future: SearchBarServices.getFeedsMetadata(
              metadata: searchText.text.trim()),
        ),
      ),
      Expanded(
        child: isSearchingHashtag
            ? Center(
                child: SpinKit.ring,
              )
            : searchedHashtags.isEmpty
                ? const Center(
                    child: Text("No Hashtags Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchedHashtags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HashtagProfilePage(
                              id: searchedHashtags[index].id,
                              hashTag: searchedHashtags[index].hashtag,
                              postsCount: searchedHashtags[index].postCount,
                            );
                          }));
                        },
                        leading: CircleAvatar(
                            radius: 30,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Icon(
                              Icons.tag,
                              color: Theme.of(context).colorScheme.onPrimary,
                            )),
                        title: Text(
                          searchedHashtags[index].hashtag,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            searchedHashtags[index].postCount < 100
                                ? searchedHashtags[index].postCount <= 1
                                    ? "${searchedHashtags[index].postCount} Post"
                                    : "${searchedHashtags[index].postCount} Posts"
                                : "${CalculatingFunction.numberToMkConverter(searchedHashtags[index].postCount.toDouble())} Posts",
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontSize: 14,
                                    ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      Expanded(
        child: isSearchingLocation
            ? Center(
                child: SpinKit.ring,
              )
            : searchedLocation.isEmpty
                ? const Center(
                    child: Text("No Location Found"),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: searchedLocation.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return LocationProfilePage(
                              locationSearchModel: searchedLocation[index],
                            );
                          }));
                        },
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          child: const Center(
                            child: Icon(
                              Ionicons.location,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(searchedLocation[index].name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                        subtitle: Text(
                          searchedLocation[index].postCount! < 100
                              ? searchedLocation[index].postCount! <= 1
                                  ? "${searchedLocation[index].postCount} Post"
                                  : "${searchedLocation[index].postCount} Posts"
                              : "${CalculatingFunction.numberToMkConverter(searchedLocation[index].postCount!.toDouble())} Posts",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 16),
                        ),
                      );
                    },
                  ),
      ),
    ];

    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CustomSlidingSegmentedControl<int>(
                initialValue: 1,
                padding: 35,
                children: const {
                  1: Icon(
                    Ionicons.person,
                    size: 20,
                  ),
                  2: Icon(
                    Ionicons.grid_outline,
                    size: 20,
                  ),
                  3: Icon(
                    Icons.tag,
                    size: 20,
                  ),
                  4: Icon(
                    Ionicons.location,
                    size: 20,
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
                onValueChanged: (value) {
                  if (value == 1) {
                    getQueryUser();
                  } else if (value == 3) {
                    getQueryHashtag();
                  } else if (value == 4) {
                    getQueryLocation();
                  }
                  setState(() {
                    selectedChip = value;
                  });
                },
              )
            ]),
          ),
          _searchWidgets[selectedChip - 1],
        ],
      ),
    );
  }

  SizedBox tabSlider(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Text("Trending 🔥",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                )),
        CustomSlidingSegmentedControl<int>(
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
            setState(() {
              _value = v;
            });
          },
        )
      ]),
    );
  }

  ListTile personListTile(
      {required String ttl1,
      required String ttl2,
      required SearchedUser user,
      required bool isPressed}) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserProfilePage(
            owner: false,
            userId: user.id,
          );
        })).then((value) {
          setState(() {
            getQueryUser();
          });
        });
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularNetworkImageWithSize(
            imageUrl: user.profilePic,
            height: 35,
            width: 35,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Text(
        user.username,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
            ),
      ),
      trailing: MyEleButtonsmall(
          title2: ttl2,
          title: ttl1,
          ispressed: isPressed,
          onPressed: () async {
            if (user.state == 2) {
              setState(() {
                if (user.state == 2) {
                  user.state = 0;
                }
              });
              await FollowUnfollowServices.unFollow(
                userId: user.id,
              );
            }
            await FollowUnfollowServices.toggleFollow(
              userId: user.id,
            );
          },
          ctx: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: TextFieldBuilder(
                suffixIcon: _tabController.index == 0
                    ? InkWell(
                        onTap: () async {
                          context.loaderOverlay.show();
                          String? faceImage =
                              await ImagePickerFunctionsHelper.pickImage(
                                      context)
                                  .then((value) async {
                            if (value != null) {
                              return await FirebaseHelper.uploadFile(
                                  value.path,
                                  value.path.split('/').last,
                                  "SearchedFaces",
                                  FirebaseHelper.Image);
                            }
                            return null;
                          });
                          if (faceImage == null) {
                            return;
                          } else {
                            String? userByFace =
                                await getQueryUserByFace(faceImage: faceImage);
                            if (context.mounted) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UserProfilePage(
                                  owner: false,
                                  userId: userByFace,
                                );
                              }));
                            }
                          }
                        },
                        child: Icon(Ionicons.image_outline,
                            color: Theme.of(context).colorScheme.tertiary))
                    : null,
                tcontroller: searchText,
                hintTexxt: "Search",
                onChangedf: () {
                  if (searchText.text.trim().isNotEmpty) {
                    if (_tabController.index == 0) {
                      getQueryUser();
                    } else if (_tabController.index == 2) {
                      getQueryHashtag();
                    } else if (_tabController.index == 3) {
                      getQueryLocation();
                    }
                  } else if (searchText.text.trim().isEmpty) {
                    _tabController.animateTo(0);
                    setState(() {});
                  }
                },
                prefixxIcon: Icon(
                  Ionicons.search,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            searchText.text.trim() == '' ? allSearchFeeds() : searchEnabled(),
          ],
        ),
      ),
    );
  }
}
