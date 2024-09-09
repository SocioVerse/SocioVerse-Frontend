// ListView.builder(
//                             itemCount: 4,
//                             shrinkWrap: true,
//                             physics:
//                                 NeverScrollableScrollPhysics(), // Disable inner ListView scrolling
//                             itemBuilder: (context, index) {
//                               return Column(
//                                 children: [
//                                   Column(
//                                     children: [
//                                       Divider(thickness: 0.5),
//                                       Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 0, vertical: 5),
//                                         child: Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Column(
//                                               children: [
//                                                 Stack(
//                                                   children: [
//                                                     ClipOval(
//                                                       child: Image.asset(
//                                                         'assets/Country_flag/ad.png',
//                                                         height: 35,
//                                                         width: 35,
//                                                         fit: BoxFit.cover,
//                                                       ),
//                                                     ),
//                                                     Positioned(
//                                                       right: 0,
//                                                       bottom: 0,
//                                                       child: Container(
//                                                         height: 16,
//                                                         width: 16,
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: Colors.white,
//                                                           borderRadius:
//                                                               BorderRadius
//                                                                   .circular(10),
//                                                           border: Border.all(
//                                                             color: Colors.black,
//                                                           ),
//                                                         ),
//                                                         child: Icon(
//                                                           Icons.add,
//                                                           size: 15,
//                                                           color: Colors.black,
//                                                         ),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                                 Container(
//                                                   margin: EdgeInsets.symmetric(
//                                                       vertical: 10),
//                                                   height: 38,
//                                                   width: 2,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey.shade700,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             3),
//                                                   ),
//                                                 ),
//                                                 _haveReplies
//                                                     ? GestureDetector(
//                                                         onTap: () {
//                                                           setState(() {
//                                                             _isExtended =
//                                                                 !_isExtended;
//                                                           });
//                                                         },
//                                                         child: Container(
//                                                           height: 20,
//                                                           width: 41,
//                                                           child: Stack(
//                                                             children: [
//                                                               Positioned(
//                                                                 right: 20.5,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       color: Colors
//                                                                           .black87,
//                                                                       width: 2,
//                                                                     ),
//                                                                   ),
//                                                                   child:
//                                                                       ClipOval(
//                                                                     child: Image
//                                                                         .asset(
//                                                                       'assets/Country_flag/ad.png',
//                                                                       fit: BoxFit
//                                                                           .fill,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Positioned(
//                                                                 right: 10.5,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       width: 2,
//                                                                       color: Colors
//                                                                           .black87,
//                                                                     ),
//                                                                   ),
//                                                                   child:
//                                                                       ClipOval(
//                                                                     child: Image
//                                                                         .asset(
//                                                                       'assets/Country_flag/ad.png',
//                                                                       fit: BoxFit
//                                                                           .fill,
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               Positioned(
//                                                                 right: 0,
//                                                                 child:
//                                                                     Container(
//                                                                   height: 20,
//                                                                   width: 20,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                     color: Colors
//                                                                         .white,
//                                                                     borderRadius:
//                                                                         BorderRadius.circular(
//                                                                             10),
//                                                                     border:
//                                                                         Border
//                                                                             .all(
//                                                                       width: 2,
//                                                                       color: Colors
//                                                                           .black87,
//                                                                     ),
//                                                                   ),
//                                                                   child: Icon(
//                                                                     Icons
//                                                                         .arrow_drop_down,
//                                                                     color: Colors
//                                                                         .black,
//                                                                     size: 18.5,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       )
//                                                     : SizedBox(height: 0),
//                                               ],
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   EdgeInsets.only(left: 10),
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   SizedBox(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width -
//                                                             81,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Text(
//                                                           'lepan1m',
//                                                           style: TextStyle(
//                                                             color: Colors.white,
//                                                             fontWeight:
//                                                                 FontWeight.w700,
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           child: Row(
//                                                             children: [
//                                                               Text('41 m'),
//                                                               SizedBox(
//                                                                   width: 10),
//                                                               Icon(Icons
//                                                                   .more_horiz),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 3),
//                                                   Text('Nice Flag'),
//                                                   SizedBox(height: 13),
//                                                   Container(
//                                                     width: 135,
//                                                     child: Row(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                       children: [
//                                                         Icon(
//                                                           Icons
//                                                               .favorite_border_rounded,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons
//                                                               .mode_comment_outlined,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons.reply_all_sharp,
//                                                           size: 23,
//                                                         ),
//                                                         Icon(
//                                                           Icons.share,
//                                                           size: 23,
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   SizedBox(height: 15),
//                                                   Row(
//                                                     children: [
//                                                       Text(
//                                                         '2 replies ',
//                                                         style: TextStyle(
//                                                           color: Colors
//                                                               .grey.shade600,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         '• 78 likes',
//                                                         style: TextStyle(
//                                                           color: Colors
//                                                               .grey.shade600,
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (_isExtended)
//                                         Container(
//                                             width: MediaQuery.of(context)
//                                                 .size
//                                                 .width,
//                                             child: buildExtendedReplies()),
//                                     ],
//                                   ),
//                                 ],
//                               );
//                             },
//                           )





// import 'dart:developer';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:provider/provider.dart';
// import 'package:socioverse/Models/feedModel.dart';
// import 'package:socioverse/Models/threadModel.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Followers/followerPage.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Following/followingPage.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Liked/likedPage.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/Saved/savedPage.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/updateProfilePage.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileServices.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileWidgets.dart';
// import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThread.dart';

// import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/UserProfileSettings/settings.dart';
// import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatPage.dart';
// import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
// import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
// import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
// import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
// import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
// import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
// import 'package:socioverse/main.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:ionicons/ionicons.dart';
// import 'package:socioverse/Views/Pages/SocioVerse/Inbox/inboxModel.dart'
//     as inboxModel;
// import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
// import 'package:socioverse/Services/authentication_services.dart';
// import 'package:socioverse/Services/follow_unfollow_services.dart';
// import '../../../Widgets/buttons.dart';

// class UserProfilePage extends StatefulWidget {
//   final bool? owner;
//   final String? userId;
//   UserProfilePage({super.key, this.owner, this.userId});

//   @override
//   State<UserProfilePage> createState() => _UserProfilePageState();
// }

// class _UserProfilePageState extends State<UserProfilePage>
//     with TickerProviderStateMixin {
//   TextEditingController bioController = TextEditingController();

//   UserProfileDetailsModel? userProfileDetailsModel;
//   late TabController _tabController;
//   late ScrollController _scrollController;
//   bool fixedScroll = false;
//   bool isLoading = false;
//   bool isRepostsLoading = false;
//   Key _refreshKey = UniqueKey();
//   @override
//   void initState() {
//     _scrollController = ScrollController();
//     _scrollController.addListener(_scrollListener);
//     _tabController = TabController(length: 3, vsync: this);
//     _tabController.addListener(_smoothScrollToTop);
//     getUserProfileDetails();
//     super.initState();
//   }

//   _scrollListener() {}

//   _smoothScrollToTop() {
//     _scrollController.animateTo(
//       0,
//       duration: const Duration(microseconds: 300),
//       curve: Curves.ease,
//     );

//     setState(() {
//       fixedScroll = _tabController.index == 2;
//     });
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   getUserProfileDetails() async {
//     setState(() {
//       isLoading = true;
//     });
//     userProfileDetailsModel = await UserProfileDetailsServices
//         .fetchUserProfileDetails(widget.userId);
//     setState(() {
//       isLoading = false;
//     });
//   }

//   Widget toggleFollowButton(
//       {required String ttl1,
//       required String ttl2,
//       required UserProfileDetailsModel userProfileDetailsModel,
//       required bool isPressed}) {
//     return MyEleButtonsmall(
//         title2: ttl2,
//         title: ttl1,
//         ispressed: isPressed,
//         onPressed: () async {
//           if (userProfileDetailsModel.user.state == 2) {
//             await FollowUnfollowServices.unFollow(
//               userId: userProfileDetailsModel.user.id,
//             );
//             setState(() {
//               if (userProfileDetailsModel.user.state == 2) {
//                 userProfileDetailsModel.user.state = 0;
//               }
//             });
//           } else {
//             await FollowUnfollowServices.toggleFollow(
//               userId: userProfileDetailsModel.user.id,
//             );
//           }
//         },
//         ctx: context);
//   }

//   _buildTabContext(int lineCount) => Container(
//         child: ListView.builder(
//           physics: const ClampingScrollPhysics(),
//           itemCount: lineCount,
//           itemBuilder: (BuildContext context, int index) {
//             return const Text('some content');
//           },
//         ),
//       );
//   Widget modifiedContainer(
//       {required String upperText,
//       required String lowerText,
//       required Function onTap}) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               upperText,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge!
//                   .copyWith(fontSize: 25, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(
//               lowerText,
//               style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                     fontSize: 13,
//                   ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   TextField textFieldBuilder({
//     required TextEditingController tcontroller,
//     required String hintTexxt,
//     required Function onChangedf,
//     Widget? prefixxIcon,
//   }) {
//     return TextField(
//       controller: tcontroller,
//       onChanged: (value) {
//         onChangedf();
//       },
//       cursorOpacityAnimates: true,
//       style: Theme.of(context)
//           .textTheme
//           .bodyMedium!
//           .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
//       maxLines: 1,
//       decoration: InputDecoration(
//         prefixIcon: prefixxIcon,
//         contentPadding: const EdgeInsets.all(20),
//         filled: true,
//         fillColor: Theme.of(context).colorScheme.secondary,
//         hintText: hintTexxt,
//         hintStyle:
//             Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.onBackground,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.onBackground,
//           ),
//         ),
//         focusColor: Theme.of(context).colorScheme.primary,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(20),
//           borderSide: BorderSide(
//             color: Theme.of(context).colorScheme.primary,
//           ),
//         ),
//       ),
//     );
//   }

//   void isNotOwner() {
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         context: context,
//         builder: (context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 Icons.horizontal_rule_rounded,
//                 size: 50,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.warning,
//                   color: Colors.red,
//                 ),
//                 title: Text(
//                   'Report',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Ionicons.remove_circle,
//                   color: Theme.of(context).colorScheme.onPrimary,
//                 ),
//                 title: Text(
//                   'Unfollow',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Ionicons.shield_outline,
//                     color: Theme.of(context).colorScheme.onPrimary),
//                 title: Text(
//                   'Restrict',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Ionicons.copy_outline,
//                     color: Theme.of(context).colorScheme.onPrimary),
//                 title: Text(
//                   'Copy Profile Link',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: Icon(Ionicons.send,
//                     color: Theme.of(context).colorScheme.onPrimary),
//                 title: Text(
//                   'Share this Profile',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   showModalBottomSheet(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       backgroundColor:
//                           Theme.of(context).scaffoldBackgroundColor,
//                       context: context,
//                       builder: (context) {
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.horizontal_rule_rounded,
//                                 size: 50,
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               textFieldBuilder(
//                                 tcontroller: TextEditingController(),
//                                 hintTexxt: "Write a message...",
//                                 onChangedf: () {},
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                                 child: Divider(
//                                   height: 10,
//                                 ),
//                               ),
//                               textFieldBuilder(
//                                   tcontroller: TextEditingController(),
//                                   hintTexxt: "Search",
//                                   onChangedf: () {},
//                                   prefixxIcon: Icon(
//                                     Ionicons.search,
//                                     size: 20,
//                                     color:
//                                         Theme.of(context).colorScheme.surface,
//                                   )),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: 10,
//                                     itemBuilder: (context, index) {
//                                       return ListTile(
//                                         leading: CircleAvatar(
//                                           radius: 30,
//                                           backgroundColor: Theme.of(context)
//                                               .colorScheme
//                                               .secondary,
//                                           child: const CircleAvatar(
//                                               radius: 28,
//                                               backgroundImage: AssetImage(
//                                                 "assets/Country_flag/in.png",
//                                               )),
//                                         ),
//                                         title: Text(
//                                           "Fatima",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(
//                                                 fontSize: 16,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .onPrimary,
//                                               ),
//                                         ),
//                                         subtitle: Text(
//                                           "Occupation",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall!
//                                               .copyWith(
//                                                 fontSize: 14,
//                                               ),
//                                         ),
//                                         trailing: MyEleButtonsmall(
//                                             title2: "Sent",
//                                             title: "Send",
//                                             onPressed: () {},
//                                             ctx: context),
//                                       );
//                                     }),
//                               ),
//                             ],
//                           ),
//                         );
//                       });
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Ionicons.eye_off_outline,
//                     color: Theme.of(context).colorScheme.onPrimary),
//                 title: Text(
//                   'Hide Your Story',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   bool _isExtended = true;
//   bool _haveReplies = true;
//   final List<String> extendedReplies = [
//     'Extended Reply 1',
//     'Extended Reply 2',
//     'Extended Reply 3',
//     'Extended Reply 4',
//   ];

//   Widget buildExtendedReplies() {
//     return ListView.builder(
//       itemCount: _isExtended ? extendedReplies.length : 0,
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 children: [
//                   Stack(
//                     children: [
//                       ClipOval(
//                         child: Image.asset(
//                           'assets/Country_flag/ad.png',
//                           height: 35,
//                           width: 35,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Positioned(
//                         right: 0,
//                         bottom: 0,
//                         child: Container(
//                           height: 16,
//                           width: 16,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(10),
//                             border: Border.all(
//                               color: Colors.black,
//                             ),
//                           ),
//                           child: const Icon(
//                             Icons.add,
//                             size: 15,
//                             color: Colors.black,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   Container(
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     height: 70,
//                     width: 2,
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade700,
//                       borderRadius: BorderRadius.circular(3),
//                     ),
//                   ),
//                 ],
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 10),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width - 81,
//                       child: const Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'lepan1m',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Text('41 m'),
//                               SizedBox(width: 10),
//                               Icon(Icons.more_horiz),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     const Text('Nice Flag'),
//                     const SizedBox(height: 13),
//                     SizedBox(
//                       width: 135,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Icon(
//                             Icons.favorite_border_rounded,
//                             size: 23,
//                           ),
//                           InkWell(
//                             onTap: () {
//                               Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => const NewThread()));
//                             },
//                             child: const Icon(
//                               Icons.mode_comment_outlined,
//                               size: 23,
//                             ),
//                           ),
//                           const Icon(
//                             Icons.reply_all_sharp,
//                             size: 23,
//                           ),
//                           const Icon(
//                             Icons.share,
//                             size: 23,
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     Row(
//                       children: [
//                         Text(
//                           '2 replies ',
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         Text(
//                           '• 78 likes',
//                           style: TextStyle(
//                             color: Colors.grey.shade600,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void isOwner({required BuildContext context}) {
//     showModalBottomSheet(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(20),
//             topRight: Radius.circular(20),
//           ),
//         ),
//         context: context,
//         builder: (context) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Icon(
//                 Icons.horizontal_rule_rounded,
//                 size: 50,
//                 color: Theme.of(context).colorScheme.secondary,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.settings,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Settings',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       CupertinoPageRoute(
//                           builder: ((context) => const ProfileSettings())));
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.archive,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Archive',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {},
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.bookmark_outline,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Saved',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) => const SavedPage())));
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.heart,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Liked Post',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) => const LikedPage())));
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.share,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Share this Profile',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   showModalBottomSheet(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                       ),
//                       backgroundColor:
//                           Theme.of(context).scaffoldBackgroundColor,
//                       context: context,
//                       builder: (context) {
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 15.0, right: 15),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.horizontal_rule_rounded,
//                                 size: 50,
//                                 color: Theme.of(context).colorScheme.secondary,
//                               ),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               textFieldBuilder(
//                                 tcontroller: TextEditingController(),
//                                 hintTexxt: "Write a message...",
//                                 onChangedf: () {},
//                               ),
//                               const SizedBox(
//                                 height: 20,
//                                 child: Divider(
//                                   height: 10,
//                                 ),
//                               ),
//                               textFieldBuilder(
//                                   tcontroller: TextEditingController(),
//                                   hintTexxt: "Search",
//                                   onChangedf: () {},
//                                   prefixxIcon: Icon(
//                                     Ionicons.search,
//                                     size: 20,
//                                     color:
//                                         Theme.of(context).colorScheme.surface,
//                                   )),
//                               const SizedBox(
//                                 height: 10,
//                               ),
//                               Expanded(
//                                 child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: 10,
//                                     itemBuilder: (context, index) {
//                                       return ListTile(
//                                         leading: CircleAvatar(
//                                           radius: 30,
//                                           backgroundColor: Theme.of(context)
//                                               .colorScheme
//                                               .secondary,
//                                           child: const CircleAvatar(
//                                               radius: 28,
//                                               backgroundImage: AssetImage(
//                                                 "assets/Country_flag/in.png",
//                                               )),
//                                         ),
//                                         title: Text(
//                                           "Fatima",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodyMedium!
//                                               .copyWith(
//                                                 fontSize: 16,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .onPrimary,
//                                               ),
//                                         ),
//                                         subtitle: Text(
//                                           "Occupation",
//                                           style: Theme.of(context)
//                                               .textTheme
//                                               .bodySmall!
//                                               .copyWith(
//                                                 fontSize: 14,
//                                               ),
//                                         ),
//                                         trailing: MyEleButtonsmall(
//                                             title2: "Sent",
//                                             title: "Send",
//                                             onPressed: () {},
//                                             ctx: context),
//                                       );
//                                     }),
//                               ),
//                             ],
//                           ),
//                         );
//                       });
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Ionicons.log_out_outline,
//                   color: Colors.white,
//                 ),
//                 title: Text(
//                   'Log Out',
//                   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                       color: Theme.of(context).colorScheme.onPrimary,
//                       fontSize: 16),
//                 ),
//                 onTap: () {
//                   AlertBoxes.acceptRejectAlertBox(
//                     context: context,
//                     title: "Log Out",
//                     content: const Text(" Are you sure you want to log out?"),
//                     onAccept: () async {
//                       FirebaseMessaging.instance.getToken().then((value) async {
//                         await AuthServices
//                             .userLogout(fcmToken: value)
//                             .then((value) {
//                           Navigator.pushAndRemoveUntil(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const MyApp()),
//                               (route) => false);
//                         });
//                       });
//                     },
//                     onReject: () {},
//                   );
//                 },
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: isLoading
//           ? Center(
//               child: SpinKit.ring)
//           : RefreshIndicator(
//               onRefresh: () async {
//                 await getUserProfileDetails();
//               },
//               child: NestedScrollView(
//                 controller: _scrollController,
//                 headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                   SliverToBoxAdapter(
//                     child: Column(
//                       children: [
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: AppBar(
//                             title: Text(
//                               userProfileDetailsModel!.user.username,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .bodyLarge!
//                                   .copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 23,
//                                   ),
//                             ),
//                             toolbarHeight: 70,
//                             backgroundColor:
//                                 Theme.of(context).scaffoldBackgroundColor,
//                             elevation: 0,
//                             actions: [
//                               IconButton(
//                                 onPressed: () {
//                                   if (widget.owner == true) {
//                                     log("here ");
//                                     isOwner(
//                                       context: context,
//                                     );
//                                   } else {
//                                     isNotOwner();
//                                   }
//                                 },
//                                 icon: Icon(
//                                   Ionicons.ellipsis_horizontal_circle_outline,
//                                   size: 25,
//                                   color:
//                                       Theme.of(context).colorScheme.onPrimary,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Center(
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: 75,
//                                 backgroundColor:
//                                     Theme.of(context).colorScheme.onBackground,
//                                 child: CircularNetworkImageWithoutSize(
//                                   imageUrl:
//                                       userProfileDetailsModel!.user.profilePic,
//                                 ),
//                               ),
//                               widget.owner == true
//                                   ? Positioned(
//                                       bottom: 8,
//                                       right: 8,
//                                       child: Container(
//                                         padding: const EdgeInsets.all(3),
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary,
//                                         ),
//                                         child: InkWell(
//                                           onTap: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         UpdateProfilePage(
//                                                           user:
//                                                               userProfileDetailsModel!
//                                                                   .user,
//                                                         )));
//                                           },
//                                           child: Icon(
//                                             Icons.edit,
//                                             color: Theme.of(context)
//                                                 .colorScheme
//                                                 .shadow,
//                                             size: 20,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                   : Container(),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         Text(
//                           userProfileDetailsModel!.user.name,
//                           style:
//                               Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 26,
//                                   ),
//                         ),
//                         const SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           userProfileDetailsModel!.user.occupation,
//                           style:
//                               Theme.of(context).textTheme.bodyLarge!.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                     fontSize: 18,
//                                   ),
//                         ),
//                         const SizedBox(
//                           height: 20,
//                         ),
//                         userProfileDetailsModel!.user.bio == null
//                             ? widget.owner != true
//                                 ? const SizedBox.shrink()
//                                 : TextButton(
//                                     onPressed: () {
//                                       AlertBoxes.acceptRejectAlertBox(
//                                           context: context,
//                                           title: "Add Bio",
//                                           onAccept: () async {
//                                             if (bioController.text.trim() !=
//                                                 "") {
//                                               await UserProfileDetailsServices
//                                                   .addBio(bioController.text);
//                                               setState(() {
//                                                 userProfileDetailsModel!.user
//                                                     .bio = bioController.text;
//                                               });
//                                             }
//                                           },
//                                           onReject: () {},
//                                           content: SizedBox(
//                                             width: 100,
//                                             child: TextFormField(
//                                               controller: bioController,
//                                               maxLines: 5,
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium!
//                                                   .copyWith(
//                                                     fontSize: 13,
//                                                   ),
//                                               decoration: InputDecoration(
//                                                 hintText:
//                                                     "Write your bio here...",
//                                                 hintStyle: Theme.of(context)
//                                                     .textTheme
//                                                     .bodyMedium!
//                                                     .copyWith(
//                                                       fontSize: 13,
//                                                     ),
//                                                 border: OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   borderSide: BorderSide(
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .onBackground,
//                                                   ),
//                                                 ),
//                                                 enabledBorder:
//                                                     OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   borderSide: BorderSide(
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .onBackground,
//                                                   ),
//                                                 ),
//                                                 focusColor: Theme.of(context)
//                                                     .colorScheme
//                                                     .primary,
//                                                 focusedBorder:
//                                                     OutlineInputBorder(
//                                                   borderRadius:
//                                                       BorderRadius.circular(20),
//                                                   borderSide: BorderSide(
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .primary,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           acceptTitle: "Add",
//                                           rejectTitle: "Cancel");
//                                     },
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: [
//                                         Icon(
//                                           Ionicons.add_circle,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary,
//                                           size: 22,
//                                         ),
//                                         const SizedBox(
//                                           width: 7,
//                                         ),
//                                         Text("Add Bio",
//                                             style: Theme.of(context)
//                                                 .textTheme
//                                                 .bodyMedium!
//                                                 .copyWith(
//                                                     fontSize: 13,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Theme.of(context)
//                                                         .colorScheme
//                                                         .primary))
//                                       ],
//                                     ))
//                             : Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: ExpandableTextWidget(
//                                   text: userProfileDetailsModel!.user.bio!,
//                                   maxLines: 3,
//                                 ),
//                               ),
//                         // SizedBox(
//                         //   height: 20,
//                         // ),
//                         // Text(
//                         //   "www.amj24.com",
//                         //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
//                         //       fontWeight: FontWeight.w600,
//                         //       fontSize: 18,
//                         //       color: Colors.blue),
//                         // ),
//                         const SizedBox(
//                           height: 40,
//                         ),
//                         SizedBox(
//                           height: 60,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Expanded(
//                                 child: SizedBox(
//                                   height: 100,
//                                   child: modifiedContainer(
//                                     onTap: () {},
//                                     upperText: userProfileDetailsModel!
//                                         .user.postCount
//                                         .toString(),
//                                     lowerText:
//                                         "Post${userProfileDetailsModel!.user.postCount > 1 ? "s" : ""}",
//                                   ),
//                                 ),
//                               ),
//                               VerticalDivider(
//                                 color: Theme.of(context).colorScheme.tertiary,
//                                 thickness: 1,
//                               ),
//                               Expanded(
//                                 child: SizedBox(
//                                   height: 100,
//                                   child: modifiedContainer(
//                                     onTap: () {
//                                       if (userProfileDetailsModel!.user.state ==
//                                               2 ||
//                                           widget.owner == true) {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FollowersPage(
//                                                       userId:
//                                                           userProfileDetailsModel!
//                                                               .user.id,
//                                                     ))).then(
//                                             (value) => getUserProfileDetails());
//                                       }
//                                     },
//                                     upperText: userProfileDetailsModel!
//                                         .user.followersCount
//                                         .toString(),
//                                     lowerText:
//                                         "Follower${userProfileDetailsModel!.user.followersCount > 1 ? "s" : ""}",
//                                   ),
//                                 ),
//                               ),
//                               VerticalDivider(
//                                 color: Theme.of(context).colorScheme.tertiary,
//                                 thickness: 1,
//                               ),
//                               Expanded(
//                                 child: SizedBox(
//                                   height: 100,
//                                   child: modifiedContainer(
//                                     onTap: () {
//                                       if (userProfileDetailsModel!.user.state ==
//                                               2 ||
//                                           widget.owner == true) {
//                                         Navigator.push(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     FollowingPage(
//                                                       userId:
//                                                           userProfileDetailsModel!
//                                                               .user.id,
//                                                     ))).then(
//                                             (value) => getUserProfileDetails());
//                                       }
//                                     },
//                                     upperText: userProfileDetailsModel!
//                                         .user.followingCount
//                                         .toString(),
//                                     lowerText:
//                                         "Following${userProfileDetailsModel!.user.followingCount > 1 ? "s" : ""}",
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                         widget.owner == true
//                             ? const SizedBox()
//                             : Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 8),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   children: [
//                                     Expanded(
//                                       child: toggleFollowButton(
//                                           userProfileDetailsModel:
//                                               userProfileDetailsModel!,
//                                           ttl1: userProfileDetailsModel!
//                                                       .user.state ==
//                                                   0
//                                               ? "Follow"
//                                               : userProfileDetailsModel!
//                                                           .user.state ==
//                                                       2
//                                                   ? "Following"
//                                                   : "Requested",
//                                           isPressed: userProfileDetailsModel!
//                                                       .user.state ==
//                                                   0
//                                               ? false
//                                               : true,
//                                           ttl2: userProfileDetailsModel!
//                                                       .user.state ==
//                                                   0
//                                               ? "Requested"
//                                               : "Follow"),
//                                     ),
//                                     const SizedBox(
//                                       width: 20,
//                                     ),
//                                     Expanded(
//                                       child: CustomOutlineButton(
//                                         iconButton1: Padding(
//                                           padding: const EdgeInsets.all(5.0),
//                                           child: InkWell(
//                                               onTap: () {},
//                                               child: Icon(
//                                                 Ionicons.chatbox_ellipses,
//                                                 color: Theme.of(context)
//                                                     .colorScheme
//                                                     .primary,
//                                               )),
//                                         ),
//                                         width1: 160,
//                                         title: "Message",
//                                         onPressed: () {
//                                           Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     ChangeNotifierProvider(
//                                                         create: (context) =>
//                                                             ChatProvider(),
//                                                         child: ChatPage(
//                                                             user:
//                                                                 inboxModel.User(
//                                                           email:
//                                                               userProfileDetailsModel!
//                                                                   .user.email,
//                                                           id: userProfileDetailsModel!
//                                                               .user.id,
//                                                           name:
//                                                               userProfileDetailsModel!
//                                                                   .user.name,
//                                                           profilePic:
//                                                               userProfileDetailsModel!
//                                                                   .user
//                                                                   .profilePic,
//                                                           username:
//                                                               userProfileDetailsModel!
//                                                                   .user
//                                                                   .username,
//                                                           occupation:
//                                                               userProfileDetailsModel!
//                                                                   .user
//                                                                   .occupation,
//                                                         ))),
//                                               ));
//                                         },
//                                         fontSize: 16,
//                                         ctx: context,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                         const SizedBox(
//                           height: 30,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: DefaultTabController(
//                       length: 3,
//                       child: TabBar(
//                         controller: _tabController,
//                         labelColor: Theme.of(context).colorScheme.primary,
//                         unselectedLabelColor:
//                             Theme.of(context).colorScheme.onPrimary,
//                         indicatorColor: Theme.of(context).colorScheme.primary,
//                         automaticIndicatorColorAdjustment: true,
//                         indicatorSize: TabBarIndicatorSize.tab,
//                         indicatorWeight: 3,
//                         dividerColor: Theme.of(context).colorScheme.onPrimary,
//                         tabs: const [
//                           Tab(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Ionicons.text,
//                                   size: 20,
//                                 ),
//                                 SizedBox(
//                                     width:
//                                         5), // Add spacing between icon and text
//                                 Text("Threads"),
//                               ],
//                             ),
//                           ),
//                           Tab(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Ionicons.grid_outline,
//                                   size: 20,
//                                 ),
//                                 SizedBox(
//                                     width:
//                                         5), // Add spacing between icon and text
//                                 Text("Feeds"),
//                               ],
//                             ),
//                           ),
//                           Tab(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Icon(
//                                   Ionicons.repeat_outline,
//                                   size: 20,
//                                 ),
//                                 SizedBox(
//                                     width:
//                                         5), // Add spacing between icon and text
//                                 Text("Reposts"),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//                 body: TabBarView(
//                   controller: _tabController,
//                   physics: const NeverScrollableScrollPhysics(),
//                   children: [
//                     ThreadViewBuilder(
//                       allThreads:
//                           userProfileDetailsModel!.threadsWithUserDetails,
//                     ),
//                     FutureBuilder(
//                       future: UserProfileDetailsServices.getUserFeeds(
//                           userId: userProfileDetailsModel!.user.id),
//                       builder: (context, snapshot) {
//                         if (snapshot.connectionState ==
//                             ConnectionState.waiting) {
//                           return const Center(
//                             child: SpinKitRing(
//                               color: Colors.white,
//                               lineWidth: 1,
//                               duration: Duration(seconds: 1),
//                             ),
//                           );
//                         }
//                         if (snapshot.hasError) {
//                           return const Center(
//                             child: Text("Error"),
//                           );
//                         }
//                         List<FeedThumbnail> userFeeds = snapshot.data ?? [];
//                         if (userFeeds.isEmpty) {
//                           return const NoPostYet();
//                         }
//                         return Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: GridView.builder(
//                               shrinkWrap: true,
//                               gridDelegate:
//                                   const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 crossAxisSpacing: 5,
//                                 mainAxisSpacing: 5,
//                               ),
//                               itemCount: userFeeds.length,
//                               itemBuilder: (context, index) {
//                                 return InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) => CommentPage(
//                                                   feedId: userFeeds[index].id,
//                                                 )));
//                                   },
//                                   child: RoundedNetworkImageWithLoading(
//                                     gestureEnabled: false,
//                                     imageUrl: userFeeds[index].images[0],
//                                   ),
//                                 );
//                               }),
//                         );
//                       },
//                     ),
//                     FutureBuilder(
//                         future: UserProfileDetailsServices
//                             .getRepostThreads(widget.userId),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: SpinKitRing(
//                                 color: Colors.white,
//                                 lineWidth: 1,
//                                 duration: Duration(seconds: 1),
//                               ),
//                             );
//                           }
//                           if (snapshot.hasError) {
//                             return const Center(
//                               child: Text("Error"),
//                             );
//                           }
//                           List<ThreadModel> repostThreads = snapshot.data ?? [];
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: ThreadViewBuilder(allThreads: repostThreads),
//                           );
//                         })
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
