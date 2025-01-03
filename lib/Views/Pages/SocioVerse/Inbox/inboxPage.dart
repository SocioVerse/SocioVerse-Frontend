import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Controllers/inboxPageProvider.dart';
import 'package:socioverse/Controllers/multiProviderList.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/searchedUser.dart';
import 'package:socioverse/Sockets/messageSockets.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Services/inbox_services.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Inbox/requestInboxPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/Services/search_bar_services.dart';
import '../../../Widgets/textfield_widgets.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getInbox();
    });

    super.initState();
  }

  void getInbox() async {
    Provider.of<InboxPageProvider>(context, listen: false).init(context);
  }

  List<SearchedUser> searchedUser = [];
  ListTile personListTile(
      {required String ttl1,
      required String ttl2,
      required SearchedUser user,
      required bool isPressed}) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return UserProfilePage(
            owner: false,
            userId: user.id,
          );
        }));
      },
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularNetworkImageWithSize(
            imageUrl: user.profilePic,
            height: 35,
            width: 35,
          ),
        ),
      ),
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
      subtitle: Text(
        user.username,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 12,
            ),
      ),
      trailing: CustomOutlineButton(
        ctx: context,
        title: "Message",
        onPressed: () {
          Navigator.push(context, CupertinoPageRoute(builder: ((context) {
            return ChangeNotifierProvider(
              create: (context) => ChatProvider(),
              child: ChatPage(
                  user: User(
                id: user.id,
                name: user.name,
                email: user.email,
                username: user.username,
                occupation: user.occupation,
                profilePic: user.profilePic,
              )),
            );
          })));
        },
      ),
    );
  }

  Future<void> getQueryUser() async {
    Provider.of<InboxPageLoadingProvider>(context, listen: false)
        .isUserFetched = false;
    searchedUser = await SearchBarServices.fetchSearchedUser(
        searchQuery: search.text.trim());
    if (!mounted) return;
    Provider.of<InboxPageLoadingProvider>(context, listen: false)
        .isUserFetched = true;
  }

  Widget buildShimmeringInbox(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor:
                  Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
              highlightColor: Colors.grey[500]!,
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Messages",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    highlightColor: Colors.grey[500]!,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                    ),
                  ),
                  title: Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      height: 20,
                      width: 50,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                    ),
                  ),
                  subtitle: Shimmer.fromColors(
                    baseColor:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                    highlightColor: Colors.grey[500]!,
                    child: Container(
                      height: 16,
                      width: 100,
                      color: Theme.of(context)
                          .colorScheme
                          .tertiary
                          .withOpacity(0.5),
                    ),
                  ),
                  trailing: Column(
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                        highlightColor: Colors.grey[500]!,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.5),
                        highlightColor: Colors.grey[500]!,
                        child: Container(
                          height: 10,
                          width: 40,
                          color: Theme.of(context)
                              .colorScheme
                              .tertiary
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inbox",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // if (search.text.isNotEmpty) {
          //   search.clear();
          //   return;
          // }
          getInbox();
        },
        child:
            Consumer<InboxPageLoadingProvider>(builder: (context, prov, child) {
          return prov.isLoading
              ? buildShimmeringInbox(context)
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldBuilder(
                            tcontroller: search,
                            hintTexxt: "Search",
                            onChangedf: () {
                              if (search.text.isEmpty) {
                                getInbox();
                                return;
                              }
                              getQueryUser();
                            },
                            prefixxIcon: Icon(
                              Ionicons.search,
                              size: 20,
                              color: Theme.of(context).colorScheme.surface,
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        search.text.trim().isEmpty
                            ? Consumer<InboxPageProvider>(
                                builder: (context, prov, child) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "Messages",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!
                                              .copyWith(
                                                fontWeight: FontWeight.w300,
                                                fontSize: 20,
                                              ),
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed: () {
                                            if (prov.requestModel.isEmpty) {
                                              return;
                                            }
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: ((context) {
                                              return const RequestInboxPage();
                                            })));
                                          },
                                          child: Text(
                                            "Requests (${prov.requestModel.length})",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .copyWith(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 15,
                                                    color: Colors.blueAccent),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: prov.inboxModel.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        if (prov.inboxModel[index]
                                                .lastMessage ==
                                            null)
                                          return const SizedBox.shrink();
                                        return ListTile(
                                          onTap: () {
                                            Navigator.push(context,
                                                CupertinoPageRoute(
                                                    builder: ((context) {
                                              return ChangeNotifierProvider(
                                                create: (context) =>
                                                    ChatProvider(),
                                                child: ChatPage(
                                                  user: prov
                                                      .inboxModel[index].user,
                                                ),
                                              );
                                            })));
                                          },
                                          leading: CircularNetworkImageWithSize(
                                            imageUrl: prov.inboxModel[index]
                                                .user.profilePic,
                                            height: 45,
                                            width: 45,
                                          ),
                                          title: Text(
                                            prov.inboxModel[index].user.name,
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
                                            prov.inboxModel[index].lastMessage!
                                                    .message ??
                                                'Send an attachment',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontSize: 14,
                                                  fontWeight: prov
                                                              .inboxModel[index]
                                                              .unreadMessages >
                                                          0
                                                      ? FontWeight.bold
                                                      : FontWeight.w300,
                                                ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const SizedBox(
                                                height: 7,
                                              ),
                                              prov.inboxModel[index]
                                                          .unreadMessages ==
                                                      0
                                                  ? const SizedBox()
                                                  : CircleAvatar(
                                                      radius: 10,
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      child: Text(
                                                        prov.inboxModel[index]
                                                            .unreadMessages
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                            ),
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                CalculatingFunction.getTimeDiff(
                                                    prov
                                                        .inboxModel[index]
                                                        .lastMessage!
                                                        .updatedAt),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      fontSize: 10,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  ],
                                );
                              })
                            : Consumer<InboxPageLoadingProvider>(
                                builder: (context, prov, child) {
                                return prov.isUserFetched
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: searchedUser.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Column(children: [
                                            personListTile(
                                                user: searchedUser[index],
                                                ttl1:
                                                    searchedUser[index].state ==
                                                            0
                                                        ? "Follow"
                                                        : searchedUser[index]
                                                                    .state ==
                                                                2
                                                            ? "Following"
                                                            : "Requested",
                                                isPressed:
                                                    searchedUser[index].state ==
                                                            0
                                                        ? false
                                                        : true,
                                                ttl2:
                                                    searchedUser[index].state ==
                                                            0
                                                        ? "Requested"
                                                        : "Follow"),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ]);
                                        },
                                      )
                                    : Center(
                                        child: SpinKit.ring,
                                      );
                              }),
                      ],
                    ),
                  ));
        }),
      ),
    );
  }
}
