import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/followRequestsPage.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';

String getTimeDiff(DateTime dateTime) {
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);
  int hoursAgo = difference.inHours;
  String time = '';
  if (hoursAgo == 1) {
    time = '1 hour ago';
  } else if (hoursAgo < 24) {
    time = '$hoursAgo hours ago';
  } else {
    int daysAgo = difference.inDays;
    time = '$daysAgo days ago';
  }
  return time;
}

class FollowTile extends StatelessWidget {
  final String ttl1;
  final String ttl2;
  final String name;
  final String imgUrl;
  final DateTime dateTime;

  FollowTile({
    required this.ttl1,
    required this.ttl2,
    required this.name,
    required this.imgUrl,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    String time = getTimeDiff(dateTime);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
              "assets/Country_flag/in.png",
            )),
      ),
      title: Text(
        "Fatima",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Started following you",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                ),
          ),
        ],
      ),
      trailing: MyEleButtonsmall(
          title2: ttl2, title: ttl1, onPressed: () {}, ctx: context),
    );
  }
}

class LikedTile extends StatelessWidget {
  final String name;
  final String imgUrl;
  final String postUrl;
  final DateTime dateTime;

  LikedTile({
    required this.name,
    required this.imgUrl,
    required this.postUrl,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    String time = getTimeDiff(dateTime);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(
              "assets/Country_flag/in.png",
            )),
      ),
      title: Text(
        "Fatima",
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Liked your post",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                ),
          ),
          Text(
            time,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 14,
                ),
          ),
        ],
      ),
      trailing: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            "assets/Country_flag/in.png",
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )),
    );
  }
}

class StackOfTwo extends StatelessWidget {
  List<String> images;

  StackOfTwo({required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: 55,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            child: CircularNetworkImageWithSize(
              imageUrl: images[1],
              height: 48,
              width: 48,
            ),
          ),
          Positioned(
            left: 5,
            top: 5,
            child: CircleAvatar(
              radius: 27,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: CircularNetworkImageWithSize(
                imageUrl: images[0],
                height: 48,
                width: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RequestsTile extends StatelessWidget {
  final LatestFollowRequestModel latestFollowRequestModel;
  final Function onTap;
  const RequestsTile(
      {super.key, required this.latestFollowRequestModel, required this.onTap});

  String getText() {
    if (latestFollowRequestModel.followRequestCount == 1) {
      return "${latestFollowRequestModel.names[0]} sent you a request";
    } else if (latestFollowRequestModel.followRequestCount == 2) {
      return "${latestFollowRequestModel.names[0]} and ${latestFollowRequestModel.names[1]} sent you a request";
    } else {
      return "${latestFollowRequestModel.names[0]}, ${latestFollowRequestModel.names[1]} and ${latestFollowRequestModel.followRequestCount - 2} others sent you a request";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: ((context) => const FollowRequestsPage())))
                .then((value) {
              onTap();
            });
          },
          leading: Stack(
            children: [
              latestFollowRequestModel.followRequestCount == 1
                  ? CircularNetworkImageWithoutSize(
                      imageUrl: latestFollowRequestModel.profilePics[0],
                      fit: BoxFit.cover,
                    )
                  : StackOfTwo(
                      images: latestFollowRequestModel.profilePics,
                    ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle),
                  child: Center(
                      child: Text(
                    "${latestFollowRequestModel.followRequestCount}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  )),
                ),
              )
            ],
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Requests",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getText(),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Divider(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        )
      ],
    );
  }
}
