import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:socioverse/Utils/calculatingFunctions.dart';
import 'package:socioverse/Widgets/buttons.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/material.dart';

class HashtagProfilePage extends StatefulWidget {
  String hashTag;
  double postsCount;
  HashtagProfilePage(
      {super.key, required this.hashTag, required this.postsCount});

  @override
  State<HashtagProfilePage> createState() => _HashtagProfilePageState();
}

class _HashtagProfilePageState extends State<HashtagProfilePage> {
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
          SizedBox(
            height: 40,
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Theme.of(context).colorScheme.onBackground,
            child: const Icon(
              Icons.person,
              size: 70,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "${CalculatingFunction.numberToBMKonverter(widget.postsCount)} posts",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: MyApp.width! - 30,
            height: 50,
            child: MyEleButtonsmall(
              title: "Follow",
              title2: "Following",
              ctx: context,
              width1: double.infinity,
              width2: double.infinity,
              fontSize: 20,
              ispressed: false,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 40,
          ),
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onPrimary,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    tabs: const [
                      Tab(
                        child: Text("Top"),
                      ),
                      Tab(
                        child: Text("Recent"),
                      )
                    ],
                  ),
                  AutoScaleTabBarView(
                    children: [
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1,
                          ),
                          itemCount: 100,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/Country_flag/in.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                      GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/Country_flag/in.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ],
              )),
        ]),
      ),
    ));
  }
}
