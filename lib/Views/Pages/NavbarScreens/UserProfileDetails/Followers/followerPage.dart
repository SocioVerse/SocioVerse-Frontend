import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/followersServices.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/services/follow_unfollow_services.dart';

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

  getFollowers() async {
    setState(() {
      isLoading = true;
    });
    _followersModelList = await FollowersServices().fetchFollowers(widget.userId);
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularNetworkImageWithLoading(
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
      trailing: MyEleButtonsmall(
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
            }
            else {
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
      body: 
      isLoading?Center(child: CircularProgressIndicator(),):ListView.builder(
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
      )
      ,);
  }
}