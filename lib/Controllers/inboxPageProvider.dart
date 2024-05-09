import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_constants.dart';
import 'package:socioverse/Helper/SharedPreference/shared_preferences_methods.dart';
import 'package:socioverse/Models/chatModels.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Services/inbox_services.dart';
import 'package:socioverse/Sockets/messageSockets.dart';

class InboxPageLoadingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isUserFetched = false;
  bool get isLoading => _isLoading;
  bool get isUserFetched => _isUserFetched;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  set isUserFetched(bool value) {
    _isUserFetched = value;
    notifyListeners();
  }
}

class InboxPageProvider extends ChangeNotifier {
  List<InboxModel> _inboxModel = [];
  List<InboxModel> _requestModel = [];
  String? _userId;

  String? get userId => _userId;
  List<InboxModel> get inboxModel => _inboxModel;
  List<InboxModel> get requestModel => _requestModel;

  set inboxModel(List<InboxModel> value) {
    _inboxModel = value;
    notifyListeners();
  }

  void init(BuildContext context, {bool setInboxListners = true}) async {
    Provider.of<InboxPageLoadingProvider>(context, listen: false).isLoading =
        true;
    userId = await getStringFromCache(SharedPreferenceString.userId);
    inboxModel = await InboxServices().fetchInbox(context);
    requestModel =
        inboxModel.where((element) => element.isRequestMessage).toList();
    inboxModel.removeWhere((element) => element.isRequestMessage);
    if (!context.mounted) return;
    Provider.of<InboxPageLoadingProvider>(context, listen: false).isLoading =
        false;
    if (setInboxListners) {
      MessagesSocket(context).setInboxListners();
    }
  }

  void addInbox(InboxModel inboxModel, {bool isRequestMessage = false}) {
    if (isRequestMessage) {
      log(_requestModel.length.toString() + 'request');
      _requestModel.add(inboxModel);
      log(_requestModel.length.toString() + 'request');
    } else {
      _inboxModel.add(inboxModel);
    }

    notifyListeners();
  }

  void requestToInbox(String inboxModelId) {
    log('inboxModelId$inboxModelId');
    _inboxModel.add(
        _requestModel.where((element) => element.id == inboxModelId).first);
    _requestModel.removeWhere((element) => element.id == inboxModelId);
    log('${requestModel.length}request');
    notifyListeners();
  }

  void deleteInbox(String roomId) {
    if (_inboxModel
        .where(
          (element) => element.roomId == roomId,
        )
        .isNotEmpty) {
      _inboxModel.removeWhere((element) => element.roomId == roomId);
      notifyListeners();
      return;
    }
    _requestModel.removeWhere((element) => element.roomId == roomId);
    notifyListeners();
  }

  void updateInbox(BuildContext context, data,
      {bool isFirstMessage = false}) async {
    log('data' + data.toString());

    if (_inboxModel
        .where(
          (element) => element.roomId == data['roomId'],
        )
        .isNotEmpty) {
      InboxModel ibxM =
          _inboxModel.firstWhere((element) => element.roomId == data['roomId']);
      if (data['lastMessage'] != null) {
        ibxM.lastMessage = LastMessage.fromJson(data['lastMessage']);
        ibxM.unreadMessages =
            userId == ibxM.lastMessage!.sentBy ? 0 : data['unSeenMessages'];
      } else {
        _inboxModel.removeWhere((element) => element.roomId == data['roomId']);
      }
      notifyListeners();
      return;
    }
    if (_requestModel
        .where(
          (element) => element.roomId == data['roomId'],
        )
        .isNotEmpty) {
      InboxModel ibxM = _requestModel
          .firstWhere((element) => element.roomId == data['roomId']);
      if (data['lastMessage'] != null) {
        ibxM.lastMessage = LastMessage.fromJson(data['lastMessage']);
        ibxM.unreadMessages =
            userId == ibxM.lastMessage!.sentBy ? 0 : data['unSeenMessages'];
      } else {
        _requestModel
            .removeWhere((element) => element.roomId == data['roomId']);
      }
    }
    notifyListeners();
  }

  set requestModel(List<InboxModel> value) {
    _requestModel = value;
    notifyListeners();
  }

  set userId(String? value) {
    _userId = value;
    notifyListeners();
  }
}
