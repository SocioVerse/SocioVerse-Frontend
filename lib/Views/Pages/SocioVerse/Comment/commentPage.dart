import 'dart:math';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentModel.dart';
import 'package:socioverse/Views/Widgets/comments_widgets.dart';
import 'package:flutter/material.dart';

import 'package:ionicons/ionicons.dart';

class CommentPage extends StatefulWidget {
  final String? feedId;
  FeedModel? feed;
  CommentPage({super.key, this.feedId, this.feed});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<FeedComment> feedReplies = [];
  bool isLoading = true;
  FeedModel? feed;
  @override
  void initState() {
    getComments();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getComments() async {
    setState(() {
      isLoading = true;
    });
    if (widget.feedId != null) {
      feed = await FeedServices().getFeed(feedId: widget.feedId!);
    } else {
      feed = widget.feed;
    }
    feedReplies = await FeedServices().fetchFeedComments(feedId: feed!.id);
    setState(() {
      isLoading = false;
    });
  }

  Widget commentField({Key? key, required FeedModel feed}) {
    TextEditingController content = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
          left: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
          right: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: content,
              maxLines: null,
              onChanged: (value) {},
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.surface),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Your comment...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () async {
              context.loaderOverlay.show();
              FeedComment newComment = await FeedServices()
                  .createComment(content: content.text, feedId: feed!.id);

              content.clear();

              feed!.commentCount = feed!.commentCount + 1;
              feedReplies.insert(0, newComment);
              setState(() {});
              if (context.mounted) context.loaderOverlay.hide();
            },
            child: Text('Post',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }

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
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: isLoading == true
          ? Center(
              child: SpinKitRing(
                color: Theme.of(context).colorScheme.tertiary,
                lineWidth: 1,
                duration: const Duration(seconds: 1),
              ),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      FeedLayout(
                        isOnCommentPage: true,
                        feed: feed!,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? Center(
                              child: SpinKitRing(
                                color: Theme.of(context).colorScheme.tertiary,
                                lineWidth: 1,
                                duration: const Duration(seconds: 1),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: feedReplies.length,
                              itemBuilder: (context, index) {
                                return FeedCommentWidget(
                                  onDelete: () {
                                    feed?.commentCount--;
                                    feedReplies.removeAt(index);
                                    setState(() {});
                                  },
                                  feed: feed,
                                  feedComment: feedReplies[index],
                                );
                              }),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: commentField(
                      feed: feed!,
                    )),
              ],
            ),
    );
  }
}

class CommentReplyPage extends StatefulWidget {
  Function? onDeleted;
  final FeedComment feedComment;
  CommentReplyPage({super.key, required this.feedComment, this.onDeleted});

  @override
  State<CommentReplyPage> createState() => _CommentReplyPageState();
}

class _CommentReplyPageState extends State<CommentReplyPage> {
  List<FeedComment> feedReplies = [];
  bool isLoading = true;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  getCommentReply() async {
    setState(() {
      isLoading = true;
    });
    feedReplies = await FeedServices()
        .fetchcommentReplies(commentId: widget.feedComment.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCommentReply();
    super.initState();
  }

  Widget commentField({Key? key, required FeedComment feedComment}) {
    TextEditingController content = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        border: Border(
          top: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
          left: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
          right: BorderSide(
              color: Theme.of(context).colorScheme.secondary, width: 2),
        ),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: content,
              maxLines: null,
              onChanged: (value) {},
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.surface),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Your comment...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () async {
              context.loaderOverlay.show();
              FeedComment newComment = await FeedServices().createCommentReply(
                  content: content.text, commentId: feedComment.id);

              content.clear();

              feedComment.commentCount = feedComment.commentCount + 1;
              feedReplies.insert(0, newComment);
              setState(() {});
              if (context.mounted) context.loaderOverlay.hide();
            },
            child: Text('Post',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }

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
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                FeedCommentWidget(
                  isComment: true,
                  onDelete: () {
                    widget.onDeleted!();
                    Navigator.pop(context, [true]);
                  },
                  feedComment: widget.feedComment,
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? Center(
                        child: SpinKitRing(
                          color: Theme.of(context).colorScheme.tertiary,
                          lineWidth: 1,
                          duration: const Duration(seconds: 1),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: feedReplies.length,
                        itemBuilder: (context, index) {
                          return FeedCommentWidget(
                            onDelete: () {
                              widget.feedComment.commentCount--;
                              feedReplies.removeAt(index);
                              setState(() {});
                            },
                            feedComment: feedReplies[index],
                          );
                        }),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: commentField(
                feedComment: widget.feedComment,
              )),
        ],
      ),
    );
  }
}
