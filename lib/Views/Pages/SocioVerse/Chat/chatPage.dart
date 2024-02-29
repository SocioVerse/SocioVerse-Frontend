import 'dart:async';
import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Utils/calculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileModels.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/roomInfoPage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/apiHelper.dart';
import 'package:socioverse/helpers/ServiceHelpers/socketHelper.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/helpers/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/helpers/api_constants.dart';
import 'package:socioverse/main.dart';
import 'package:socioverse/Services/chatting_services.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';

import '../Inbox/inboxModel.dart';

class ChatPage extends StatefulWidget {
  final User user;
  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool isTyping = false;
  bool isLoading = false;
  late RoomModel roomModel;
  late String userId;
  late IO.Socket socketHelper;
  @override
  void initState() {
    super.initState();
    print('here');

    getRoomInfo();
  }

  void dispose() {
    scrollChat.dispose();
    socketHelper.dispose();
    super.dispose();
  }

  Future<void> getRoomInfo() async {
    _setLoading(true);
    socketHelper = await SocketHelper().initSocketIO();
    userId = await getStringFromCache(SharedPreferenceString.userId);
    log(userId);
    roomModel = await ChattingServices().getChatroomInfoByUser(
      widget.user.id,
      userId,
    );

    _setupSocketListeners(userId, roomModel.room.id);
    if (!context.mounted) return;
    _updateChatProviderWithMessages(roomModel.messages);

    _scrollToBottomAndEmitSeenMessages();

    _setLoading(false);
  }

  void _setLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  void _updateChatProviderWithMessages(List<Message> messages) {
    Provider.of<ChatProvider>(context, listen: false).addAll(messages);
  }

