import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/threadReply.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/Services/thread_services.dart';

// class ThreadLayout extends StatefulWidget {
//   final ThreadModel thread;
//   ThreadLayout({super.key, required this.thread});

//   @override
//   State<ThreadLayout> createState() => _ThreadLayoutState();
// }

// class _ThreadLayoutState extends State<ThreadLayout> {
//   bool _havereplies = true;
//   int replies = 0;
//   bool liked = false;
//   @override
//   void initState() {
//     if (widget.thread.commentUsers.length == 0) {
//       _havereplies = false;
//     } else {
//       replies = widget.thread.commentUsers.length;
//     }
//     super.initState();
//   }

//   //  double updateDividerLength(String text, BuildContext context,int imageLength){
//   //   final textPainter = TextPainter(
//   //       text: TextSpan(
//   //         text: text,
//   //         style: TextStyle(fontSize: 16),
//   //       ),
//   //       textDirection: TextDirection.ltr,
//   //       maxLines: 100,
//   //     );
//   //     textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 80);
//   //     print(textPainter.computeLineMetrics().length.toString() + "cs");
//   //     final newLineCount = (textPainter.computeLineMetrics().length*10)+((imageLength/3).ceil()*100);
//   //     print(newLineCount);
//   //     return newLineCount.toDouble()+80;
//   //  }
//   StatefulBuilder getThreadFooter({
//     required bool isPost,
//     required Function onLike,
//     required Function onComment,
//     required Function onSave,
//   }) {
//     TextEditingController postMessage = TextEditingController();
//     TextEditingController search = TextEditingController();
//     bool savedPost = false;
//     bool isLiked = widget.thread.isLiked!;
//     return StatefulBuilder(
//       builder: (context, setState) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     onLike();
//                     setState(() {
//                       isLiked = !isLiked;
//                       widget.thread.isLiked = isLiked;

