import 'package:flutter/material.dart';

import '../../Widgets/buttons.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
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

  ListTile followTile({
    required String ttl1,
    required String ttl2,
    required String name,
    required String imgUrl,
    required DateTime dateTime,
  }) {
    String time = getTimeDiff(dateTime);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: CircleAvatar(
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

  ListTile likedTile({
    required String name,
    required String imgUrl,
    required String postUrl,
    required DateTime dateTime,
  }) {
    String time = getTimeDiff(dateTime);
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: CircleAvatar(
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
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Image.asset(
            "assets/Country_flag/in.png",
            height: 40,
            width: 40,
            fit: BoxFit.cover,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Activity",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 80,
              child: likedTile(
                name: "Fatima",
                postUrl: "assets/Country_flag/in.png",
                imgUrl: "assets/Country_flag/in.png",
                dateTime: DateTime(2023, 7, 20, 12, 0),
              ),
            );
          },
        ),
      ),
    );
  }
}
