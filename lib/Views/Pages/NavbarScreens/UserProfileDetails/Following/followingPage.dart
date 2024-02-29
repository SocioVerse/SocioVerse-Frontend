import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersServices.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Services/follow_unfollow_services.dart';

class FollowingPage extends StatefulWidget {
  final String? userId;

  const FollowingPage({this.userId, super.key});

  @override
  State<FollowingPage> createState() => _FollowingPageState();
}

class _FollowingPageState extends State<FollowingPage> {
  List<FollowersModel>? _followersModelList;
  bool isLoading = false;
  @override
  void initState() {
    getFollowings();
    super.initState();
  }

  getFollowings() async {
    setState(() {
      isLoading = true;
    });
    _followersModelList =
        await FollowersServices().fetchFollowing(widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  ListTile personListTile(
      {required String ttl1,
      required String ttl2,
      required FollowersModel followersModel,
      required bool isPressed}) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfilePage(
                      owner: false,
                      userId: followersModel.user.id,
                    ))).then((value) => getFollowings());
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularNetworkImageWithSize(
            imageUrl: followersModel.user.profilePic,
            height: 35,
            width: 35,
          ),
        ),
      ),
      title: Text(
        followersModel.user.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Text(
        followersModel.user.occupation,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
            ),
      ),
      trailing: followersModel.state == 3
          ? const SizedBox.shrink()
          : MyEleButtonsmall(
              title2: ttl2,
              title: ttl1,
              ispressed: isPressed,
              onPressed: () async {
                if (followersModel.state == 2) {
                  await FollowUnfollowServices().unFollow(
                    userId: followersModel.user.id,
                  );
                  setState(() {
                    if (followersModel.state == 2) {
                      followersModel.state = 0;
                    }
                  });
                } else {
                  await FollowUnfollowServices().toogleFollow(
                    userId: followersModel.user.id,
                  );
                }
              },
              ctx: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Followings",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: SpinKitRing(
              color: Theme.of(context).colorScheme.tertiary,
              lineWidth: 1,
              duration: const Duration(seconds: 1),
            ))
          : ListView.builder(
              itemCount: _followersModelList!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    personListTile(
                        followersModel: _followersModelList![index],
                        ttl1: _followersModelList![index].state == 0
                            ? "Follow"
                            : _followersModelList![index].state == 2
                                ? "Following"
                                : "Requested",
                        isPressed: _followersModelList![index].state == 0
                            ? false
                            : true,
                        ttl2: _followersModelList![index].state == 0
                            ? "Requested"
                            : "Follow"),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
