import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/activityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/followRequestsPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/mentionsActivityPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/Activities/storyLikesActivityPage.dart';

class Activity {
  final String title;
  IconData icon;
  Activity({required this.title, required this.icon});
}

class Activitychoicepage extends StatelessWidget {
  Activitychoicepage({super.key});
  final List<Activity> choices = [
    // 'Requests',
    // 'Feeds',
    // 'Threads',
    // 'Story Likes',
    // 'Thread Comments',
    // 'Feed Comments',
    // 'Mentions',

    Activity(title: 'Requests', icon: Icons.people),
    Activity(title: 'Story Likes', icon: Icons.history),
    Activity(title: 'Feeds', icon: Ionicons.grid_outline),
    Activity(title: 'Threads', icon: Ionicons.text),
    Activity(title: 'Thread Comments', icon: Ionicons.chatbox_outline),
    Activity(title: 'Feed Comments', icon: Ionicons.chatbox_ellipses_outline),
    Activity(title: 'Mentions', icon: Ionicons.at_outline),
  ];
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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: choices.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (choices[index].title == 'Requests') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FollowRequestsPage(),
                        ),
                      );
                    } else if (choices[index].title == 'Story Likes') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StoryLikesActivityPage(),
                        ),
                      );
                    } else if (choices[index].title == 'Mentions') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MentionsActivityPage(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ActivityPage(
                            title: choices[index].title,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          choices[index].icon,
                          size: 40,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          choices[index].title,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ));
  }
}
