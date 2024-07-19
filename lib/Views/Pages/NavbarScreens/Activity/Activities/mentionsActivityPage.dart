import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/mentionActivity.dart';
import 'package:socioverse/Models/storyLikeActivity.dart';
import 'package:socioverse/Services/activity_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/activityListTileWidget.dart';

class MentionsActivityPage extends StatefulWidget {
  const MentionsActivityPage({super.key});

  @override
  State<MentionsActivityPage> createState() => _MentionsActivityPageState();
}

class _MentionsActivityPageState extends State<MentionsActivityPage> {
  Function? _data;
  @override
  void initState() {
    _data = ActivityServices().getMentions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Mentions Activity",
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
          child: FutureBuilder<List<MentionsActivity>>(
            future: _data!(),
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
                  MentionsActivity mentionsActivity = snapshot.data![index];
                  return ActivityListTile(
                      profilePicUrl: mentionsActivity.userId.profilePic,
                      username: mentionsActivity.userId.username,
                      createdAt: mentionsActivity.createdAt,
                      subtitle: 'Mentioned you in a post',
                      postImageUrl: mentionsActivity.images.first,
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CommentPage(
                            feedId: mentionsActivity.id,
                          );
                        }));
                      });
                },
              );
            },
          ),
        ));
  }
}
