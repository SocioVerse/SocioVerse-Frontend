import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/feedPageProviders.dart';
import 'package:socioverse/Controllers/inboxPageProvider.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Sockets/socketMain.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Chat/chatProvider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MessagesSocket {
  BuildContext context;

  MessagesSocket(this.context);
  void setInboxListners() {
    for (var i
        in Provider.of<InboxPageProvider>(context, listen: false).inboxModel) {
      SocketHelper.socketHelper.emit('join-chat', {
        'roomId': i.roomId,
      });
    }
    SocketHelper.socketHelper.on('inbox-add', ((data) {
      log("${data}Here");
      InboxModel inboxModel = InboxModel.fromJson(data);
      MessagesSocket(context).emitJoinChat(inboxModel.roomId);
      Provider.of<InboxPageProvider>(context, listen: false).addInbox(
        inboxModel,
        isRequestMessage: inboxModel.isRequestMessage,
      );
    }));
    SocketHelper.socketHelper.on('inbox', ((data) {
      log("${data}Here");
      Provider.of<InboxPageProvider>(context, listen: false)
          .updateInbox(context, data);
    }));
    SocketHelper.socketHelper.on('delete-room', (data) {
      Provider.of<InboxPageProvider>(context, listen: false)
          .deleteInbox(data['roomId']);
    });
  }

  void setFeedPageListeners() {
    SocketHelper.socketHelper.on('feed-page-count', (data) {
      log(data.toString());
      Provider.of<FeedPageProvider>(context, listen: false).messageCount =
          data['cnt'];
    });
  }

  //emit
  void emitMessageSeen(String roomId) {
    SocketHelper.socketHelper.emit('message-seen', {
      'roomId': roomId,
    });
  }

  void emitInboxAdd(String roomId, String userId) {
    SocketHelper.socketHelper
        .emit('inbox-add', {'roomId': roomId, 'userId': userId});
  }

  void emitJoinChat(String roomId) {
    log('join');
    SocketHelper.socketHelper.emit('join-chat', {
      'roomId': roomId,
    });
  }

  void emitMessageImage(String roomId, String url) {
    SocketHelper.socketHelper.emit('message', {
      'message': null,
      'image': url,
      'thread': null,
      'roomId': roomId,
    });
  }

  void emitUnsendMessage(String messageId, String roomId) {
    SocketHelper.socketHelper.emit('unsend-message', {
      'messageId': messageId,
      'roomId': roomId,
    });
  }

  void emitDeleteRoom(String roomId) {
    SocketHelper.socketHelper.emit('delete-room', {
      'roomId': roomId,
    });
  }

  void emitMessage(String roomId, String message) {
    SocketHelper.socketHelper.emit('message', {
      'message': message,
      'image': null,
      'thread': null,
      'roomId': roomId,
    });
  }

  void emitMessageTyping(String roomId, bool isTyping) {
    SocketHelper.socketHelper.emit('typing', {
      'isTyping': isTyping,
      'roomId': roomId,
    });
  }

  //on
  void handleUnsendMessage(dynamic data) {
    log(data.toString());
    Provider.of<ChatProvider>(context, listen: false)
        .removeMessage(data['messageId']);
  }

  void handleMessageTyping(dynamic data) {
    log(data.toString());
    Provider.of<ChatProvider>(context, listen: false).setTyping(data);
  }

  void handleMessageSeen(dynamic data, String userId) {
    log(data.toString());
    List<Message> messages =
        List<Message>.from(data.map((x) => Message.fromJson(x, userId)));
    Provider.of<ChatProvider>(context, listen: false).updateMessages(messages);
  }

  void handleNewMessage(
      dynamic data, String userId, String roomId, ScrollController scrollChat) {
    log(data.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollChat.hasClients) {
        scrollChat.jumpTo(
          scrollChat.position.maxScrollExtent,
        );
        SocketHelper.socketHelper.emit('message-seen', {
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
}
