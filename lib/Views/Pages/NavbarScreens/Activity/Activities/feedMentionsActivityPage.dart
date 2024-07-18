import 'package:flutter/material.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';

class FeedMentionsActivityPage extends StatefulWidget {
  const FeedMentionsActivityPage({super.key});

  @override
  State<FeedMentionsActivityPage> createState() =>
      _FeedMentionsActivityPageState();
}

class _FeedMentionsActivityPageState extends State<FeedMentionsActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Feed Mentions Activity",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: FutureBuilder<void>(
        future: null,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKit.ring);
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return SizedBox();
              },
            );
          }
        },
      ),
    );
  }
}
