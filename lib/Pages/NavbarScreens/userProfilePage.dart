import 'dart:developer';

import 'package:socioverse/Pages/SettingsPages/settings.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import '../../Widgets/buttons.dart';

class UserProfilePage extends StatefulWidget {
  bool? owner;
  UserProfilePage({super.key, this.owner});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Widget modifiedContainer(
      {required String upperText, required String lowerText}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            upperText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            lowerText,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }

  TextField textFieldBuilder({
    required TextEditingController tcontroller,
    required String hintTexxt,
    required Function onChangedf,
    Widget? prefixxIcon,
  }) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
      },
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: prefixxIcon,
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintTexxt,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
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
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
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
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.remove_circle),
                title: Text(
                  'Block',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.shield_outline),
                title: Text(
                  'Restrict',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.copy_outline),
                title: Text(
                  'Copy Profile Link',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.send),
                title: Text(
                  'Share this Profile',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
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
                              textFieldBuilder(
                                tcontroller: TextEditingController(),
                                hintTexxt: "Write a message...",
                                onChangedf: () {},
                              ),
                              const SizedBox(
                                height: 20,
                                child: Divider(
                                  height: 10,
                                ),
                              ),
                              textFieldBuilder(
                                  tcontroller: TextEditingController(),
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
              ),
              ListTile(
                leading: new Icon(Ionicons.eye_off_outline),
                title: Text(
                  'Hide Your Story',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void isOwner() {
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
                  Ionicons.settings,
                  color: Colors.white,
                ),
                title: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: ((context) => ProfileSettings())));
                },
              ),
              ListTile(
                leading: Icon(Ionicons.archive),
                title: Text(
                  'Archive',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.bookmark_outline),
                title: Text(
                  'Saved',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.heart),
                title: Text(
                  'Liked Post',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: Icon(Ionicons.share),
                title: Text(
                  'Share this Profile',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
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
                              textFieldBuilder(
                                tcontroller: TextEditingController(),
                                hintTexxt: "Write a message...",
                                onChangedf: () {},
                              ),
                              const SizedBox(
                                height: 20,
                                child: Divider(
                                  height: 10,
                                ),
                              ),
                              textFieldBuilder(
                                  tcontroller: TextEditingController(),
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
              ),
              ListTile(
                leading: new Icon(Ionicons.log_out_outline),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AppBar(
                  title: Text(
                    "amj24",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                        ),
                  ),
                  toolbarHeight: 70,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                  actions: [
                    IconButton(
                      onPressed: () {
                        if (widget.owner == true) {
                          log("here ");
                          isOwner();
                        } else {
                          isNotOwner();
                        }
                      },
                      icon: Icon(
                        Ionicons.ellipsis_horizontal_circle_outline,
                        size: 25,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 75,
                      backgroundColor:
                          Theme.of(context).colorScheme.onBackground,
                      child: Icon(
                        Ionicons.person,
                        color: Theme.of(context).colorScheme.background,
                        size: 50,
                      ),
                    ),
                    widget.owner == true
                        ? Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.shadow,
                                size: 20,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Kunal Jain",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "occupation",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Officia sit culpa aute magna occaecat in. Eiusmod tempor non ex in deserunt proident cillum nulla qui elit. Officia irure magna sunt officia id mollit qui elit consequat. Excepteur ea duis pariatur esse eiusmod ex sunt deserunt tempor esse. Sit anim anim esse sint magna do nulla quis non pariatur mollit eiusmod.",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "www.amj24.com",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.blue),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    modifiedContainer(
                      upperText: "267",
                      lowerText: "Posts",
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.tertiary,
                      thickness: 1,
                      width: 30,
                    ),
                    modifiedContainer(
                      upperText: "24,274",
                      lowerText: "Followers",
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.tertiary,
                      thickness: 1,
                      width: 30,
                    ),
                    modifiedContainer(
                      upperText: "237",
                      lowerText: "Following",
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              widget.owner == true
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MyEleButtonsmall(
                            iconButton1: IconButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Ionicons.person_add,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                )),
                            iconButton2: IconButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.done,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            width1: 160,
                            width2: 160,
                            title: "Follow",
                            title2: "Following",
                            onPressed: () {},
                            fontSize: 16,
                            ctx: context,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: CustomOutlineButton(
                            iconButton1: IconButton(
                                onPressed: () {},
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Ionicons.chatbox_ellipses,
                                  color: Theme.of(context).colorScheme.primary,
                                )),
                            width1: 160,
                            title: "Message",
                            onPressed: () {},
                            fontSize: 16,
                            ctx: context,
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 30,
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.grid_outline,
                                  size: 20,
                                ),
                                SizedBox(
                                    width:
                                        5), // Add spacing between icon and text
                                Text("Feeds"),
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.people_circle_outline,
                                  size: 20,
                                ),
                                SizedBox(
                                    width:
                                        5), // Add spacing between icon and text
                                Text("Tag"),
                              ],
                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}
