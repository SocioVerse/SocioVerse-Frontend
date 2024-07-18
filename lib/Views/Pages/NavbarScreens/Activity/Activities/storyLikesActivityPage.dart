import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/storyLikeActivity.dart';
import 'package:socioverse/Services/activity_services.dart';

class StoryLikesActivityPage extends StatefulWidget {
  const StoryLikesActivityPage({super.key});

  @override
  State<StoryLikesActivityPage> createState() => _StoryLikesActivityPageState();
}

class _StoryLikesActivityPageState extends State<StoryLikesActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Story Likes Activity",
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
        child: FutureBuilder<List<StoryLikeActivity>>(
          future: ActivityServices().getStoryLikes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKit.ring);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
