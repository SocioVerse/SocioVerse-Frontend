import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/inboxPageProvider.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:socioverse/Sockets/messageSockets.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Services/chatting_services.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfilePage.dart';
import 'package:socioverse/Views/Pages/SocioThread/CommentPage/threadCommentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/roomInfoPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Comment/commentPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/StoryPage/storyPage.dart';
import 'package:socioverse/Views/Widgets/Global/alertBoxes.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:uuid/uuid.dart';
import 'package:socioverse/Models/storyModels.dart' as StroyModel;

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
  bool _isFirstBuild = true;
  TextEditingController message = TextEditingController();
  ScrollController scrollChat = ScrollController();
  List<Map<String, dynamic>> newMessages = [];
  @override
  void initState() {
    super.initState();
    getRoomInfo().then(
        (value) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              if (roomModel.room != null) {
                _initializeListeners();
              }
            }));
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void dispose() {
    scrollChat.dispose();
    SocketHelper.socketHelper.off('unsend-message');
    SocketHelper.socketHelper.off('typing');
    SocketHelper.socketHelper.off('message-seen');
    SocketHelper.socketHelper.off('message');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: personTile(),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          Consumer<ChatProvider>(builder: (context, chatProvider, child) {
            return IconButton(
              onPressed: () {
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
              icon: Icon(
                Ionicons.arrow_forward,
                size: 25,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            );
          }),
        ],
      ),
      body: isLoading
          ? Center(
              child: SpinKit.ring,
            )
          : Column(children: [
              chatsArea(),
              chatInput(context),
            ]),
    );
  }

  _initializeListeners() {
    addMessageInboxListner();
    _setupSocketListeners(userId, roomModel.room!.id);
    _updateChatProviderWithMessages(roomModel.messages);
  }

  addMessageInboxListner() {
    message.addListener(() {
      if (message.text.trim() != "") {
        MessagesSocket(context).emitMessageTyping(roomModel.room!.roomId, true);
      } else {
        MessagesSocket(context)
            .emitMessageTyping(roomModel.room!.roomId, false);
      }
    });
  }

  Future<void> _sendMessage() async {
    await _initializeRoom();
    if (message.text.trim() != "") {
      if (Provider.of<InboxPageProvider>(context, listen: false)
          .requestModel
          .where((element) => element.id == roomModel.room!.id)
          .isNotEmpty) {
        log('request');
        Provider.of<InboxPageProvider>(context, listen: false)
            .requestToInbox(roomModel.room!.id);
      }
      MessagesSocket(context).emitMessage(roomModel.room!.roomId, message.text);
      message.clear();
    }
  }

  Future<void> _initializeRoom() async {
    if (roomModel.room == null) {
      roomModel.room = await ChattingServices.createRoom(widget.user.id);
      Provider.of<InboxPageProvider>(context, listen: false)
          .addInbox(InboxModel(
        roomId: roomModel.room!.id,
        user: widget.user,
        lastMessage: null,
        createdAt: DateTime.now(),
        id: roomModel.room!.id,
        isGroup: false,
        unreadMessages: 0,
        updatedAt: DateTime.now(),
        isRequestMessage: false,
      ));
      MessagesSocket(context).emitInboxAdd(roomModel.room!.id, widget.user.id);
      _initializeListeners();
    }
  }

  Future<void> getRoomInfo() async {
    _setLoading(true);
    userId = await getStringFromCache(SharedPreferenceString.userId);
    log(userId);
    roomModel = await ChattingServices.getChatroomInfoByUser(
      widget.user.id,
      userId,
    );

    _setLoading(false);
  }

  void _setLoading(bool isLoading) {
    setState(() {
      this.isLoading = isLoading;
    });
  }

  TextField messageTextField(BuildContext context) {
    return TextField(
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
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
    );
  }

  void _updateChatProviderWithMessages(List<Message> messages) {
    Provider.of<ChatProvider>(context, listen: false).addAll(messages);
  }

  void _scrollToBottomAndEmitSeenMessages() {
    if (scrollChat.hasClients) {
      scrollChat.animateTo(
        scrollChat.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      if (Provider.of<ChatProvider>(context, listen: false)
              .messages
              .isNotEmpty &&
          roomModel.room != null &&
          Provider.of<ChatProvider>(context, listen: false)
                  .messages
                  .last
                  .isSeenByAll ==
              false) {
        MessagesSocket(context).emitMessageSeen(roomModel.room!.id);
      }
    }
  }

  void _setupSocketListeners(String userId, String roomId) {
    if (Provider.of<ChatProvider>(context, listen: false).messages.isEmpty) {
      MessagesSocket(context).emitJoinChat(roomModel.room!.id);
    }
    SocketHelper.socketHelper.on('unsend-message', (data) {
      log(data.toString());

      MessagesSocket(context).handleUnsendMessage(data);
      if (Provider.of<ChatProvider>(context, listen: false).messages.isEmpty) {
        SocketHelper.socketHelper.emit('leave-room', {
          'roomId': roomModel.room!.id,
        });
        SocketHelper.socketHelper.clearListeners();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(index: 0),
            ),
            (route) => route.isFirst);
      }
    });
    SocketHelper.socketHelper.on('typing', (data) {
      log(data.toString());
      MessagesSocket(context).handleMessageTyping(data);
    });

    SocketHelper.socketHelper.on('message-seen', (data) {
      MessagesSocket(context).handleMessageSeen(data, userId);
    });

    SocketHelper.socketHelper.on('message', (data) {
      log(data.toString() + 'gotit');
      MessagesSocket(context)
          .handleNewMessage(data, userId, roomId, scrollChat);
    });
  }

  Widget getMessageWidget(Message message) {
    if (message.feed != null) {
      return post(message, "Feed");
    } else if (message.profile != null) {
      return post(message, "Profile");
    } else if (message.thread != null) {
      return post(message, "Thread");
    } else if (message.story != null) {
      return post(message, "Story");
    } else if (message.image != null) {
      return photoMessage(message);
    } else {
      return textMessage(message);
    }
  }

  Widget postMessage(Message message) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.sender.isOwner
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
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
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget post(Message message, String type) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.sender.isOwner
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            if (type == "Feed") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CommentPage(
                            feedId: message.feed,
                          )));
            } else if (type == "Profile") {
              String userId =
                  await getStringFromCache(SharedPreferenceString.userId);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            owner: userId == message.profile,
                            userId: userId == message.profile
                                ? null
                                : message.profile,
                          )));
            } else if (type == "Thread") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ThreadCommentPage(
                            threadId: message.thread,
                          )));
            } else if (type == "Story") {
              print("story");
              StroyModel.User? user = await StoriesServices.getUserByStoryId(
                  storyId: message.story!);
              if (user == null) return;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => StoryPage(
                            user: user,
                          )));
            }
          },
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 1.5),
            margin: const EdgeInsets.symmetric(
              vertical: 2,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: Text(
                    "Tap to View $type",
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

  Widget textMessage(Message message) {
    log(message.isSeenByAll.toString());
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: message.sender.isOwner
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
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
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2,
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

  Expanded chatsArea() {
    return Expanded(child: Builder(builder: (context) {
      return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return ListView.separated(
                controller: scrollChat,
                itemCount: chatProvider.messages.length + 1,
                separatorBuilder: (context, index) {
                  if (_isFirstBuild) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _scrollToBottomAndEmitSeenMessages();
                    });
                    _isFirstBuild = false;
                  }
                  if (index == 0) {
                    return const SizedBox.shrink();
                  }

                  if (chatProvider.messages[index].createdAt.day !=
                          chatProvider.messages[index - 1].createdAt.day ||
                      chatProvider.messages[index].createdAt.month !=
                          chatProvider.messages[index - 1].createdAt.month ||
                      chatProvider.messages[index].createdAt.year !=
                          chatProvider.messages[index - 1].createdAt.year) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        CalculatingFunction.getDay(
                            chatProvider.messages[index].createdAt),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        chatProvider.messages.isEmpty
                            ? 'Today'
                            : CalculatingFunction.getDay(
                                chatProvider.messages[index].createdAt),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    );
                  }

                  Message message = chatProvider.messages[index - 1];
                  return InkWell(
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    onLongPress: () {
                      if (message.sender.isOwner) {
                        AlertBoxes.acceptRejectAlertBox(
                          context: context,
                          title: "Unsend Message",
                          content: const Text(
                              "Are you sure you want to unsend this message?"),
                          onAccept: () async {
                            MessagesSocket(context).emitUnsendMessage(
                              message.id,
                              roomModel.room!.id,
                            );
                            Navigator.pop(context);
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
          ));
    }));
  }

  Widget personTile() {
    return InkWell(
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      child: Row(
        children: [
          CircularNetworkImageWithSize(
            imageUrl: widget.user.profilePic,
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
                widget.user.name,
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                        )
                      : Text(
                          widget.user.username,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
  }

  Padding chatInput(BuildContext context) {
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
                  await ImagePickerFunctionsHelper.pickMultipleImage(context);

              if (images != null) {
                for (int i = 0; i < images.length; i++) {
                  String url = await FirebaseHelper.uploadFile(images[i].path,
                      const Uuid().v4(), "chat_images", FirebaseHelper.Image);
                  if (!mounted) return;
                  await _initializeRoom();
                  MessagesSocket(context).emitMessageImage(
                    roomModel.room!.roomId,
                    url,
                  );
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
            child: messageTextField(context),
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
