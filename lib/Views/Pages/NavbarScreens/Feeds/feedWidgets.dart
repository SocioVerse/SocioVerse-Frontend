import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socioverse/Helper/Debounce/debounce.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/followers_services.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/addCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/bottomSheets.dart';
import 'package:socioverse/Views/Widgets/Global/dataStructure.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/main.dart';
import 'package:socioverse/Services/feed_services.dart';
import 'package:socioverse/Services/thread_services.dart';

class UserProfileImageStackOf2 extends StatelessWidget {
  final List<CommentUser>? commentUserProfilePic;

  final bool isShowIcon;

  const UserProfileImageStackOf2({
    super.key,
    this.commentUserProfilePic,
    required this.isShowIcon,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 41,
      child: Stack(
        children: [
          ReplyUserProfileImage(
            rightPadding: 15.5,
            userProfileImagePath: commentUserProfilePic![0].profilePic,
          ),
          ReplyUserProfileImage(
            rightPadding: 5.5,
            userProfileImagePath: commentUserProfilePic![1].profilePic,
          ),
          isShowIcon
              ? Positioned(
                  right: 0,
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black87,
                      ),
                    ),
                    child: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 18.5,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ReplyUserProfileImage extends StatelessWidget {
  const ReplyUserProfileImage({
    required this.userProfileImagePath,
    required this.rightPadding,
    super.key,
  });

  final double rightPadding;
  final String userProfileImagePath;

  @override
  Widget build(BuildContext context) {
    return rightPadding == 0
        ? Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black87,
                width: 2,
              ),
            ),
            child: CircularNetworkImageWithoutSize(
              imageUrl: userProfileImagePath,
              fit: BoxFit.fill,
            ),
          )
        : Positioned(
            right: rightPadding,
            child: Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black87,
                  width: 2,
                ),
              ),
              child: CircularNetworkImageWithoutSize(
                imageUrl: userProfileImagePath,
                fit: BoxFit.fill,
              ),
            ),
          );
  }
}

class ThreadLayout extends StatefulWidget {
  final ThreadModel thread;
  bool isComment = false;
  bool isReply = false;
  Function? onComment;
  ThreadLayout(
      {super.key,
      required this.thread,
      this.isComment = false,
      this.isReply = false,
      this.onComment});

  @override
  State<ThreadLayout> createState() => _ThreadLayoutState();
}

