import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/storyLikeActivity.dart';
import 'package:socioverse/Services/activity_services.dart';
import 'package:socioverse/Views/Widgets/activityListTileWidget.dart';

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
          future: ActivityServices.getStoryLikes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: SpinKit.ring);
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.data == null || snapshot.data!.isEmpty) {
              return const Center(child: Text('No Activity Found'));
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                StoryLikeActivity storyActivity = snapshot.data![index];
                return ActivityListTile(
                  profilePicUrl: storyActivity.latestLike.likedBy.profilePic,
                  username: storyActivity.latestLike.likedBy.username,
                  createdAt: storyActivity.createdAt,
                  subtitle: 'Liked a story',
                  postImageUrl: storyActivity.image,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
