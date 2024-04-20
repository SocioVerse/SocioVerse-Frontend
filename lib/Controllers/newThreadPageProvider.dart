import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socioverse/Helper/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Models/userModel.dart';
import 'package:uuid/uuid.dart';

class NewThreadPageProvider extends ChangeNotifier {
  bool _showAddThread = false; //
  List<ThreadData> _threads = []; //
  List<FocusNode> _focusNodes = []; //
  List<UserModel> _user = []; //

  bool get showAddThread => _showAddThread; //
  List<ThreadData> get threads => _threads; //
  List<FocusNode> get focusNodes => _focusNodes; //
  List<UserModel> get user => _user; //

  void init() {
    _showAddThread = false;
    _threads = [];
    _focusNodes = [];
    _user = [];
    notifyListeners();
  }

  set showAddThread(bool value) {
    _showAddThread = value;
    notifyListeners();
  }

  set threads(List<ThreadData> value) {
    _threads = value;
    notifyListeners();
  }

  set focusNodes(List<FocusNode> value) {
    _focusNodes = value;
    notifyListeners();
  }

  set user(List<UserModel> value) {
    _user = value;
    notifyListeners();
  }

  void addFocusNode(FocusNode focusNode) {
    _focusNodes.add(focusNode);
    notifyListeners();
  }

  void addThread(ThreadData thread) {
    _threads.add(
      thread,
    );
    notifyListeners();
  }

  void removeThread(int index) {
    _threads.removeAt(index);
    _focusNodes.removeAt(index);
    notifyListeners();
  }

  void addImage(int index, String image) {
    _threads[index].images.add(image);
    notifyListeners();
  }

  void updateLineCount(int index, BuildContext context) {
    if (index < threads.length) {
      final thread = threads[index];
      final textPainter = TextPainter(
        text: TextSpan(
          text: thread.textEditingController.text,
          style: const TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 100,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 80);
      final newLineCount = textPainter.computeLineMetrics().length;
      if (newLineCount - thread.line == 1) {
        thread.line++;
        thread.verticalDividerLength += 20;
      } else if (thread.line - newLineCount == 1 && newLineCount != 0) {
        thread.line--;
        thread.verticalDividerLength -= 20;
      }
      notifyListeners();
    }
  }

  void addNewThread(BuildContext context) {
    final TextEditingController newController = TextEditingController();
    newController.addListener(() {
      updateLineCount(_threads.length, context);
    });
    for (final thread in _threads) {
      thread.isSelected = false;
    }
    _threads.add(ThreadData(
      line: 1,
      isSelected: true,
      textEditingController: newController,
      verticalDividerLength: 45,
      images: [],
    ));
    _focusNodes.add(FocusNode());
    FocusScope.of(context).requestFocus(_focusNodes[threads.length - 1]);
    _showAddThread = false;

    notifyListeners();
  }

  void onRemoval(String id) {
    ThreadData thread = _threads.firstWhere((element) => element.id == id);
    thread.textEditingController.clear();
    for (int i = 0; i < thread.images.length; i++) {
      thread.images.removeAt(i);
    }
    thread.verticalDividerLength = 45;
    thread.line = 1;
    thread.isSelected = true;
    _showAddThread = false;
    notifyListeners();
  }

  void onWritting(String id, int index) {
    ThreadData thread = _threads.firstWhere((element) => element.id == id);
    for (final thread in threads) {
      thread.isSelected = false;
    }
    thread.isSelected = true;
    focusNodes[index].requestFocus();
    notifyListeners();
  }

  Future<void> removeImage(int index, List<File>? images) async {
    ThreadData thread = _threads[index];
    if (images != null) {
      thread.isUploading = true;
      showAddThread = true;
      if (thread.images.length % 3 == 0) {
        thread.verticalDividerLength += (100);
      }
      for (int i = 0; i < images.length; i++) {
        String url = await FirebaseHelper.uploadFile(
            images[i].path,
            const Uuid().v4(),
            "${_user[0].email}/threads",
            FirebaseHelper.Image);
        thread.images.add(url);
      }
    }
    thread.isUploading = false;
    notifyListeners();
  }

  void removeImageFromList(int index) {
    ThreadData thread = _threads[index];
    if (thread.images.length % 3 == 1) {
      thread.verticalDividerLength -= (100);
      showAddThread = false;
    }
    thread.images.removeAt(index);
    notifyListeners();
  }
}