class _ThreadLayoutState extends State<ThreadLayout> {
  int replies = 0;
  late bool isLiked;
  late bool savedPost;
  @override
  void initState() {
    if (widget.thread.commentUsers.length == 0) {
    } else {
      replies = widget.thread.commentUsers.length;
    }
    isLiked = widget.thread.isLiked;
    savedPost = widget.thread.isSaved;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  final Debouncer _debounceSave = Debouncer(milliseconds: 1000);
  final Debouncer _debounceLike = Debouncer(milliseconds: 1000);

  void isOwner({required BuildContext context}) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red, fontSize: 16),
                ),
                onTap: () {
                  AlertBoxes.acceptRejectAlertBox(
                    context: context,
                    title: "Delete Thread",
                    content: const Text(
                        "Are you sure you want to delete this thread?"),
                    onAccept: () async {
                      context.loaderOverlay.show();
                      await ThreadServices.deleteThread(
                          threadId: widget.thread.id);
                      context.loaderOverlay.hide();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                          (route) => false);
                    },
                    onReject: () {},
                  );
                },
              ),
            ],
          );
        });
  }

  void isNotOwner() {
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
                  Ionicons.warning,
                  color: Colors.red,
                ),
                title: Text(
                  'Report',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  ReportBottomSheet(
                    reportType: "Thread",
                    context: context,
                    userId: widget.thread.user.id,
                    threadId: widget.thread.id,
                  ).showReportBottomSheet();
                  ;
                },
              ),
              widget.thread.user.isFollowing
                  ? ListTile(
                      leading: Icon(
                        Ionicons.person_remove,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      title: Text(
                        'Unfollow',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16),
                      ),
                      onTap: () {
                        UnfollowUserAlertBox(
                            context: context,
                            username: widget.thread.user.username,
                            userId: widget.thread.user.id,
                            onReject: () {});
                        setState(() {
                          widget.thread.user.isFollowing = false;
                        });
                      },
                    )
                  : SizedBox.shrink(),
            ],
          );
        });
  }

  void showUsersBottomSheet(
      BuildContext context, String threadId, Future<List<User>> future) {
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
          return SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.horizontal_rule_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder<List<User>>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKit.ring,
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      List<User> mentions = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: mentions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => UserProfilePage(
                                              owner: mentions[index].isOwner,
                                              userId: mentions[index].id,
                                            ))),
                                leading: CircularNetworkImageWithSize(
                                  imageUrl: mentions[index].profilePic,
                                  height: 40,
                                  width: 40,
                                ),
                                title: Text(
                                  mentions[index].username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                                subtitle: Text(
                                  mentions[index].occupation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              );
                            }),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  future: future,
                ),
              ],
            ),
          );
        });
  }

  StatefulBuilder getThreadFooter({
    required bool isPost,
    required Function onLike,
    required Function onComment,
    required Function onSave,
    required Function onRepost,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    isLiked = !isLiked;
                    if (isLiked) {
                      widget.thread.likeCount++;
                    } else {
                      widget.thread.likeCount--;
                    }
                    setState(() {});
                    onLike();
                  },
                  child: Icon(
                    isLiked ? Ionicons.heart : Ionicons.heart_outline,
                    color: isLiked
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    onComment();
                  },
                  child: Icon(
                    Ionicons.chatbubble_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.thread.isPrivate
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          InkWell(
                            onTap: () {
                              onRepost();
                            },
                            child: Icon(
                              Ionicons.repeat,
                              color: widget.thread.isReposted
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.onPrimary,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                InkWell(
                  onTap: () {
                    ShareList(type: ShareType.thread, context: context)
                        .showShareBottomSheet(widget.thread.id);
                  },
                  child: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 25,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  savedPost = !savedPost;
                });
                onSave();
              },
              icon: Icon(
                savedPost ? Ionicons.bookmark : Ionicons.bookmark_outline,
                color: Theme.of(context).colorScheme.onPrimary,
                size: 25,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () async {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => UserProfilePage(
                          owner: widget.thread.user.isOwner,
                          userId: widget.thread.user.id,
                        )));
          },
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CircularNetworkImageWithSize(
                      imageUrl: widget.thread.user.profilePic,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  widget.thread.isPrivate || widget.thread.isRepostedByUser
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              shape: BoxShape.circle,
                            ),
                            child: widget.thread.isRepostedByUser
                                ? Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircularNetworkImageWithoutSize(
                                      imageUrl:
                                          widget.thread.repostedBy!.profilePic,
                                    ),
                                  )
                                : const Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                    size: 10,
                                  ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          title: Text(
            widget.thread.user.username,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          subtitle: Text(
            widget.thread.user.occupation,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  CalculatingFunction.getTimeDiff(widget.thread.createdAt),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    if (widget.thread.user.isOwner == true) {
                      isOwner(
                        context: context,
                      );
                    } else {
                      isNotOwner();
                    }
                  },
                  child: Icon(
                    Ionicons.ellipsis_horizontal_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            widget.isComment
                ? const SizedBox.shrink()
                : const SizedBox(
                    width: 60,
                  ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 0,
                      bottom: 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.thread.content,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                        widget.thread.images.isEmpty
                            ? const SizedBox.shrink()
                            : const SizedBox(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: getThreadFooter(
                        isPost: false,
                        onLike: () async {
                          setState(() {});

                          _debounceLike.run(() async {
                            if (isLiked != widget.thread.isLiked) {
                              widget.thread.isLiked = !widget.thread.isLiked;
                              await ThreadServices.toggleLikeThreads(
                                threadId: widget.thread.id,
                              );
                            }
                          });
                        },
                        onComment: () {
                          if (widget.isComment == false) {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddCommentPage(
                                          thread: widget.thread,
                                        ))).then((value) => setState(() {
                                  if (widget.onComment != null) {
                                    widget.onComment!();
                                  }
                                }));
                          }
                        },
                        onSave: () async {
                          _debounceSave.run(() async {
                            if (savedPost != widget.thread.isSaved) {
                              widget.thread.isSaved = !widget.thread.isSaved;
                              await ThreadServices.toggleSaveThreads(
                                      threadId: widget.thread.id)
                                  .then((value) =>
                                      FlutterToast.flutterWhiteToast(value));
                            }
                          });
                        },
                        onRepost: () async {
                          await ThreadServices.toggleRepostThreads(
                                  threadId: widget.thread.id)
                              .then((value) =>
                                  FlutterToast.flutterWhiteToast(value));
                          setState(() {
                            widget.thread.isReposted =
                                !widget.thread.isReposted;
                          });
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            widget.isComment
                ? const SizedBox.shrink()
                : SizedBox(
                    width: 60,
                    child: replies == 3
                        ? Center(
                            child: UserProfileImageStackOf3(
                              commenterProfilePics: widget.thread.commentUsers,
                            ),
                          )
                        : replies == 2
                            ? Center(
                                child: UserProfileImageStackOf2(
                                  commentUserProfilePic:
                                      widget.thread.commentUsers,
                                  isShowIcon: false,
                                ),
                              )
                            : replies == 1
                                ? Center(
                                    child: ReplyUserProfileImage(
                                      rightPadding: 0,
                                      userProfileImagePath: widget
                                          .thread.commentUsers[0].profilePic,
                                    ),
                                  )
                                : Container(), // Provide a default empty container for other cases
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  widget.isReply == true
                      ? const SizedBox.shrink()
                      : InkWell(
                          onTap: () {
                            if (widget.isReply == false) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ThreadCommentPage(
                                            threadModel: widget.thread,
                                          ))).then((value) => setState(() {}));
                            }
                          },
                          child: Text(
                            "${widget.thread.commentCount} ${widget.thread.commentCount > 1 ? "replies" : "reply"} • ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ),
                  InkWell(
                    onTap: () {
                      showUsersBottomSheet(
                          context,
                          widget.thread.id,
                          ThreadServices.fetchThreadLikes(
                              threadId: widget.thread.id));
                    },
                    child: Text(
                      "${widget.thread.likeCount} ${widget.thread.likeCount > 1 ? "likes" : "like"}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          height: 0,
          thickness: 0.2,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}

class FeedShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {}, // Placeholder onTap
          contentPadding: const EdgeInsets.only(
            right: 10,
            top: 10,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(
                child: Shimmer.fromColors(
                  baseColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5)),
                ),
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: 20,
              width: 150,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: 15,
              width: 100,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 70, right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 20,
                  width: 170,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          height: 0,
          thickness: 0.2,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class ThreadShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () {}, // Placeholder onTap
          contentPadding: const EdgeInsets.only(
            right: 10,
            top: 10,
          ),
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(
                child: Shimmer.fromColors(
                  baseColor:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  highlightColor: Colors.grey[500]!,
                  child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5)),
                ),
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: 20,
              width: 150,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            highlightColor: Colors.grey[500]!,
            child: Container(
              height: 15,
              width: 100,
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 70.0, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 20,
                  width: 150,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ),
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 20,
                  width: 170,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ),
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 20,
                  width: 160,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 10),
              // Shimmer placeholder for GridView
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              Shimmer.fromColors(
                baseColor:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                highlightColor: Colors.grey[500]!,
                child: Container(
                  height: 20,
                  width: 170,
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          height: 0,
          thickness: 0.2,
          color: Colors.grey,
        ),
      ],
    );
  }
}

