import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:socioverse/Helper/Debounce/debounce.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Models/threadCommentsModel.dart';
import 'package:socioverse/Models/commentModel.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/thread_services.dart';

class ThreadCommentLayout extends StatefulWidget {
  final ThreadRepliesModel thread;
  const ThreadCommentLayout({super.key, required this.thread});

  @override
  State<ThreadCommentLayout> createState() => _ThreadCommentLayoutState();
}

class _ThreadCommentLayoutState extends State<ThreadCommentLayout> {
  int replies = 0;
  bool liked = false;
  @override
  void initState() {
    super.initState();
    replies = widget.thread.commentCount;
    liked = widget.thread.isLiked;
  }

  StatefulBuilder getThreadFooter({
    required bool isPost,
    required Function onLike,
    required Function onComment,
    required Function onSave,
  }) {
    bool isLiked = liked;
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                  liked = isLiked;

                  if (isLiked) {
                    widget.thread.likeCount++;
                  } else {
                    widget.thread.likeCount--;
                  }
                });
                onLike();
              },
              icon: Icon(
                isLiked ? Ionicons.heart : Ionicons.heart_outline,
                color: isLiked
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onPrimary,
                size: 30,
              ),
            ),
            Text(
              widget.thread.likeCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
            IconButton(
              onPressed: () {
                onComment();
              },
              icon: Icon(
                Ionicons.chatbubble_outline,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 30,
              ),
            ),
            Text(
              widget.thread.commentCount.toString(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        );
      },
    );
  }

  final _debounceLike = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularNetworkImageWithSize(
                imageUrl: widget.thread.userProfile,
                height: 35,
                width: 35,
              ),
            ),
          ),
          title: Text(
            widget.thread.username,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          subtitle: Text(
            widget.thread.occupation,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        Flexible(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.thread.content,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: widget.thread.images.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemBuilder: (context, index) {
                        return RoundedNetworkImageWithLoading(
                          imageUrl: widget.thread.images[index],
                          borderRadius: 5, // Set the desired border radius
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              getThreadFooter(
                isPost: false,
                onLike: () async {
                  setState(() {});
                  _debounceLike.run(() async {
                    await ThreadServices()
                        .toggleLikeThreads(threadId: widget.thread.commentId);
                  });
                },
                onComment: () {
                  // Navigator.push(
                  //     context,
                  //     CupertinoPageRoute(
                  //         builder: (context) =>  ThreadCommentPage(
                  //           threadModel : widget.thread,
                  //         )));
                },
                onSave: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          height: 0,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}

class CommentBuilder extends StatelessWidget {
  final List<ThreadModel> threadReplies;
  const CommentBuilder({super.key, required this.threadReplies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: threadReplies.length,
      itemBuilder: (context, index) {
        return ThreadLayout(
          thread: threadReplies[index],
        );
      },
    );
  }
}

class FeedCommentWidget extends StatefulWidget {
  final FeedModel? feed;
  final FeedComment feedComment;
  final Function? onDelete;
  final bool isComment;
  const FeedCommentWidget({
    super.key,
    this.feed,
    this.onDelete,
    required this.feedComment,
    this.isComment = false,
  });

  @override
  State<FeedCommentWidget> createState() => _FeedCommentWidgetState();
}

class _FeedCommentWidgetState extends State<FeedCommentWidget> {
  Debouncer _debouncer = Debouncer(milliseconds: 1000);
  bool isLiked = false;

  @override
  void initState() {
    isLiked = widget.feedComment.isLiked;
    super.initState();
  }

  void showMentionsBottomSheet(BuildContext context, FeedComment feedComment) {
    if (feedComment.userId.isOwner) {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.horizontal_rule_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                ListTile(
                  leading: const Icon(
                    Ionicons.trash_bin,
                    color: Colors.red,
                  ),
                  title: Text(
                    'Delete',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16),
                  ),
                  onTap: () async {
                    context.loaderOverlay.show();

                    await FeedServices()
                        .deleteFeedComment(commentId: feedComment.id)
                        .then((value) => {
                              if (context.mounted)
                                {
                                  if (widget.onDelete != null)
                                    widget.onDelete!(),
                                  context.loaderOverlay.hide(),
                                  Navigator.pop(context)
                                }
                            });
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.copy_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                  title: Text(
                    'Copy',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16),
                  ),
                  onTap: () async {
                    await Clipboard.setData(
                        ClipboardData(text: feedComment.content));
                    FlutterToast.flutterWhiteToast(
                        "Comment Copied Successfully");
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => UserProfilePage(
                            userId: widget.feedComment.userId.id,
                            owner: widget.feedComment.userId.isOwner,
                          )));
            },
            contentPadding: const EdgeInsets.all(0),
            leading: SizedBox(
              height: 40,
              width: 40,
              child: CircularNetworkImageWithSize(
                imageUrl: widget.feedComment.userId.profilePic,
                height: 35,
                width: 35,
              ),
            ),
            title: Text(
              widget.feedComment.userId.username,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            subtitle: Text(
              widget.feedComment.userId.occupation,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Wrap(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  CalculatingFunction.getTimeDiff(widget.feedComment.createdAt),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    showMentionsBottomSheet(context, widget.feedComment);
                  },
                  child: Icon(
                    Ionicons.ellipsis_horizontal_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2))),
            child: Row(
              children: [
                const SizedBox(
                  width: 60,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feedComment.content,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      CalculatingFunction.getTimeDiff(
                          widget.feedComment.createdAt),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            isLiked = !isLiked;
                            if (isLiked) {
                              widget.feedComment.likeCount++;
                            } else {
                              widget.feedComment.likeCount--;
                            }
                            setState(() {});

                            _debouncer.run(() async {
                              if (isLiked != widget.feedComment.isLiked) {
                                widget.feedComment.isLiked =
                                    !widget.feedComment.isLiked;
                                await FeedServices().toggleFeedCommentLike(
                                    commentId: widget.feedComment.id);
                              }
                            });
                          },
                          child: isLiked
                              ? const Icon(
                                  Ionicons.heart,
                                  color: Color(0xffFF4D67),
                                )
                              : Icon(
                                  Ionicons.heart_outline,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.feedComment.likeCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.isComment) return;
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => CommentReplyPage(
                                          onDeleted: () {
                                            if (widget.onDelete != null)
                                              widget.onDelete!();
                                          },
                                          feedComment: widget.feedComment,
                                        ))).then((value) {
                              if (value != null) {
                                if (value as bool == true) {
                                  widget.onDelete!();
                                }
                              }
                              setState(() {});
                            });
                          },
                          child: Icon(
                            Ionicons.chatbubble_ellipses_outline,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.feedComment.commentCount.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
