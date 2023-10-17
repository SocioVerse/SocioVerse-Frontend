import 'package:socioverse/Widgets/comments_widgets.dart';
import 'package:socioverse/Widgets/feeds_widget.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Comments",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          const SingleChildScrollView(
            child: Column(
              children: [
                PostCaption(),
                SizedBox(
                  height: 20,
                ),
                CommentBuilder(),
              ],
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: CommentFeild()),
        ],
      ),
    );
  }
}