class ThreadViewBuilder extends StatefulWidget {
  const ThreadViewBuilder({super.key});

  @override
  State<ThreadViewBuilder> createState() => _ThreadViewBuilderState();
}

class _ThreadViewBuilderState extends State<ThreadViewBuilder> {
  bool threadFetched = false;
  List<ThreadModel> allThreads = [];
  @override
  void initState() {
    fetchFollowingThread();
    super.initState();
  }

  fetchFollowingThread() async {
    setState(() {
      threadFetched = false;
    });
    allThreads = await ThreadServices.getFollowingThreads();
    setState(() {
      threadFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return threadFetched
        ? allThreads.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  AllCaughtUp(),
                ],
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10),
                itemCount: allThreads.length,
                itemBuilder: (context, index) {
                  return ThreadLayout(
                    thread: allThreads[index],
                  );
                },
              )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: 2,
            itemBuilder: (context, index) {
              return ThreadShimmer();
            },
          );
  }
}

class AllCaughtUp extends StatelessWidget {
  const AllCaughtUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Icon(
          Icons.check_circle_outline_rounded,
          size: 70,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          "All caught up",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 20,
                color: Theme.of(context).colorScheme.tertiary,
              ),
        ),
      ],
    );
  }
}

class FeedLayout extends StatefulWidget {
  final FeedModel feed;
  bool isOnCommentPage = false;
  bool isComment = false;
  Function? onComment;
  FeedLayout(
      {super.key,
      required this.feed,
      this.isComment = false,
      this.onComment,
      this.isOnCommentPage = false});

