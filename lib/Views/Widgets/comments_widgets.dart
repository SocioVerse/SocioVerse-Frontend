import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentsModel.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/services/thread_services.dart';
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
                onLike();
                setState(() {
                  isLiked = !isLiked;
                  liked = isLiked;
        
                  if (isLiked) {
                    widget.thread.likeCount++;
                  } else {
                    widget.thread.likeCount--;
                  }
                });
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
              child: CircularNetworkImageWithLoading(
  imageUrl: widget.thread.userProfile,
  height: 35,
  width:35,
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
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(
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
                      physics: NeverScrollableScrollPhysics(),
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
)
;
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
                  await ThreadServices()
                      .toogleLikeThreads(threadId: widget.thread.commentId);

                  setState(() {
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
        
        SizedBox(height: 8),
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
      physics: NeverScrollableScrollPhysics(),
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

class PostCaption extends StatelessWidget {
  const PostCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              child: Icon(
                Ionicons.person,
                color: Theme.of(context).colorScheme.background,
                size: 30,
              ),
            ),
            title: Text(
              "Username",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            subtitle: Text(
              "Occupation",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            trailing: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget nunc vitae tortor aliquam aliquet. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "6 hrs ago",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Ionicons.heart_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1.2k",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Ionicons.chatbubble_ellipses_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1.2k",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
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

class CommentFeild extends StatelessWidget {
  const CommentFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          border: Border.all(color: Color(0xff2A2B39)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.background,
                blurRadius: 10,
                offset: const Offset(0, 10))
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
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
            onPressed: () {},
            child: Text('Post',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