  void _scrollToBottomAndEmitSeenMessages() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (scrollChat.hasClients) {
        scrollChat.jumpTo(
          scrollChat.position.maxScrollExtent,
        );
        socketHelper.emit('message-seen', {
          'roomId': roomModel.room.id,
        });
      }
    });
  }

  void _setupSocketListeners(String userId, String roomId) {
    socketHelper.emit('join', {
      'roomId': roomId,
    });
    socketHelper.on('unsend-message', (data) {
      log(data.toString());
      _handleUnsendMessage(data);
    });
    socketHelper.on('typing', (data) {
      log(data.toString());
      _handleMessageTyping(data);
    });

    socketHelper.on('message-seen', (data) {
      _handleMessageSeen(data, userId);
    });

    socketHelper.on('message', (data) {
      log(data.toString());
      _handleNewMessage(data, userId, roomId);
    });
  }

  Widget getMessageWidget(Message message) {
    if (message.thread != null) {
      return postMessage(message);
    } else if (message.image != null) {
      return photoMessage(message);
    } else {
      return textMessage(message);
    }
  }

  void _handleUnsendMessage(dynamic data) {
    log(data.toString());
    Provider.of<ChatProvider>(context, listen: false)
        .removeMessage(data['messageId']);
  }

  void _handleMessageTyping(dynamic data) {
    log(data.toString());
    Provider.of<ChatProvider>(context, listen: false).setTyping(data);
  }

  void _handleMessageSeen(dynamic data, String userId) {
    log(data.toString());
    List<Message> messages =
        List<Message>.from(data.map((x) => Message.fromJson(x, userId)));
    Provider.of<ChatProvider>(context, listen: false).updateMessages(messages);
  }

  void _handleNewMessage(dynamic data, String userId, String roomId) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      if (scrollChat.hasClients) {
        scrollChat.jumpTo(
          scrollChat.position.maxScrollExtent,
        );
        socketHelper.emit('message-seen', {
          'roomId': roomId,
        });
      }
    });
    Message message = Message.fromJson(data, userId);
    Provider.of<ChatProvider>(context, listen: false).addNewMessage(
      message,
      roomId,
    );
  }

  Widget postMessage(Message message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.sender.isOwner
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MyApp.width! / 2),
          margin: const EdgeInsets.symmetric(
            vertical: 7,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: !message.sender.isOwner
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: const CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                        "assets/Country_flag/in.png",
                      )),
                ),
                title: Text(
                  "Name",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                subtitle: Text(
                  "Occupation",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/Country_flag/in.png",
                  fit: BoxFit.cover,
                  height: MyApp.width! / 2,
                  width: MyApp.width! / 2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget textMessage(Message message) {
    log(message.isSeenByAll.toString());
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.sender.isOwner
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MyApp.width! / 2),
          margin: const EdgeInsets.symmetric(
            vertical: 2,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            color: !message.sender.isOwner
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.8)
                    .withAlpha(200),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  message.message!,
                  maxLines: null,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                CalculatingFunction.getTime(message.createdAt),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 8,
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary
                          .withAlpha(150),
                    ),
              )
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        message.sender.isOwner
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  message.isSeenByAll
                      ? Ionicons.checkmark_circle
                      : Ionicons.checkmark_circle_outline,
                  size: 15,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget photoMessage(Message message) {
    log(message.isSeenByAll.toString());
    return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: message.sender.isOwner
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
              width: MyApp.width! / 2,
              height: MyApp.width! / 2,
              constraints: BoxConstraints(
                maxWidth: MyApp.width! / 2,
              ),
              margin: const EdgeInsets.symmetric(
                vertical: 2,
              ),
              child: Stack(
                alignment: message.sender.isOwner
                    ? Alignment.bottomRight
                    : Alignment.bottomLeft,
                children: [
                  RoundedNetworkImageWithLoading(
                    imageUrl: message.image!,
                    borderRadius: 0, // Set the desired border radius
                    fit: BoxFit.contain,
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Text(
                          CalculatingFunction.getTime(message.createdAt),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontSize: 8,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      )),
                ],
              )),
          const SizedBox(
            width: 8,
          ),
          message.sender.isOwner
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Icon(
                    message.isSeenByAll
                        ? Ionicons.checkmark_circle
                        : Ionicons.checkmark_circle_outline,
                    size: 15,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : const SizedBox.shrink()
        ]);
  }

  TextEditingController message = TextEditingController();
  ScrollController scrollChat = ScrollController();
  List<Map<String, dynamic>> newMessages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer<ChatProvider>(
          builder: (context, chatProvider, child) {
            return InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              onTap: () {
                //if room chat loaded

                if (isLoading == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RoomInfoPage(
                                user: widget.user,
                                inboxModelList: chatProvider.messages
                                    .where((element) => element.image != null)
                                    .toList(),
                              )));
                }
              },
              child: Row(
                children: [
                  CircularNetworkImageWithSize(
                    imageUrl: widget.user!.profilePic,
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.user!.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ),
                      Consumer<ChatProvider>(
                        builder: (context, chatProvider, child) {
                          return chatProvider.isTyping &&
                                  chatProvider.typingUserId == widget.user.id
                              ? Text(
                                  "Typing...",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                )
                              : Text(
                                  widget.user!.username,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.call_outline,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.videocam_outline,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: isLoading
          ? Center(
              child: SpinKitRing(
                color: Theme.of(context).colorScheme.tertiary,
                lineWidth: 1,
                duration: const Duration(seconds: 1),
              ),
            )
          : Column(children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Consumer<ChatProvider>(
                        builder: (context, chatProvider, child) {
                          return ListView.separated(
                            controller: scrollChat,
                            itemCount: chatProvider.messages.length + 1,
                            separatorBuilder: (context, index) {
                              if (index == 0) {
                                return const SizedBox.shrink();
                              }

                              if (chatProvider.messages[index].createdAt.day !=
                                      chatProvider
                                          .messages[index - 1].createdAt.day ||
                                  chatProvider
                                          .messages[index].createdAt.month !=
                                      chatProvider.messages[index - 1].createdAt
                                          .month ||
                                  chatProvider.messages[index].createdAt.year !=
                                      chatProvider
                                          .messages[index - 1].createdAt.year) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    CalculatingFunction.getDay(
                                        chatProvider.messages[index].createdAt),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    chatProvider.messages.isEmpty
                                        ? 'Today'
                                        : CalculatingFunction.getDay(
                                            chatProvider
                                                .messages[index].createdAt),
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                  ),
                                );
                              }

                              Message message =
                                  chatProvider.messages[index - 1];
                              return InkWell(
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                overlayColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                onLongPress: () {
                                  if (message.sender.isOwner) {
                                    AlertBoxes.acceptRejectAlertBox(
                                      context: context,
                                      title: "Unsend Message",
                                      content: const Text(
                                          "Are you sure you want to unsend this message?"),
                                      onAccept: () async {
                                        socketHelper.emit('unsend-message', {
                                          'messageId': message.id,
                                          'roomId': roomModel.room.id,
                                        });
                                      },
                                      onReject: () {},
                                    );
                                  }
                                },
                                child: getMessageWidget(message),
                              );
                            },
                          );
                        },
                      ))),
              ChatInputWidget(
                roomId: roomModel.room.id,
                socketHelper: socketHelper,
              ),
            ]),
    );
  }
}

class ChatInputWidget extends StatefulWidget {
  final String roomId;
  final IO.Socket socketHelper;
  const ChatInputWidget(
      {Key? key, required this.roomId, required this.socketHelper})
      : super(key: key);

  @override
  _ChatInputWidgetState createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  TextEditingController message = TextEditingController();
  @override
  void initState() {
    message.addListener(() {
      if (message.text.trim() != "") {
        widget.socketHelper.emit('typing', {
          'isTyping': true,
          'roomId': widget.roomId,
        });
      } else {
        widget.socketHelper.emit('typing', {
          'isTyping': false,
          'roomId': widget.roomId,
        });
      }
    });
    super.initState();
  }

  void _sendMessage() {
    if (message.text.trim() != "") {
      widget.socketHelper.emit('message', {
        'message': message.text,
        'image': null,
        'thread': null,
        'roomId': widget.roomId,
      });
      message.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 20,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () async {
              List<File>? images =
                  await ImagePickerFunctionsHelper().pickMultipleImage(context);

              if (images != null) {
                for (int i = 0; i < images.length; i++) {
                  String url = await FirebaseHelper.uploadFile(images[i].path,
                      const Uuid().v4(), "chat_images", FirebaseHelper.Image);
                  widget.socketHelper.emit('message', {
                    'message': null,
                    'image': url,
                    'thread': null,
                    'roomId': widget.roomId,
                  });
                }
              }
            },
            icon: Icon(
              Ionicons.images_outline,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Flexible(
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              controller: message,
              onChanged: (value) {},
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.surface,
                  ),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Type message...",
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 16,
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
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: Icon(
              Ionicons.send,
              size: 25,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
