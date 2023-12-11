import 'dart:developer';

import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/SocioThread/threadReply.dart';
import 'package:socioverse/Views/Pages/SocioVerse/commentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/storyPage.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socioverse/services/thread_services.dart';
import 'package:socioverse/Views/Pages/SocioThread/widgets.dart';

import 'buttons.dart';

class StoriesScroller extends StatefulWidget {
  const StoriesScroller({super.key});

  @override
  State<StoriesScroller> createState() => _StoriesScrollerState();
}

class _StoriesScrollerState extends State<StoriesScroller> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: ((context) {
                    return StoryPage();
                  })));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Theme.of(context).colorScheme.onBackground,
                              child: Icon(
                                Ionicons.person,
                                color: Theme.of(context).colorScheme.background,
                                size: 40,
                              ),
                            ),
                          ),
                          index == 0
                              ? Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Icon(
                                      Icons.add,
                                      color:
                                          Theme.of(context).colorScheme.shadow,
                                      size: 20,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    index != 0
                        ? Text(
                            "Username",
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        : Text(
                            "You",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                  ],
                ),
              ));
        });
  }
}

class ThreadLayout extends StatefulWidget {
  ThreadModel thread;
  ThreadLayout({super.key, required this.thread});

  @override
  State<ThreadLayout> createState() => _ThreadLayoutState();
}

class _ThreadLayoutState extends State<ThreadLayout> {
  bool _havereplies = true;
  int replies = 0;
  bool liked = false;
  @override
  void initState() {
    if (widget.thread.commentUsers.length == 0) {
      _havereplies = false;
    } else {
      replies = widget.thread.commentUsers.length;
      

    }
    super.initState();
  }
   double updateDividerLength(String text, BuildContext context,int imageLength){
    final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 100,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 80);
      print(textPainter.computeLineMetrics().length.toString() + "cs");
      final newLineCount = (textPainter.computeLineMetrics().length*10)+((imageLength/3).ceil()*100);
      print(newLineCount);
      return newLineCount.toDouble()+80;
   }
  StatefulBuilder getThreadFooter({
    required bool isPost,
    required Function onLike,
    required Function onComment,
    required Function onSave,
  }) {
    TextEditingController postMessage = TextEditingController();
    TextEditingController search = TextEditingController();
    bool savedPost = false;
    bool isLiked = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    onLike();
                    setState(() {
                      isLiked = !isLiked;

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
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, right: 15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.horizontal_rule_rounded,
                                  size: 50,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFieldBuilder(
                                  tcontroller: postMessage,
                                  hintTexxt: "Write a message...",
                                  onChangedf: () {},
                                ),
                                const SizedBox(
                                  height: 20,
                                  child: Divider(
                                    height: 10,
                                  ),
                                ),
                                TextFieldBuilder(
                                    tcontroller: search,
                                    hintTexxt: "Search",
                                    onChangedf: () {},
                                    prefixxIcon: Icon(
                                      Ionicons.search,
                                      size: 20,
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            child: CircleAvatar(
                                                radius: 28,
                                                backgroundImage: AssetImage(
                                                  "assets/Country_flag/in.png",
                                                )),
                                          ),
                                          title: Text(
                                            "Fatima",
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
                                            "Occupation",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 14,
                                                ),
                                          ),
                                          trailing: MyEleButtonsmall(
                                              title2: "Sent",
                                              title: "Send",
                                              onPressed: () {},
                                              ctx: context),
                                        );
                                      }),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  icon: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
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
                size: 30,
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
        Divider(
          height: 0,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: ClipOval(
                child: Image.network(
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  widget.thread.user.profilePic,
                  height: 35,
                  width: 35,
                  fit: BoxFit.cover,
                ),
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
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                                  margin: EdgeInsets.only(top: 10, left: 25),
                                  height: updateDividerLength(widget.thread.content, context, widget.thread.images.length),
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.network(
                                widget.thread.images[index],
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
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
                    padding: const EdgeInsets.only(left: 25, top: 10),
                    child: getThreadFooter(
                      isPost: false,
                      onLike: () async {
                        await ThreadServices()
                            .toogleLikeThreads(threadId: widget.thread.id);
                      },
                      onComment: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const CommentPage()));
                      },
                      onSave: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          children: [
            
            if (replies == 3)
              UserProfileImageStackOf3(
                commenterProfilePics: widget.thread.commentUsers,
              )
            else if (replies == 2)
              UserProfileImageStackOf2(
                  commentUserProfilePic: widget.thread.commentUsers,
                  isShowIcon: false)
            else if (replies == 1)
              Row(
                children: [
                  SizedBox(
              width: 20,
            ),
                  ReplyUserProfileImage(
                    rightPadding: 0,
                    userProfileImagePath: widget.thread.commentUsers[0].profilePic,
                  ),
                ],
              )
            else
              SizedBox(),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThreadReply(
                                  text: 'Ad Flag Image',
                                  imageUrl: 'assets/Country_flag/ao.png',
                                )));
                  },
                  child: Text(
                    "${widget.thread.commentCount} ${widget.thread.commentCount > 1 ? "replies" : "reply"} ${widget.thread.likeCount}  ${widget.thread.likeCount > 1 ? "likes" : "like"}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8)
      ],
    );
  }
}

