import 'dart:developer';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Followers/followerPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Following/followingPage.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileServices.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileWidgets.dart';
import 'package:socioverse/Views/Pages/SocioThread/NewThread/newThread.dart';

import 'package:socioverse/Views/Pages/SettingsPages/settings.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import '../../../Widgets/buttons.dart';

class UserProfilePage extends StatefulWidget {
  bool? owner;
  UserProfilePage({super.key, this.owner});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  TextEditingController bioController = TextEditingController();

   UserProfileDetailsModel? userProfileDetailsModel;
  bool isLoading = false;
  @override
  void initState() {
    getUserProfileDetails();
    super.initState();
  }
  getUserProfileDetails() async {
    setState(() {
      isLoading = true;
    });
    userProfileDetailsModel = await UserProfileDetailsServices().fetchUserProfileDetails(null);
    setState(() {
      isLoading = false;
    });
  }





  Widget modifiedContainer(
      {required String upperText, required String lowerText,
      required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Center(
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

  

  bool _isExtended = true;
  bool _haveReplies = true;
  final List<String> extendedReplies = [
    'Extended Reply 1',
    'Extended Reply 2',
    'Extended Reply 3',
    'Extended Reply 4',
  ];

  Widget buildExtendedReplies() {
    return ListView.builder(
      itemCount: _isExtended ? extendedReplies.length : 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/Country_flag/ad.png',
                          height: 35,
                          width: 35,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 70,
                    width: 2,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 81,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'lepan1m',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Text('41 m'),
                                SizedBox(width: 10),
                                Icon(Icons.more_horiz),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Text('Nice Flag'),
                    SizedBox(height: 13),
                    Container(
                      width: 135,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.favorite_border_rounded,
                            size: 23,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewThread()));
                            },
                            child: Icon(
                              Icons.mode_comment_outlined,
                              size: 23,
                            ),
                          ),
                          Icon(
                            Icons.reply_all_sharp,
                            size: 23,
                          ),
                          Icon(
                            Icons.share,
                            size: 23,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Text(
                          '2 replies ',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          '• 78 likes',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
void isOwner({required BuildContext context}) {
    showModalBottomSheet(
      
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
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
                leading: const Icon(Ionicons.archive, color: Colors.white,
                ),
                title: Text(
                  'Archive',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading:const Icon(Ionicons.bookmark_outline ,color: Colors.white,
                ),
                title: Text(
                  'Saved',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading:const  Icon(Ionicons.heart, color: Colors.white,
                ),
                title: Text(
                  'Liked Post',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {},
              ),
              ListTile(
                leading: const  Icon(Ionicons.share, color: Colors.white,
                ),
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
                leading: const  Icon(Ionicons.log_out_outline, color: Colors.white,
                ),
                title: Text(
                  'Log Out',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 16),
                ),
                onTap: () {
                  AlertBoxes.acceptRejectAlertBox(
                    context: context,
                    title: "Log Out",
                    
                    content: Text(" Are you sure you want to log out?"),
                    onAccept: () async {
                      setStringIntoCache(
                          SharedPreferenceString.accessToken, null);

                      setBooleanIntoCache(
                          SharedPreferenceString.isLoggedIn, false);

                      setStringIntoCache(
                          SharedPreferenceString.refreshToken, null);
  Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                          (route) => false);
                    },
                    onReject: () {
                    },
                  );
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      isLoading
          ? const Center(
              child: SpinKitWave(
                  color: Colors.white, type: SpinKitWaveType.center),
            )
          :
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AppBar(
                  title: Text(
                    userProfileDetailsModel!.user.username,
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
                          isOwner(
                            context: context,
                          );
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
                      child: CircularNetworkImageWithoutSize(
  imageUrl: userProfileDetailsModel!.user.profilePic,
  fit: BoxFit.cover,
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
                userProfileDetailsModel!.user.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                    ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                userProfileDetailsModel!.user.occupation,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              userProfileDetailsModel!.user.bio == null 
                  ? widget.owner != true ? const SizedBox.shrink():TextButton(
        onPressed: () {
          AlertBoxes.acceptRejectAlertBox(
              context: context,
              title: "Add Bio",
              onAccept: () async {
                if(bioController.text.trim()!="") {
                  await UserProfileDetailsServices().addBio( bioController.text);
                  setState(() {
                    userProfileDetailsModel!.user.bio = bioController.text;
                  });
                  
                }
              },
              onReject: () {},
              content: SizedBox(
                width: 100,

                child: TextFormField(
                  controller: bioController,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                      ),
                  
                  decoration: InputDecoration(
                    hintText: "Write your bio here...",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 13,
                        ),
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
                ),
              ),
              acceptTitle: "Add",
              rejectTitle: "Cancel");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Ionicons.add_circle,
              color: Theme.of(context).colorScheme.primary,
              size: 22,
            ),
            SizedBox(
              width: 7,
            ),
            Text("Add Bio",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary))
          ],
        ))
                  :
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ExpandableTextWidget(text: userProfileDetailsModel!.user.bio!,
                maxLines: 3,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "www.amj24.com",
              //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
              //       fontWeight: FontWeight.w600,
              //       fontSize: 18,
              //       color: Colors.blue),
              // ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    modifiedContainer(
                      onTap: (){
                      },
                      upperText: userProfileDetailsModel!.user.postCount.toString(),
                      lowerText: "Post${userProfileDetailsModel!.user.postCount>1?"s":""}",
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.tertiary,
                      thickness: 1,
                      width: 30,
                    ),
                    modifiedContainer(

                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowersPage()));
                      },
                      upperText: userProfileDetailsModel!.user.followersCount.toString(),
                      lowerText: "Follower${userProfileDetailsModel!.user.followersCount>1?"s":""}",
                    ),
                    VerticalDivider(
                      color: Theme.of(context).colorScheme.tertiary,
                      thickness: 1,
                      width: 30,
                    ),
                    modifiedContainer(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FollowingPage()));
                      },
                      upperText: userProfileDetailsModel!.user.followingCount.toString(),
                      lowerText: "Following${userProfileDetailsModel!.user.followingCount>1?"s":""}",
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
                  length: 3,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: Theme.of(context).colorScheme.primary,
                        unselectedLabelColor:
                            Theme.of(context).colorScheme.onPrimary,
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        automaticIndicatorColorAdjustment: true,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 3,
                        dividerColor: Theme.of(context).colorScheme.onPrimary,

                        tabs: const [
                          Tab(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Ionicons.text,
                                  size: 20,
                                ),
                                SizedBox(
                                    width:
                                        5), // Add spacing between icon and text
                                Text("Threads"),
                              ],
                            ),
                          ),
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
                                  Ionicons.repeat_outline,
                                  size: 20,
                                ),
                                SizedBox(
                                    width:
                                        5), // Add spacing between icon and text
                                Text("Reposted"),
                              ],
                            ),
                          ),
                        ],
                      ),
                      AutoScaleTabBarView(
                        children: [
                          ThreadViewBuilder(
                            allThreads: userProfileDetailsModel!.threadsWithUserDetails,
                          
                          )
                          ,
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