  @override
  State<FeedLayout> createState() => _FeedLayoutState();
}

class _FeedLayoutState extends State<FeedLayout> {
  bool _havereplies = true;
  int replies = 0;
  late bool isLiked;
  late bool savedPost;
  @override
  void initState() {
    if (widget.feed.commentUsers.length == 0) {
      _havereplies = false;
    } else {
      replies = widget.feed.commentUsers.length;
    }
    isLiked = widget.feed.isLiked;
    savedPost = widget.feed.isSaved;
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void isOwner({required BuildContext context}) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
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
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.red, fontSize: 16),
                ),
                onTap: () {
                  AlertBoxes.acceptRejectAlertBox(
                    context: context,
                    title: "Delete Feed",
                    content: const Text(
                        "Are you sure you want to delete this feed?"),
                    onAccept: () async {
                      context.loaderOverlay.show();
                      await FeedServices.deleteFeed(feedId: widget.feed.id);
                      context.loaderOverlay.hide();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                          (route) => false);
                    },
                    onReject: () {},
                  );
                },
              ),
            ],
          );
        });
  }

  void isNotOwner() {
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
                  Ionicons.warning,
                  color: Colors.red,
                ),
                title: Text(
                  'Report',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  ReportBottomSheet(
                          reportType: "Feed",
                          context: context,
                          userId: widget.feed.user.id,
                          feedId: widget.feed.id)
                      .showReportBottomSheet();
                },
              ),
              !widget.feed.user.isFollowing
                  ? const SizedBox.shrink()
                  : ListTile(
                      leading: Icon(
                        Ionicons.person_remove,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      title: Text(
                        'Unfollow',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 16),
                      ),
                      onTap: () {
                        UnfollowUserAlertBox(
                            context: context,
                            username: widget.feed.user.username,
                            userId: widget.feed.user.id,
                            onReject: () {});
                      },
                    ),
            ],
          );
        });
  }

  StatefulBuilder getFeedFooter({
    required bool isPost,
    required Function onLike,
    required Function onComment,
    required Function onSave,
  }) {
    TextEditingController postMessage = TextEditingController();
    TextEditingController search = TextEditingController();
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    isLiked = !isLiked;
                    if (isLiked) {
                      widget.feed.likeCount++;
                    } else {
                      widget.feed.likeCount--;
                    }
                    setState(() {});

                    onLike();
                  },
                  child: Icon(
                    isLiked ? Ionicons.heart : Ionicons.heart_outline,
                    color: isLiked
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                widget.feed.allowComments == false
                    ? const SizedBox.shrink()
                    : Row(
                        children: [
                          InkWell(
                            onTap: () {
                              onComment();
                            },
                            child: Icon(
                              Ionicons.chatbubble_outline,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 25,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                InkWell(
                  onTap: () {
                    ShareList(context: context, type: ShareType.feed)
                        .showShareBottomSheet(widget.feed.id);
                  },
                  child: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 25,
                  ),
                ),
              ],
            ),
            widget.feed.allowSave == false
                ? const SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      setState(() {
                        savedPost = !savedPost;
                      });
                      onSave();
                    },
                    icon: Icon(
                      savedPost ? Ionicons.bookmark : Ionicons.bookmark_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 25,
                    ),
                  ),
          ],
        );
      },
    );
  }

  void showUsersBottomSheet(
      BuildContext context, String feedId, Future<List<User>> future) {
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
          return SizedBox(
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Icon(
                  Icons.horizontal_rule_rounded,
                  size: 50,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.secondary,
                  thickness: 2,
                ),
                const SizedBox(
                  height: 5,
                ),
                FutureBuilder<List<User>>(
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: SpinKit.ring,
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          "Error: ${snapshot.error}",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      List<User> mentions = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                            itemCount: mentions.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () => Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) => UserProfilePage(
                                              owner: mentions[index].isOwner,
                                              userId: mentions[index].id,
                                            ))),
                                leading: CircularNetworkImageWithSize(
                                  imageUrl: mentions[index].profilePic,
                                  height: 40,
                                  width: 40,
                                ),
                                title: Text(
                                  mentions[index].username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                ),
                                subtitle: Text(
                                  mentions[index].occupation,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontSize: 14,
                                      ),
                                ),
                              );
                            }),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                  future: future,
                ),
              ],
            ),
          );
        });
  }

  PageController pageController = PageController(initialPage: 0);
  final Debouncer _debounceLike = Debouncer(milliseconds: 1000);
  final Debouncer _debounceSave = Debouncer(milliseconds: 1000);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          onTap: () async {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => UserProfilePage(
                          owner: widget.feed.user.isOwner,
                          userId: widget.feed.user.id,
                        )));
          },
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CircularNetworkImageWithSize(
                      imageUrl: widget.feed.user.profilePic,
                      height: 35,
                      width: 35,
                    ),
                  ),
                  widget.feed.isPrivate
                      ? Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 15,
                            width: 15,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 10,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          title: Text(
            widget.feed.user.username,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary),
          ),
          subtitle: widget.feed.location == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 15,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          widget.feed.location!,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
          trailing: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  CalculatingFunction.getTimeDiff(widget.feed.createdAt),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 10,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    if (widget.feed.user.isOwner == true) {
                      isOwner(
                        context: context,
                      );
                    } else {
                      isNotOwner();
                    }
                  },
                  child: Icon(
                    Ionicons.ellipsis_horizontal_circle_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            widget.isComment
                ? const SizedBox.shrink()
                : const SizedBox(
                    width: 60,
                  ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.25,
                        height: MediaQuery.of(context).size.width / 1.25,
                        child: PageView(
                            controller: pageController,
                            children: List.generate(
                              widget.feed.images.length,
                              (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RoundedNetworkImageWithLoading(
                                  imageUrl: widget.feed.images[index],
                                  borderRadius:
                                      10, // Set the desired border radius
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                      widget.feed.images.length == 1
                          ? const SizedBox.shrink()
                          : Positioned(
                              bottom: 10,
                              child: SmoothPageIndicator(
                                onDotClicked: (index) =>
                                    pageController.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                ),
                                controller: pageController,
                                count: widget.feed.images.length,
                                effect: WormEffect(
                                  activeDotColor:
                                      Theme.of(context).colorScheme.primary,
                                  type: WormType.thin,
                                  dotWidth: 6,
                                  dotHeight: 6,
                                  dotColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                      widget.feed.mentions.isNotEmpty
                          ? Positioned(
                              right: 10,
                              bottom: 10,
                              child: InkWell(
                                onTap: () {
                                  showUsersBottomSheet(
                                      context,
                                      widget.feed.id,
                                      FeedServices.fetchFeedMentions(
                                          feedId: widget.feed.id));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.person_rounded,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  widget.feed.caption == null || widget.feed.caption!.isEmpty
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Wrap(
                            alignment: WrapAlignment.start,
                            children: [
                              Text(
                                "${widget.feed.user.username} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                widget.feed.caption!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withAlpha(200),
                                      fontStyle: FontStyle.italic,
                                    ),
                              ),
                            ],
                          ),
                        ),
                  widget.feed.tags.isEmpty
                      ? const SizedBox(
                          height: 10,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Wrap(
                            children: List.generate(
                                widget.feed.tags.length,
                                (index) => Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Chip(
                                        label: Text(
                                            '#${widget.feed.tags[index]}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontStyle: FontStyle.italic,
                                                )),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                    )),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: getFeedFooter(
                      isPost: false,
                      onLike: () async {
                        setState(() {});

                        _debounceLike.run(() async {
                          if (isLiked != widget.feed.isLiked) {
                            widget.feed.isLiked = !widget.feed.isLiked;
                            await FeedServices.toggleLikeFeeds(
                                feedId: widget.feed.id);
                          }
                        });
                      },
                      onComment: () {
                        if (widget.isOnCommentPage == false) {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => CommentPage(
                                        feed: widget.feed,
                                      ))).then((value) => setState(() {
                                if (widget.onComment != null) {
                                  widget.onComment!();
                                }
                              }));
                        }
                      },
                      onSave: () async {
                        _debounceSave.run(() async {
                          if (savedPost != widget.feed.isSaved) {
                            widget.feed.isSaved = !widget.feed.isSaved;
                            await FeedServices.toggleSaveFeeds(
                                    feedId: widget.feed.id)
                                .then((value) =>
                                    FlutterToast.flutterWhiteToast(value));
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            widget.isComment
                ? const SizedBox.shrink()
                : SizedBox(
                    width: 60,
                    child: replies == 3
                        ? Center(
                            child: UserProfileImageStackOf3(
                              commenterProfilePics: widget.feed.commentUsers,
                            ),
                          )
                        : replies == 2
                            ? Center(
                                child: UserProfileImageStackOf2(
                                  commentUserProfilePic:
                                      widget.feed.commentUsers,
                                  isShowIcon: false,
                                ),
                              )
                            : replies == 1
                                ? Center(
                                    child: ReplyUserProfileImage(
                                      rightPadding: 0,
                                      userProfileImagePath: widget
                                          .feed.commentUsers[0].profilePic,
                                    ),
                                  )
                                : Container(), // Provide a default empty container for other cases
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                children: [
                  widget.isOnCommentPage == true
                      ? const SizedBox.shrink()
                      : widget.feed.allowComments == false
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () {
                                if (widget.isOnCommentPage) return;
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CommentPage(
                                                  feed: widget.feed,
                                                )))
                                    .then((value) => setState(() {}));
                              },
                              child: Text(
                                "${widget.feed.commentCount} ${widget.feed.commentCount > 1 ? "replies" : "reply"} • ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                    ),
                              ),
                            ),
                  InkWell(
                    onTap: () {
                      showUsersBottomSheet(context, widget.feed.id,
                          FeedServices.fetchFeedLikes(feedId: widget.feed.id));
                    },
                    child: Text(
                      "${widget.feed.likeCount} ${widget.feed.likeCount > 1 ? "likes" : "like"}",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Divider(
          height: 0,
          thickness: 0.2,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ],
    );
  }
}

class FeedViewBuilder extends StatefulWidget {
  const FeedViewBuilder({super.key});

  @override
  State<FeedViewBuilder> createState() => _FeedViewBuilderState();
}

class _FeedViewBuilderState extends State<FeedViewBuilder> {
  bool feedFetched = false;
  List<FeedModel> allFeeds = [];
  void initState() {
    fetchFollowingFeed();
    super.initState();
  }

  fetchFollowingFeed() async {
    setState(() {
      feedFetched = false;
    });
    allFeeds = await FeedServices.getFollowingFeeds();
    setState(() {
      feedFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return feedFetched
        ? allFeeds.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  AllCaughtUp(),
                ],
              )
            : ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10),
                itemCount: allFeeds.length,
                itemBuilder: (context, index) {
                  return FeedLayout(
                    feed: allFeeds[index],
                  );
                },
              )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 10),
            itemCount: 2,
            itemBuilder: (context, index) {
              return FeedShimmer();
            },
          );
  }
}
