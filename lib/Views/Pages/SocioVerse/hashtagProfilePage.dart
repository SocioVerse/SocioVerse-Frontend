import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Utils/calculatingFunctions.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/material.dart';

class HashtagProfilePage extends StatefulWidget {
  String hashTag;
  int postsCount;
  HashtagProfilePage(
      {super.key, required this.hashTag, required this.postsCount});

  @override
  State<HashtagProfilePage> createState() => _HashtagProfilePageState();
}

class _HashtagProfilePageState extends State<HashtagProfilePage> {
  int __value = 1;
  int __value1 = 1;
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
              children: [
                DropdownButton(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  focusColor: Theme.of(context).scaffoldBackgroundColor,
                  underline: const SizedBox.shrink(),
                  value: __value1,
                  items: [
                    DropdownMenuItem(
                      value: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Ionicons.text,
                              size: 15,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Threads",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ],
                      ),
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      __value1 = value as int;
                    });
                  },
                ),
                const Spacer(),
                DropdownButton(
                  dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                  value: __value,
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
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/Country_flag/in.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ]),
      ),
    ));
  }
}
