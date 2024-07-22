import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Helper/FlutterToasts/flutterToast.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Services/report_services.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:socioverse/Sockets/messageSockets.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Widgets/Global/dataStructure.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Views/Widgets/textfield_widgets.dart';

class ReportBottomSheet {
  String reportType;
  BuildContext context;
  String userId;
  String? feedId;
  String? threadId;
  String? storyId;

  // Report Story
  List<String> reportStoryOptions = [
    "Inappropriate Content",
    "Misleading Information",
    "Violates Community Guidelines",
    "Spam or Scam",
  ];

// Report Thread
  List<String> reportThreadOptions = [
    "Offensive Comments",
    "Bullying or Harassment",
    "Inappropriate Topic",
    "Thread Hijacking",
  ];

// Report Post
  List<String> reportPostOptions = [
    "Hate Speech or Discrimination",
    "Violent or Graphic Content",
    "Copyright Infringement",
    "Fake News",
  ];

// Report User
  List<String> reportUserOptions = [
    "Impersonation or Fake Account",
    "Abusive Behavior",
    "Inappropriate Profile Content",
    "Suspicious Activity",
  ];
  List<String> getList() {
    switch (reportType) {
      case "Story":
        return reportStoryOptions;
      case "Thread":
        return reportThreadOptions;
      case "Feed":
        return reportPostOptions;
      case "User":
        return reportUserOptions;
      default:
        return [];
    }
  }

  showReportBottomSheet() {
    List<String> reportOptions = getList();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.horizontal_rule_rounded,
              size: 50,
              color: Theme.of(context).colorScheme.secondary,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: reportOptions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    reportOptions[index],
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontSize: 16,
                        ),
                  ),
                  onTap: () async {
                    await ReportServices.createReport(
                      reportType: reportType,
                      reason: reportOptions[index],
                      userId: userId,
                      feedId: feedId,
                      threadId: threadId,
                      storyId: storyId,
                    ).then((value) => FlutterToast.flutterWhiteToast(
                        "Reported Successfully"));
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  ReportBottomSheet(
      {required this.reportType,
      required this.context,
      required this.userId,
      this.feedId,
      this.threadId,
      this.storyId});
}

class ShareList {
  Enum type;
  BuildContext context;
  TextEditingController search = TextEditingController();

  ShareList({required this.type, required this.context});

  showShareBottomSheet(String objectId) {
    return showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                    tcontroller: search,
                    hintTexxt: "Search",
                    onChangedf: () {},
                    prefixxIcon: Icon(
                      Ionicons.search,
                      size: 20,
                      color: Theme.of(context).colorScheme.surface,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: UserServices.getShareList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: SpinKit.ring,
                          );
                        }
                        if (snapshot.hasData) {
                          List<User> users = snapshot.data as List<User>;
                          return ListView.builder(
                              itemCount: users.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () => Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) => UserProfilePage(
                                                owner: false,
                                                userId: users[index].id,
                                              ))),
                                  leading: CircularNetworkImageWithSize(
                                    imageUrl: users[index].profilePic,
                                    height: 40,
                                    width: 40,
                                  ),
                                  title: Text(
                                    users[index].username,
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
                                    users[index].occupation,
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
                                      onPressed: () async {
                                        await UserServices.getRoomId(
                                                users[index].id)
                                            .then((value) {
                                          MessagesSocket(context)
                                              .emitJoinChat(value.roomId);
                                          if (type == ShareType.feed) {
                                            MessagesSocket(context)
                                                .emitMessageFeed(
                                                    value.roomId, objectId);
                                          } else if (type == ShareType.thread) {
                                            MessagesSocket(context)
                                                .emitMessageThread(
                                                    value.roomId, objectId);
                                          } else if (type == ShareType.story) {
                                            MessagesSocket(context)
                                                .emitMessageStory(
                                                    value.roomId, objectId);
                                          } else if (type ==
                                              ShareType.profile) {
                                            MessagesSocket(context)
                                                .emitMessageProfile(
                                                    value.roomId, objectId);
                                          }
                                        });
                                      },
                                      ctx: context),
                                );
                              });
                        }
                        return Center(
                          child: SpinKit.ring,
                        );
                      }),
                ),
              ],
            ),
          );
        });
  }
}
