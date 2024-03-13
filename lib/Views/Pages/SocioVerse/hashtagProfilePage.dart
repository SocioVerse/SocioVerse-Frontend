import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Services/hashtags_services.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/material.dart';

class HashtagProfilePage extends StatefulWidget {
  String id;
  String hashTag;
  int postsCount;
  HashtagProfilePage(
      {super.key,
      required this.hashTag,
      required this.postsCount,
      required this.id});

  @override
  State<HashtagProfilePage> createState() => _HashtagProfilePageState();
}

class _HashtagProfilePageState extends State<HashtagProfilePage> {
  int __value = 1;
  int __value1 = 1;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Align(
            alignment: Alignment.topCenter,
            child: AppBar(
              title: Text(
                "#${widget.hashTag}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
              ),
              toolbarHeight: 100,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              child: Icon(
                Icons.tag,
                size: 50,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.postsCount < 100
                ? widget.postsCount <= 1
                    ? "${widget.postsCount} Post"
                    : "${widget.postsCount} Posts"
                : "${CalculatingFunction.numberToMkConverter(widget.postsCount.toDouble())} Posts",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          // SizedBox(
          //   width: MyApp.width! - 30,
          //   height: 50,
          //   child: MyEleButtonsmall(
          //     title: "Follow",
          //     title2: "Following",
          //     ctx: context,
          //     width1: double.infinity,
          //     width2: double.infinity,
          //     fontSize: 20,
          //     ispressed: false,
          //     onPressed: () {},
          //   ),
          // ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Ionicons.grid_outline,
                    size: 15,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Feeds ",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                // DropdownButton(
                //   dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                //   focusColor: Theme.of(context).scaffoldBackgroundColor,
                //   underline: const SizedBox.shrink(),
                //   value: __value1,
                //   items: [
                //     DropdownMenuItem(
                //       value: 1,
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.all(3.0),
                //             child: Icon(
                //               Ionicons.grid_outline,
                //               size: 15,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text(
                //             "Feeds ",
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyMedium!
                //                 .copyWith(
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 18,
                //                   color:
                //                       Theme.of(context).colorScheme.onPrimary,
                //                 ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     DropdownMenuItem(
                //       value: 2,
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: [
                //           const Padding(
                //             padding: EdgeInsets.all(3.0),
                //             child: Icon(
                //               Ionicons.text,
                //               size: 15,
                //             ),
                //           ),
                //           const SizedBox(
                //             width: 5,
                //           ),
                //           Text(
                //             "Threads",
                //             style: Theme.of(context)
                //                 .textTheme
                //                 .bodyMedium!
                //                 .copyWith(
                //                   fontWeight: FontWeight.w500,
                //                   fontSize: 18,
                //                   color:
                //                       Theme.of(context).colorScheme.onPrimary,
                //                 ),
                //           ),
                //         ],
                //       ),
                //     )
                //   ],
                //   onChanged: (value) {
                //     setState(() {
                //       __value1 = value as int;
                //     });
                //   },
                // ),
                const Spacer(),
                DropdownButton(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: __value,
                  padding: const EdgeInsets.all(0),
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Ionicons.time_outline,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            "Recent",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Ionicons.trending_up,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Text(
                            "Top",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 15,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      __value = value as int;
                    });
                  },
                ),
              ],
            ),
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SpinKit.ring,
                );
              }
              List<FeedThumbnail> feedThumbnail =
                  snapshot.data as List<FeedThumbnail>;
              return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  itemCount: feedThumbnail.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Positioned.fill(
                          child: RoundedNetworkImageWithLoading(
                            imageUrl: feedThumbnail[index].images[0],
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: RoundedNetworkImageWithLoading(
                                imageUrl:
                                    feedThumbnail[index].userId.profilePic,
                                borderRadius: 5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
            },
            future: HashtagsServices().getHashtagsFeed(
                tagId: widget.id, isRecent: __value == 1 ? true : false),
          ),
        ]),
      ),
    ));
  }
}
