import 'dart:developer';

import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/services/follow_unfollow_services.dart';
import 'package:socioverse/services/search_bar_services.dart';

import '../../Widgets/buttons.dart';
import '../../Widgets/textfield_widgets.dart';

class SearchFeedsPage extends StatefulWidget {
  const SearchFeedsPage({super.key});

  @override
  State<SearchFeedsPage> createState() => _SearchFeedsPageState();
}

class _SearchFeedsPageState extends State<SearchFeedsPage>
    with SingleTickerProviderStateMixin {
  List<SearchedUser> searchedUser = [];
  bool isUserFetched = false;

  late TabController _tabController;
  TextEditingController searchText = TextEditingController();
  List<String> sections = [
    "Trending",
    "Discover",
    "Posts",
    "Tags",
    "Places",
  ];
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  int selectedChip = 0;
  Widget allSearchFeeds() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 5,
            ),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: sections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: ChoiceChip(
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
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    image: DecorationImage(
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
    );
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
    return Column(
      children: [
        DefaultTabController(
            length: 4,
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
                            Spacer(),
                            Divider(
                              color: Theme.of(context).colorScheme.tertiary,
                              thickness: 1,
                            ),
                          ],
                        ),
                        TabBar(
                          labelColor: Theme.of(context).colorScheme.primary,
                          unselectedLabelColor:
                              Theme.of(context).colorScheme.tertiary,
                          indicatorColor: Theme.of(context).colorScheme.primary,
                          onTap: (value) {
                            if (value == 0) {
                              getQueryUser();
                            }
                          },
                          tabs: const [
                            Tab(
                              child: Icon(
                                Ionicons.person,
                                size: 20,
                              ),
                            ),
                            Tab(
                              child: Icon(
                                Ionicons.grid_outline,
                                size: 20,
                              ),
                            ),
                            Tab(
                              child: Icon(
                                Icons.tag,
                                size: 20,
                              ),
                            ),
                            Tab(
                              child: Icon(
                                Ionicons.location,
                                size: 20,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                AutoScaleTabBarView(
                  children: [
                    isUserFetched == false
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: searchedUser.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(children: [
                                personListTile(
                                    user: searchedUser[index],
                                    ttl1:
                                        searchedUser[index].isConfirmed == null
                                            ? "Follow"
                                            : searchedUser[index].isConfirmed ==
                                                    true
                                                ? "Following"
                                                : "Requested",
                                    isPressed:
                                        searchedUser[index].isConfirmed == null
                                            ? false
                                            : true,
                                    ttl2:
                                        searchedUser[index].isConfirmed == null
                                            ? "Requested"
                                            : "Follow"),
                                SizedBox(
                                  height: 10,
                                ),
                              ]);
                            },
                          ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/Country_flag/in.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(children: [
                          hashtagsTile(
                            hashtagsTile: "kunal",
                            posts: 357014568,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ]);
                      },
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(children: [
                          locationTile(
                              address: "Jaipur, Rajasthan",
                              subAddress: "129, Shri Ram Nagar, Jhotwara"),
                          SizedBox(
                            height: 10,
                          ),
                        ]);
                      },
                    ),
                  ],
                ),
              ],
            )),
      ],
    );
  }

  String numberToMkConverter(double number) {
    if (number >= 1000000) {
      double result = number / 1000000;
      return result.toStringAsFixed(0) + 'M';
    } else if (number >= 1000) {
      double result = number / 1000;
      return result.toStringAsFixed(0) + 'K';
    } else {
      return number.toString();
    }
  }

  ListTile hashtagsTile({required String hashtagsTile, required double posts}) {
    return ListTile(
      leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Icons.tag,
            color: Theme.of(context).colorScheme.onPrimary,
          )),
      title: Text(
        "#" + hashtagsTile,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          numberToMkConverter(posts) + " Posts",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
              ),
        ),
      ),
    );
  }

  ListTile locationTile({required String address, required String subAddress}) {
    return ListTile(
      leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Icon(
            Ionicons.location,
            color: Theme.of(context).colorScheme.onPrimary,
          )),
      title: Text(
        address,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          subAddress,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 14,
              ),
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: ClipOval(
            child: Image.network(
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              user.profilePic,
              height: 35,
              width: 35,
              fit: BoxFit.cover,
            ),
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFieldBuilder(
                  tcontroller: searchText,
                  hintTexxt: "Search",
                  onChangedf: () {
                    if (searchText.text.trim().length >= 1) {
                      getQueryUser();
                    } else if (searchText.text.trim().length == 0)
                      setState(() {});
                  },
                  prefixxIcon: Icon(Ionicons.search),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              searchText.text.trim() == '' ? allSearchFeeds() : searchEnabled(),
            ],
          ),
        ),
      ),
    );
  }
}
