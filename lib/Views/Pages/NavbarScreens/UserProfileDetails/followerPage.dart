import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Services/followers_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Services/follow_unfollow_services.dart';

class FollowersPage extends StatefulWidget {
  final String? userId;
  const FollowersPage({this.userId, super.key});

  @override
  State<FollowersPage> createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<FollowersModel>? _followersModelList;
  bool isLoading = false;
  @override
  void initState() {
    getFollowers();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getFollowers() async {
    setState(() {
      isLoading = true;
    });
    _followersModelList = await FollowersServices.fetchFollowers(widget.userId);
    setState(() {
      isLoading = false;
    });
  }

  ListTile personListTile(
      {required String ttl1,
      required String ttl2,
      required FollowersModel followersModel,
      required int index,
      required bool isPressed}) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserProfilePage(
                      owner: followersModel.state == 3 ? true : false,
                      userId: followersModel.user.id,
                    ))).then((value) => getFollowers());
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
          : CustomOutlineButton(
              ctx: context,
              title: 'Remove',
              onPressed: () async {
                await FollowersServices.removeFollower(followersModel.user.id);
                setState(() {
                  _followersModelList!.removeAt(index);
                });
                if (_followersModelList!.isEmpty) {
                  Navigator.pop(context);
                }
              }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Followers",
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
              child: SpinKit.ring,
            )
          : ListView.builder(
              itemCount: _followersModelList!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    personListTile(
                        index: index,
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
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
