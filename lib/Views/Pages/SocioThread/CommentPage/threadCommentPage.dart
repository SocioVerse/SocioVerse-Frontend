import 'dart:developer';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/addCommentPage.dart';
import 'package:socioverse/Models/threadCommentsModel.dart';
import 'package:socioverse/Services/thread_comments_services.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Widgets/comments_widgets.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';

class ThreadCommentPage extends StatefulWidget {
  final String? threadId;
  ThreadModel? threadModel;
  ThreadCommentPage({super.key, this.threadModel, this.threadId});

  @override
  State<ThreadCommentPage> createState() => _ThreadCommentPageState();
}

class _ThreadCommentPageState extends State<ThreadCommentPage> {
  List<ThreadModel>? threadReplies = [];
  bool isLoading = true;
  late ThreadModel threadModel;
  @override
  void initState() {
    getThreadComments();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getThreadComments() async {
    setState(() {
      isLoading = true;
    });
    if (widget.threadModel == null) {
      List<dynamic> fetched = await Future.wait([
        ThreadServices.getThreadById(threadId: widget.threadId!),
        ThreadCommentServices.fetchThreadReplies(widget.threadId!)
      ]);
      if (fetched[0] == null) {
        Navigator.pop(context);
        return;
      }
      threadModel = fetched[0] as ThreadModel;
      threadReplies = fetched[1] as List<ThreadModel>;
      log(widget.threadModel.toString());
    } else {
      threadModel = widget.threadModel!;
      threadReplies = await ThreadCommentServices.fetchThreadReplies(
          widget.threadModel!.id);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isLoading == true
              ? null
              : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddCommentPage(
                            thread: threadModel!,
                          ))).then((value) => getThreadComments());
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          Ionicons.chatbubble,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      appBar: AppBar(
        title: Text(
          "Comments",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(child: SpinKit.ring)
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ThreadLayout(
                      isComment: true,
                      isReply: true,
                      thread: threadModel!,
                      onComment: getThreadComments,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommentBuilder(
                      threadReplies: threadReplies!,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
