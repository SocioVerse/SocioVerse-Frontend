import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socioverse/Models/chat_models.dart';

class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [];
  Map<String, dynamic> _isTypingMap = {};

  List<Message> get messages => _messages;
  bool get isTyping => _isTypingMap['isTyping'] ?? false;
  String get typingUserId => _isTypingMap['user']['_id'] ?? '';
  addAll(List<Message> messages) {
    _messages.addAll(messages);
    notifyListeners();
  }

  setTyping(Map<String, dynamic> isTyping) {
    _isTypingMap = isTyping;
    notifyListeners();
  }

  updateMessages(List<Message> messages) {
    _messages.clear();

    _messages.addAll(messages);
    notifyListeners();
  }

  addNewMessage(Message message, String roomId) {
    _messages.add(message);
    notifyListeners();
  }

  removeMessage(String messageId) {
    _messages.removeWhere((element) => element.id == messageId);
    notifyListeners();
  }
}