class UserProfileImageStackOf3 extends StatelessWidget {
  List<CommentUser>? commenterProfilePics;
  UserProfileImageStackOf3({super.key, this.commenterProfilePics});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 3),
      height: 30,
      width: 31,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: ClipOval(
              child: Image.network(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                commenterProfilePics![0].profilePic,
                fit: BoxFit.cover,
                height: 16,
                width: 16,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 10,
            child: ClipOval(
              child: Image.network(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                commenterProfilePics![1].profilePic,
                fit: BoxFit.cover,
                height: 10.5,
                width: 10.5,
              ),
            ),
          ),
          Positioned(
            right: 9.2,
            top: 21,
            child: ClipOval(
              child: Image.network(
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                commenterProfilePics![2].profilePic,
                fit: BoxFit.cover,
                height: 8.5,
                width: 8.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

StatefulBuilder getFooter({
  required bool isPost,
  required Function onLike,
  required Function onComment,
  required Function onSave,
}) {
  TextEditingController postMessage = TextEditingController();
  TextEditingController search = TextEditingController();
  bool savedPost = false;
  bool isLiked = false;
  return StatefulBuilder(
    builder: (context, setState) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  onLike();
                  setState(() {
                    isLiked = !isLiked;
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
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.horizontal_rule_rounded,
                                size: 50,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFieldBuilder(
                                tcontroller: postMessage,
                                hintTexxt: "Write a message...",
                                onChangedf: () {},
                              ),
                              const SizedBox(
                                height: 20,
                                child: Divider(
                                  height: 10,
                                ),
                              ),
                              TextFieldBuilder(
                                  tcontroller: search,
                                  hintTexxt: "Search",
                                  onChangedf: () {},
                                  prefixxIcon: Icon(
                                    Ionicons.search,
                                    size: 20,
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                  )),
                              const SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading: CircleAvatar(
                                          radius: 30,
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          child: CircleAvatar(
                                              radius: 28,
                                              backgroundImage: AssetImage(
                                                "assets/Country_flag/in.png",
                                              )),
                                        ),
                                        title: Text(
                                          "Fatima",
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
                                          "Occupation",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontSize: 14,
                                              ),
                                        ),
                                        trailing: MyEleButtonsmall(
                                            title2: "Sent",
                                            title: "Send",
                                            onPressed: () {},
                                            ctx: context),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        );
                      });
                },
                icon: Icon(
                  Ionicons.paper_plane_outline,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 30,
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
              size: 30,
            ),
          ),
        ],
      );
    },
  );
}

class PostLayout extends StatefulWidget {
  BuildContext ctx;
  PostLayout({super.key, required this.ctx});

  @override
  State<PostLayout> createState() => _PostLayoutState();
}

class _PostLayoutState extends State<PostLayout> {
  PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
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
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: MyApp.width! / 1.2,
                height: MyApp.width! / 1.2,
                child: PageView(
                  controller: pageController,
                  children: [
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                    Image.asset(
                      "assets/Country_flag/in.png",
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: SmoothPageIndicator(
                onDotClicked: (index) => pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
                controller: pageController,
                count: 3,
                effect: WormEffect(
                  activeDotColor: Theme.of(context).colorScheme.primary,
                  type: WormType.thin,
                  dotWidth: 6,
                  dotHeight: 6,
                  dotColor: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: getFooter(
            isPost: true,
            onLike: () {},
            onComment: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) => CommentPage()));
            },
            onSave: () {},
          ),
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
    allThreads = await ThreadServices().getFollowingThreads();
    setState(() {
      threadFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return threadFetched
        ? ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: allThreads.length,
            itemBuilder: (context, index) {
              return ThreadLayout(
                thread: allThreads[index],
              );
            },
          )
        : LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Colors.grey.shade700,
            minHeight: 2,
          );
  }
}

class PostViewBuilder extends StatefulWidget {
  const PostViewBuilder({super.key});

  @override
  State<PostViewBuilder> createState() => _PostViewBuilderState();
}

class _PostViewBuilderState extends State<PostViewBuilder> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return PostLayout(
          ctx: context,
        );
      },
    );
  }
}
