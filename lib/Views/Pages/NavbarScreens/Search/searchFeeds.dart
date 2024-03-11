import 'dart:developer';
import 'dart:math';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Utils/calculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Hashtag/hashtagModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/Location/locationService.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/hashtagProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/locationProfilePage.dart';
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
  List<String> sections = [
    "Trending",
    "Discover",
    "Posts",
    "Tags",
    "Places",
  ];
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

  int selectedChip = 0;
  Widget allSearchFeeds() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: sections.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: ChoiceChip(
                      checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                      label: Text(
                        sections[index],
                        style: GoogleFonts.openSans(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: selectedChip == index
                              ? Theme.of(context).colorScheme.onPrimary
                              : Theme.of(context).colorScheme.primary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      selected: selectedChip == index ? true : false,
                      onSelected: (value) {
                        setState(() {
                          selectedChip = index;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/Country_flag/in.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
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
          await SearchBarServices().getLocation(location: searchText.text);
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
          await SearchBarServices().getHashtags(hashtag: searchText.text);
    }
    setState(() {
      isSearchingHashtag = false;
    });
  }

  Future<void> getQueryUser() async {
    setState(() {
      isUserFetched = false;
    });
    searchedUser = await SearchBarServices()
        .fetchSearchedUser(searchQuery: searchText.text.trim());
    setState(() {
      isUserFetched = true;
    });
  }

  Widget searchEnabled() {
    return DefaultTabController(
      length: 4,
      child: Expanded(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 55,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        const Spacer(),
                        Divider(
                          color: Theme.of(context).colorScheme.tertiary,
                          thickness: 1,
                        ),
                      ],
                    ),
                    TabBar(
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onPrimary,
                      indicatorColor: Theme.of(context).colorScheme.primary,
                      automaticIndicatorColorAdjustment: true,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3,
                      dividerColor: Theme.of(context).colorScheme.onPrimary,
                      onTap: (value) {
                        if (value == 0) {
                          _tabController.animateTo(0);
                          getQueryUser();
                        } else if (value == 1) {
                          _tabController.animateTo(1);
                          // getQueryUser();
                        } else if (value == 2) {
                          _tabController.animateTo(2);
                          getQueryHashtag();
                        } else if (value == 3) {
                          _tabController.animateTo(3);
                          getQueryLocation();
                        }
                      },
                      tabs: [
                        const Tab(
                          child: Icon(
                            Ionicons.person,
                            size: 20,
                          ),
                        ),
                        const Tab(
                          child: Icon(
                            Ionicons.grid_outline,
                            size: 20,
                          ),
                        ),
                        const Tab(
                          child: Icon(
                            Icons.tag,
                            size: 20,
                          ),
                        ),
                        Tab(
                          child: Icon(
                            Ionicons.location,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Expanded(
                    child: searchText.text.isNotEmpty && isUserFetched == false
                        ? Center(
                            child: SpinKitRing(
                              color: Theme.of(context).colorScheme.tertiary,
                              lineWidth: 1,
                              duration: const Duration(seconds: 1),
                            ),
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
                                    isPressed: searchedUser[index].state == 0
                                        ? false
                                        : true,
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SpinKitRing(
                              color: Theme.of(context).colorScheme.tertiary,
                              lineWidth: 1,
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                        List<FeedThumbnail> feedThumbnail =
                            snapshot.data as List<FeedThumbnail>;
                        return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                                            color:
                                                Colors.black.withOpacity(0.5),
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
                                          imageUrl: feedThumbnail[index]
                                              .userId
                                              .profilePic,
                                          borderRadius: 5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      future: SearchBarServices()
                          .getFeedsMetadata(metadata: searchText.text.trim()),
                    ),
                  ),
                  Expanded(
                    child: isSearchingHashtag
                        ? Center(
                            child: SpinKitRing(
                              color: Theme.of(context).colorScheme.tertiary,
                              lineWidth: 1,
                              duration: const Duration(seconds: 1),
                            ),
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
                                          hashTag:
                                              searchedHashtags[index].hashtag,
                                          postsCount:
                                              searchedHashtags[index].postCount,
                                        );
                                      }));
                                    },
                                    leading: CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        child: Icon(
                                          Icons.tag,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        )),
                                    title: Text(
                                      searchedHashtags[index].hashtag,
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
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        searchedHashtags[index].postCount < 100
                                            ? searchedHashtags[index]
                                                        .postCount <=
                                                    1
                                                ? "${searchedHashtags[index].postCount} Post"
                                                : "${searchedHashtags[index].postCount} Posts"
                                            : "${CalculatingFunction.numberToMkConverter(searchedHashtags[index].postCount.toDouble())} Posts",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
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
                            child: SpinKitRing(
                              color: Theme.of(context).colorScheme.tertiary,
                              lineWidth: 1,
                              duration: const Duration(seconds: 1),
                            ),
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
                                          locationSearchModel:
                                              searchedLocation[index],
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
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            )),
                                    subtitle: Text(
                                      searchedLocation[index].postCount! < 100
                                          ? searchedLocation[index]
                                                      .postCount! <=
                                                  1
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
                ],
              ),
            ),
          ],
        ),
      ),
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
              await FollowUnfollowServices().unFollow(
                userId: user.id,
              );
              setState(() {
                if (user.state == 2) {
                  user.state = 0;
                }
              });
            }
            await FollowUnfollowServices().toogleFollow(
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
