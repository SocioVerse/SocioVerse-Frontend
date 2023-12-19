import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/addCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioThread/threadReply.dart';
import 'package:socioverse/Views/Pages/SocioThread/widgets.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/Global/loadingOverlay.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/main.dart';
import 'package:socioverse/services/thread_services.dart';


class UserProfileImageStackOf2 extends StatelessWidget {
  List<CommentUser>? commentUserProfilePic;

  final bool isShowIcon;

  UserProfileImageStackOf2({
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
            rightPadding: 10.5,
            userProfileImagePath: commentUserProfilePic![0].profilePic,
          ),
          ReplyUserProfileImage(
            rightPadding: 0.5,
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
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 18.5,
                    ),
                  ),
                )
              : SizedBox(),
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
    return rightPadding ==0 ? Container(
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

        
      ):
     Positioned(
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
   ThreadLayout({super.key, required this.thread,this.isComment = false});

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
  StatefulBuilder getThreadFooter({
    required bool isPost,
    required Function onLike,
    required Function onComment,
    required Function onSave,
  }) {
    TextEditingController postMessage = TextEditingController();
    TextEditingController search = TextEditingController();
    bool savedPost = false;
    bool isLiked = liked;
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [ 
            Row(
              children: [
                InkWell(
                  onTap: () {
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
                  child: Icon(
                    isLiked ? Ionicons.heart : Ionicons.heart_outline,
                    color: isLiked
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),const  SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    onComment();
                  },
                  child: Icon(
                    Ionicons.chatbubble_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
               const  SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
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
                                            child: const CircleAvatar(
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
                  child: Icon(
                    Ionicons.paper_plane_outline,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 30,
                  ),
                ),
              ],
            ),
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       savedPost = !savedPost;
            //     });
            //     onSave();
            //   },
            //   icon: Icon(
            //     savedPost ? Ionicons.bookmark : Ionicons.bookmark_outline,
            //     color: Theme.of(context).colorScheme.onPrimary,
            //     size: 30,
            //   ),
            // ),
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
            await getStringFromCache(SharedPreferenceString.userId).then((value) => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) =>  LoadingOverlayAlt(
                      child: UserProfilePage(
                        owner: value == widget.thread.user.id,
                        userId: widget.thread.user.id,
                      ),
                    ))));
                
          },
          contentPadding: EdgeInsets.zero,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularNetworkImageWithLoading(
  imageUrl: widget.thread.user.profilePic,
  height: 35,
  width:35,
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
          children: [
           widget.isComment ? const SizedBox.shrink(): const SizedBox(
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
                        widget.thread.images.length == 0
                            ? const SizedBox.shrink()
                            :
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
                          .toogleLikeThreads(threadId: widget.thread.id);
              
                      setState(() {
                      });
                    },
                    onComment: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>  LoadingOverlayAlt(
                                child: AddCommentPage(
                                  thread : widget.thread,
                                ),
                              )));
                    },
                    onSave: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        

                    Row(
                      children: [
                       widget.isComment?SizedBox.shrink(): SizedBox(
  width: 60,
  child: replies == 3
      ? Center(
        child: UserProfileImageStackOf3(
            commenterProfilePics: widget.thread.commentUsers,
          ),
      )
      : replies == 2
          ? UserProfileImageStackOf2(
              commentUserProfilePic: widget.thread.commentUsers,
              isShowIcon: false,
            )
          : replies == 1
              ? Center(
                child: ReplyUserProfileImage(
                    rightPadding: 0,
                    userProfileImagePath:
                        widget.thread.commentUsers[0].profilePic,
                  ),
              )
              : Container(), // Provide a default empty container for other cases
),
                        TextButton(
                                 onPressed: () {
                                   Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                           builder: (context) =>  ThreadCommentPage(
                                        
                             threadModel : widget.thread,
                           ) ));
                                 },
                                 child: Text(
                                   "${widget.thread.commentCount} ${widget.thread.commentCount > 1 ? "replies" : "reply"} • ${widget.thread.likeCount} ${widget.thread.likeCount > 1 ? "likes" : "like"}",
                                   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                         fontSize: 14,
                                         color: Theme.of(context).colorScheme.tertiary,
                                       ),
                                 ),
                        ),
                      ],
                    ),
        SizedBox(height: 8),
        Divider(
          height: 0,
          thickness: 0.2,
          color: Theme.of(context).colorScheme.tertiary,
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
        ? allThreads.isEmpty ?
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AllCaughtUp(),
            ],
          ),
        ) :
        ListView.builder(
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
        : const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitWave(
                  color: Colors.white, type: SpinKitWaveType.center),
            ],
          ),
        );
  }
}
class AllCaughtUp extends StatelessWidget {
  const AllCaughtUp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
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