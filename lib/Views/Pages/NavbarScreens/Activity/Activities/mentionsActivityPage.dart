import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/mentionActivity.dart';
import 'package:socioverse/Models/storyLikeActivity.dart';
import 'package:socioverse/Services/activity_services.dart';

class MentionsActivityPage extends StatefulWidget {
  const MentionsActivityPage({super.key});

  @override
  State<MentionsActivityPage> createState() => _MentionsActivityPageState();
}

class _MentionsActivityPageState extends State<MentionsActivityPage> {
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
          future: ActivityServices().getMentions(),
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
