import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/inboxPageProvider.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

class RequestInboxPage extends StatefulWidget {
  const RequestInboxPage({Key? key}) : super(key: key);

  @override
  State<RequestInboxPage> createState() => _RequestInboxPageState();
}

class _RequestInboxPageState extends State<RequestInboxPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Inbox",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<InboxPageProvider>(builder: (context, prov, child) {
              log(prov.requestModel.length.toString() + 'length');
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: prov.requestModel.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  log(index.toString() + 'index');
                  InboxModel reqInboxModel = prov.requestModel[index];
                  if (reqInboxModel.lastMessage == null) {
                    return const SizedBox();
                  }
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: ((context) {
                        return ChatPage(
                          user: reqInboxModel.user,
                        );
                      })));
                    },
                    leading: CircularNetworkImageWithSize(
                      imageUrl: reqInboxModel.user.profilePic,
                      height: 45,
                      width: 45,
                    ),
                    title: Text(
                      reqInboxModel.user.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    subtitle: Text(
                      reqInboxModel.lastMessage!.message ??
                          'Sends an attachment',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: reqInboxModel.unreadMessages > 0
                                ? FontWeight.bold
                                : FontWeight.w300,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 7,
                        ),
                        reqInboxModel.unreadMessages == 0
                            ? const SizedBox()
                            : CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: Text(
                                  reqInboxModel.unreadMessages.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: Theme.of(context)
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
                              reqInboxModel.lastMessage!.updatedAt),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontSize: 10,
                                  ),
                        ),
                      ],
                    ),
                  );
                },
              );
            })
          ],
        ),
      )),
    );
    ;
  }
}
