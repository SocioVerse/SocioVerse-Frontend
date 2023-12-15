import 'dart:developer';

import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/commentPageWidget.dart';
import 'package:socioverse/Views/Widgets/comments_widgets.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';


class ThreadCommentPage extends StatefulWidget {
 ThreadModel threadModel;
   ThreadCommentPage({required this.threadModel});

  @override
  State<ThreadCommentPage> createState() => _ThreadCommentPageState();
}

class _ThreadCommentPageState extends State<ThreadCommentPage> {
  @override
  Widget build(BuildContext context) {
    log("here");
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
      body:  Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CommentPageThreadLayout(
                    thread: widget.threadModel,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CommentBuilder(),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: CommentFeild()),
        ],
      ),
    );
  }
}