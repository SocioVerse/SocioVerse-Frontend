import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Models/feedActivityModels.dart';
import 'package:socioverse/Models/threadActivityModel.dart';
import 'package:socioverse/Models/threadCommentsActivityModel.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Services/activity_services.dart';
import 'package:socioverse/Services/feedCommentActivity.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Widgets/activityListTileWidget.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key, required this.title});
  final String title;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  int type = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "${widget.title} Activity",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            tabSlider(context),
            const SizedBox(
              height: 20,
            ),
            Flexible(
              child: FutureBuilder(
                  future: ActivityServices.getActivity(widget.title,
                      type: type == 1 ? "likes" : "comments"),
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
                          if (widget.title == "Threads") {
                            if (type == 1) {
                              ThreadLikesActivity threadActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: threadActivity
                                    .latestLike.likedBy.profilePic,
                                username:
                                    threadActivity.latestLike.likedBy.username,
                                createdAt: threadActivity.createdAt,
                                subtitle:
                                    'and ${threadActivity.likeCount} others liked a thread',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ThreadCommentPage(
                                      threadId: threadActivity.id,
                                    );
                                  }));
                                },
                              );
                            } else {
                              ThreadCommentsActivity threadActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: threadActivity
                                    .latestComment.userId.profilePic,
                                username: threadActivity
                                    .latestComment.userId.username,
                                createdAt: threadActivity.createdAt,
                                subtitle:
                                    'and ${threadActivity.commentCount} others commented on a thread',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ThreadCommentPage(
                                      threadId: threadActivity.id,
                                    );
                                  }));
                                },
                              );
                            }
                          } else if (widget.title == "Feeds") {
                            if (type == 1) {
                              FeedLikeActivity feedActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl:
                                    feedActivity.latestLikes.likedBy.profilePic,
                                username:
                                    feedActivity.latestLikes.likedBy.username,
                                createdAt: feedActivity.createdAt,
                                subtitle:
                                    'and ${feedActivity.likeCount} others liked a feed',
                                postImageUrl: feedActivity.images[0],
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CommentPage(
                                      feedId: feedActivity.id,
                                    );
                                  }));
                                },
                              );
                            } else {
                              FeedCommentsActivity feedActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: feedActivity
                                    .latestComment.userId.profilePic,
                                username:
                                    feedActivity.latestComment.userId.username,
                                createdAt: feedActivity.createdAt,
                                subtitle:
                                    'and ${feedActivity.commentCount} others commented on a feed',
                                postImageUrl: feedActivity.images[0],
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CommentPage(
                                      feedId: feedActivity.id,
                                    );
                                  }));
                                },
                              );
                            }
                          } else if (widget.title == "Thread Comments") {
                            if (type == 1) {
                              ThreadCommentLikesActivity threadActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: threadActivity
                                    .latestLike.likedBy.profilePic,
                                username:
                                    threadActivity.latestLike.likedBy.username,
                                createdAt: threadActivity.createdAt,
                                subtitle:
                                    'and ${threadActivity.likeCount} others liked a comment',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ThreadCommentPage(
                                      threadId: threadActivity.id,
                                    );
                                  }));
                                },
                              );
                            } else {
                              ThreadCommentCommentsActivity threadActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: threadActivity
                                    .latestComment.userId.profilePic,
                                username: threadActivity
                                    .latestComment.userId.username,
                                createdAt: threadActivity.createdAt,
                                subtitle:
                                    'and ${threadActivity.commentCount} others commented on a comment',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ThreadCommentPage(
                                      threadId: threadActivity.id,
                                    );
                                  }));
                                },
                              );
                            }
                          } else {
                            if (type == 1) {
                              FeedCommentLikesActivity feedActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl:
                                    feedActivity.latestLike.likedBy.profilePic,
                                username:
                                    feedActivity.latestLike.likedBy.username,
                                createdAt: feedActivity.createdAt,
                                subtitle:
                                    'and ${feedActivity.likeCount} others liked a comment',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CommentReplyPage(
                                      feedCommentId: feedActivity.id,
                                    );
                                  }));
                                },
                              );
                            } else {
                              FeedCommentCommentsActivity feedActivity =
                                  snapshot.data![index];
                              return ActivityListTile(
                                profilePicUrl: feedActivity
                                    .latestComment.userId.profilePic,
                                username:
                                    feedActivity.latestComment.userId.username,
                                createdAt: feedActivity.createdAt,
                                subtitle:
                                    'and ${feedActivity.commentCount} others commented on a comment',
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CommentReplyPage(
                                      feedCommentId: feedActivity.id,
                                    );
                                  }));
                                },
                              );
                            }
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox tabSlider(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomSlidingSegmentedControl<int>(
            initialValue: 1,
            children: {
              1: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Ionicons.heart_outline,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Likes",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
              2: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(
                      Ionicons.chatbubble_outline,
                      size: 15,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Comments",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ],
              ),
            },
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            thumbDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(
                    0.0,
                    2.0,
                  ),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInToLinear,
            onValueChanged: (v) {
              setState(() {
                type = v;
              });
            },
          ),
        ],
      ),
    );
  }
}