//                       if (isLiked) {
//                         widget.thread.likeCount++;
//                       } else {
//                         widget.thread.likeCount--;
//                       }
//                     });
//                   },
//                   icon: Icon(
//                     isLiked ? Ionicons.heart : Ionicons.heart_outline,
//                     color: isLiked
//                         ? Theme.of(context).colorScheme.primary
//                         : Theme.of(context).colorScheme.onPrimary,
//                     size: 30,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     onComment();
//                   },
//                   icon: Icon(
//                     Ionicons.chatbubble_outline,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     size: 30,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     showModalBottomSheet(
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                         ),
//                         backgroundColor:
//                             Theme.of(context).scaffoldBackgroundColor,
//                         context: context,
//                         builder: (context) {
//                           return Padding(
//                             padding:
//                                 const EdgeInsets.only(left: 15.0, right: 15),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Icon(
//                                   Icons.horizontal_rule_rounded,
//                                   size: 50,
//                                   color:
//                                       Theme.of(context).colorScheme.secondary,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 TextFieldBuilder(
//                                   tcontroller: postMessage,
//                                   hintTexxt: "Write a message...",
//                                   onChangedf: () {},
//                                 ),
//                                 const SizedBox(
//                                   height: 20,
//                                   child: Divider(
//                                     height: 10,
//                                   ),
//                                 ),
//                                 TextFieldBuilder(
//                                     tcontroller: search,
//                                     hintTexxt: "Search",
//                                     onChangedf: () {},
//                                     prefixxIcon: Icon(
//                                       Ionicons.search,
//                                       size: 20,
//                                       color:
//                                           Theme.of(context).colorScheme.surface,
//                                     )),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Expanded(
//                                   child: ListView.builder(
//                                       shrinkWrap: true,
//                                       itemCount: 10,
//                                       itemBuilder: (context, index) {
//                                         return ListTile(
//                                           leading: CircleAvatar(
//                                             radius: 30,
//                                             backgroundColor: Theme.of(context)
//                                                 .colorScheme
//                                                 .secondary,
//                                             child: CircleAvatar(
//                                                 radius: 28,
//                                                 backgroundImage: AssetImage(
//                                                   "assets/Country_flag/in.png",
//                                                 )),
//                                           ),
//                                           title: Text(
//                                             "Fatima",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyMedium!
//                                                 .copyWith(
//                                                   fontSize: 16,
//                                                   color: Theme.of(context)
//                                                       .colorScheme
//                                                       .onPrimary,
//                                                 ),
//                                           ),
//                                           subtitle: Text(
//                                             "Occupation",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodySmall!
//                                                 .copyWith(
//                                                   fontSize: 14,
//                                                 ),
//                                           ),
//                                           trailing: MyEleButtonsmall(
//                                               title2: "Sent",
//                                               title: "Send",
//                                               onPressed: () {},
//                                               ctx: context),
//                                         );
//                                       }),
//                                 ),
//                               ],
//                             ),
//                           );
//                         });
//                   },
//                   icon: Icon(
//                     Ionicons.paper_plane_outline,
//                     color: Theme.of(context).colorScheme.onPrimary,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//             // IconButton(
//             //   onPressed: () {
//             //     setState(() {
//             //       savedPost = !savedPost;
//             //     });
//             //     onSave();
//             //   },
//             //   icon: Icon(
//             //     savedPost ? Ionicons.bookmark : Ionicons.bookmark_outline,
//             //     color: Theme.of(context).colorScheme.onPrimary,
//             //     size: 30,
//             //   ),
//             // ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>  UserProfilePage(
//                       userId : widget.thread.user.id,
//                     )));
//           },
//           contentPadding: EdgeInsets.zero,
//           leading: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: 40,
//               width: 40,
//               child: CircularNetworkImageWithSize(
//                 imageUrl: widget.thread.user.profilePic,
//                 height: 35,
//                 width: 35,
//               ),
//             ),
//           ),
//           title: Text(
//             widget.thread.user.username,
//             style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).colorScheme.onPrimary),
//           ),
//           subtitle: Text(
//             widget.thread.user.occupation,
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//           trailing: IconButton(
//             onPressed: () {},
//             icon: Icon(
//               Ionicons.ellipsis_horizontal_circle_outline,
//               color: Theme.of(context).colorScheme.onPrimary,
//             ),
//           ),
//         ),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.thread.content,
//                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                           fontSize: 16,
//                           color: Theme.of(context).colorScheme.onPrimary,
//                         ),
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   GridView.builder(
//                     shrinkWrap: true,
//                     itemCount: widget.thread.images.length,
//                     physics: NeverScrollableScrollPhysics(),
//                     gridDelegate:
//                         const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 3,
//                       crossAxisSpacing: 5,
//                       mainAxisSpacing: 5,
//                     ),
//                     itemBuilder: (context, index) {
//                       return RoundedNetworkImageWithLoading(
//                         imageUrl: widget.thread.images[index],
//                         borderRadius: 5, // Set the desired border radius
//                         fit: BoxFit.cover,
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             getThreadFooter(
//               isPost: false,
//               onLike: () async {
//                 await ThreadServices()
//                     .toogleLikeThreads(threadId: widget.thread.id);

//                 setState(() {});
//               },
//               onComment: () {
//                 Navigator.push(
//                     context,
//                     CupertinoPageRoute(
//                         builder: (context) => ThreadCommentPage(
//                               threadModel: widget.thread,
//                             )));
//               },
//               onSave: () {},
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             if (replies == 3)
//               UserProfileImageStackOf3(
//                 commenterProfilePics: widget.thread.commentUsers,
//               )
//             else if (replies == 2)
//               UserProfileImageStackOf2(
//                   commentUserProfilePic: widget.thread.commentUsers,
//                   isShowIcon: false)
//             else if (replies == 1)
//               Row(
//                 children: [
//                   const SizedBox(
//                     width: 8,
//                   ),
//                   ReplyUserProfileImage(
//                     rightPadding: 0,
//                     userProfileImagePath:
//                         widget.thread.commentUsers[0].profilePic,
//                   ),
//                 ],
//               )
//             else
//               SizedBox(),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const ThreadReply(
//                                 text: 'Ad Flag Image',
//                                 imageUrl: 'assets/Country_flag/ao.png',
//                               )));
//                 },
//                 child: Text(
//                   "${widget.thread.commentCount} ${widget.thread.commentCount > 1 ? "replies" : "reply"} • ${widget.thread.likeCount} ${widget.thread.likeCount > 1 ? "likes" : "like"}",
//                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         fontSize: 14,
//                         color: Theme.of(context).colorScheme.tertiary,
//                       ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(height: 8),
//         Divider(
//           height: 0,
//           color: Theme.of(context).colorScheme.tertiary,
//         ),
//       ],
//     );
//   }
// }

class ThreadViewBuilder extends StatefulWidget {
  final List<ThreadModel> allThreads;
  bool shrinkWrap = false;
  ThreadViewBuilder({required this.allThreads, this.shrinkWrap = false});

  @override
  State<ThreadViewBuilder> createState() => _ThreadViewBuilderState();
}

class _ThreadViewBuilderState extends State<ThreadViewBuilder> {
  bool threadFetched = false;
  List<ThreadModel> allThreads = [];
  @override
  void initState() {
    allThreads = widget.allThreads;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return allThreads.isEmpty
        ? const NoPostYet()
        : Container(
            child: ListView.builder(
              physics: widget.shrinkWrap
                  ? const NeverScrollableScrollPhysics()
                  : const ClampingScrollPhysics(),
              shrinkWrap: widget.shrinkWrap,
              padding: const EdgeInsets.only(top: 10),
              itemCount: allThreads.length,
              itemBuilder: (context, index) {
                return ThreadLayout(
                  thread: allThreads[index],
                );
              },
            ),
          );
  }
}

class NoPostYet extends StatelessWidget {
  const NoPostYet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt_outlined,
            size: 70,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "No posts yet",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ],
      ),
    );
  }
}

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  final int maxLines;

  const ExpandableTextWidget({
    Key? key,
    required this.text,
    this.maxLines = 2,
  }) : super(key: key);

  @override
  _ExpandableTextWidgetState createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  bool isExpanded = false;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AnimatedCrossFade(
          duration: Duration(milliseconds: 300),
          firstChild: Text(
            widget.text,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
            maxLines: isExpanded ? null : widget.maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
          secondChild: GestureDetector(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              widget.text,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        ),
        if (!isExpanded)
          Align(
            alignment: Alignment.bottomCenter,
            child: TextButton(
              onPressed: () {
                setState(() {
                  isExpanded = true;
                });
              },
              child: Text('Read More'),
            ),
          ),
      ],
    );
  }
}
