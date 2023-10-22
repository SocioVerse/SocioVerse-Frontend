
import 'package:socioverse/Views/Pages/SocioVerse/commentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/storyPage.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
  const ThreadLayout({super.key});

  @override
  State<ThreadLayout> createState() => _ThreadLayoutState();
}

class _ThreadLayoutState extends State<ThreadLayout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: 10,
          color: Theme.of(context).colorScheme.tertiary,
        ),
        ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: Icon(
              Ionicons.person,
              color: Theme.of(context).colorScheme.background,
              size: 20,
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
        Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget nunc vitae tortor aliquam aliquet. Sed euismod, nisl eget aliquam ultricies, nisl nisl aliquet nisl, vitae aliquam nisl nisl vitae nisl. Nulla eget nunc vitae tortor aliquam aliquet. Sed euismod, nisl eget aliquam ultricies, nisl nisl aliquet nisl, vitae aliquam nisl nisl vitae nisl.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50, top: 10),
          child: getFooter(isPost: false),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 50, top: 10, bottom: 20),
            child: Text(
              "467 replies 368 likes",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
            ),
          ),
        )
      ],
    );
  }
}

StatefulBuilder getFooter({required bool isPost}) {
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
                  Navigator.push(context,
                      CupertinoPageRoute(builder: ((context) {
                    return CommentPage();
                  })));
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
          child: getFooter(isPost: true),
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
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ThreadLayout();
      },
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
