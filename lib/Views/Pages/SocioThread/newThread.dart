import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pinput/pinput.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Models/userModel.dart';
import 'package:socioverse/Models/userSignUpModel.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/services/thread_services.dart';
import 'package:socioverse/services/user_services.dart';
import 'package:uuid/uuid.dart';

class ThreadData {
  int line;
  late bool isSelected;
  late TextEditingController textEditingController;
  double verticalDividerLength;
  List<String> images;
  bool isUploading = false;

  ThreadData(
      {required this.line,
      required this.isSelected,
      required this.textEditingController,
      required this.verticalDividerLength,
      required this.images});
}

class NewThread extends StatefulWidget {
  const NewThread({super.key});

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  // Start with 1 line
  bool _showAddThread = false;
  List<ThreadData> threads = [];
  List<FocusNode> focusNodes = [];
  bool _privateThread = false;
  List<UserModel> user = [];
  @override
  void initState() {
    super.initState();
    fetchUserdata();

    threads.add(ThreadData(
      line: 1,
      isSelected: true,
      textEditingController: TextEditingController(),
      verticalDividerLength: 45,
      images: [],
    ));
    for (int i = 0; i < threads.length; i++) {
      focusNodes.add(FocusNode());
    }
  }

  void fetchUserdata() async {
    user = await UserServices().getUserDetails();
    setState(() {});
  }

  void updateLineCount(int index) {
    if (index < threads.length) {
      final thread = threads[index];
      final textPainter = TextPainter(
        text: TextSpan(
          text: thread.textEditingController.text,
          style: TextStyle(fontSize: 15),
        ),
        textDirection: TextDirection.ltr,
        maxLines: 100,
      );
      textPainter.layout(maxWidth: MediaQuery.of(context).size.width - 80);
      final newLineCount = textPainter.computeLineMetrics().length;
      if (newLineCount - thread.line == 1) {
        setState(() {
          thread.line++;
          thread.verticalDividerLength += 20;
        });
      } else if (thread.line - newLineCount == 1 && newLineCount != 0) {
        setState(() {
          thread.line--;
          thread.verticalDividerLength -= 20;
        });
      }
    }
  }

  void addNewThread() {
    final TextEditingController newController = TextEditingController();
    newController.addListener(() {
      updateLineCount(threads.length);
    });
    setState(() {
      for (final thread in threads) {
        thread.isSelected = false;
      }
      threads.add(ThreadData(
        line: 1,
        isSelected: true,
        textEditingController: newController,
        verticalDividerLength: 45,
        images: [],
      ));
      focusNodes.add(FocusNode());
      FocusScope.of(context).requestFocus(focusNodes[threads.length - 1]);
      _showAddThread = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return user.isEmpty
        ? const Scaffold(
            body:
                SpinKitWave(color: Colors.white, type: SpinKitWaveType.center))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF1a1a22),
              elevation: 0.15,
              automaticallyImplyLeading: false,
              shadowColor: Colors.white,
              title: const Text(
                'New thread',
                style: TextStyle(
                  fontSize: 18.5,
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: ((context) {
                          return StatefulBuilder(
                              builder: (context, innerSetState) {
                            return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              actionsPadding: EdgeInsets.all(20),
                              title: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text('Create thread'),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Ionicons.close,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ],
                              ),
                              content: Row(
                                children: [
                                  Text("Private thread"),
                                  const Spacer(),
                                  Switch(
                                    value: _privateThread,
                                    onChanged: (value) {
                                      innerSetState(() {
                                        _privateThread = value;
                                      });
                                    },
                                    activeTrackColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                    activeColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
                              actions: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            side: BorderSide(
                                                width: 1,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                style: BorderStyle.solid),
                                          ),
                                          onPressed: () async {
                                            CreateThreadModel
                                                createThreadModel =
                                                CreateThreadModel(
                                              content: threads[0]
                                                  .textEditingController
                                                  .text,
                                              images: threads[0].images,
                                              isPrivate: _privateThread,
                                              isBase: true,
                                              comments: [],
                                            );
                                            for (int i = 1;
                                                i < threads.length;
                                                i++) {
                                              final thread = threads[i];
                                              log(thread
                                                  .textEditingController.text
                                                  .toString());
                                              createThreadModel.comments
                                                  .add(CommentModel(
                                                content: thread
                                                    .textEditingController.text,
                                                images: thread.images,
                                              ));
                                            }
                                            showDialog(
                                                context: context,
                                                builder: (_) =>
                                                    const SpinKitWave(
                                                        color: Colors.white,
                                                        type: SpinKitWaveType
                                                            .center));
                                            await ThreadServices().createThread(
                                                createThreadModel:
                                                    createThreadModel);
                                            Navigator.pop(context);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      MainPage()),
                                              (route) => route.isFirst,
                                            );
                                          },
                                          child: Text(
                                            'Post',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          });
                        }));
                  },
                  icon: Icon(
                    Icons.post_add,
                    size: 23,
                    color: threads[0].textEditingController.text.isNotEmpty
                        ? Colors.white
                        : Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: threads.asMap().entries.map((entry) {
                      final index = entry.key;
                      final thread = entry.value;
                      return Padding(
                        key: ValueKey<int>(index),
                        padding:
                            const EdgeInsets.only(left: 12, right: 12, top: 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                    user[0].profilePic,
                                    height: 35,
                                    width: 35,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  height: thread.isSelected
                                      ? thread.verticalDividerLength
                                      : thread.verticalDividerLength - 38,
                                  width: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              width: MediaQuery.of(context).size.width - 74,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${user[0].username}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      thread.textEditingController.text.isEmpty
                                          ? SizedBox(width: 1)
                                          : Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: GestureDetector(
                                                onTap: () {
                                                  if (threads.length > 1) {
                                                    setState(() {
                                                      threads.removeAt(index);
                                                    });
                                                  } else if (threads.length ==
                                                      1) {
                                                    setState(() {
                                                      thread
                                                          .textEditingController
                                                          .clear();
                                                      for (int i = 0;
                                                          i <
                                                              thread.images
                                                                  .length;
                                                          i++) {
                                                        thread.images
                                                            .removeAt(i);
                                                      }
                                                      thread.verticalDividerLength =
                                                          45;
                                                      thread.line = 1;
                                                      thread.isSelected = true;
                                                      _showAddThread = false;
                                                    });
                                                  }
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 18,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                  TextFormField(
                                    controller: thread.textEditingController,
                                    showCursor: thread.isSelected,
                                    focusNode: focusNodes[index],
                                    autofocus: true,
                                    maxLines: null,
                                    cursorColor: Colors.white,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      hintText: 'Start a thread...',
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                    ),
                                    onChanged: (text) {
                                      updateLineCount(index);
                                      if (threads.last.textEditingController
                                          .text.isNotEmpty) {
                                        setState(() {
                                          _showAddThread = true;
                                        });
                                      } else {
                                        setState(() {
                                          _showAddThread = false;
                                        });
                                      }
                                    },
                                    onTap: () {
                                      for (final thread in threads) {
                                        thread.isSelected = false;
                                      }
                                      setState(() {
                                        thread.isSelected = true;
                                        focusNodes[index].requestFocus();
                                      });
                                    },
                                  ),
                                  SizedBox(height: 0),
                                  thread.isUploading == true
                                      ? LinearProgressIndicator(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          backgroundColor: Colors.grey.shade700,
                                          minHeight: 2,
                                        )
                                      : GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: thread.images.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                          ),
                                          itemBuilder: (context, index) {
                                            return Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: Image.network(
                                                    loadingBuilder: (BuildContext
                                                            context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                                      if (loadingProgress ==
                                                          null) return child;
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      );
                                                    },
                                                    thread.images[index],
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      FirebaseHelper
                                                          .deleteFileByUrl(
                                                              thread.images[
                                                                  index]);
                                                      setState(() {
                                                        if (thread.images
                                                                    .length %
                                                                3 ==
                                                            1) {
                                                          thread.verticalDividerLength -=
                                                              (100);
                                                          _showAddThread =
                                                              false;
                                                        }
                                                        thread.images
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                  thread.isSelected
                                      ? Padding(
                                          padding: EdgeInsets.only(top: 12),
                                          child: GestureDetector(
                                            onTap: () async {
                                              List<File>? images =
                                                  await ImagePickerFunctionsHelper()
                                                      .pickMultipleImage(
                                                          context);

                                              if (images != null) {
                                                setState(() {
                                                  thread.isUploading = true;
                                                  _showAddThread = true;
                                                  if (thread.images.length %
                                                          3 ==
                                                      0) {
                                                    thread.verticalDividerLength +=
                                                        (100);
                                                  }
                                                });
                                                for (int i = 0;
                                                    i < images.length;
                                                    i++) {
                                                  String url = await FirebaseHelper
                                                      .uploadFile(
                                                          images[i].path,
                                                          "${Uuid().v4()}",
                                                          "${user[0].email}/threads");
                                                  thread.images.add(url);
                                                }
                                              }
                                              setState(() {
                                                thread.isUploading = false;
                                              });
                                            },
                                            child: Icon(
                                              Icons.photo_library_rounded,
                                              color: Color.fromARGB(
                                                  137, 245, 201, 201),
                                            ),
                                          ),
                                        )
                                      : SizedBox(height: 0),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_showAddThread) {
                        addNewThread();
                      }
                    },
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 19),
                      minLeadingWidth: 25,
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: ClipOval(
                          child: Image.network(
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            user[0].profilePic,
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      title: Text(
                        'Add to thread',
                        style: TextStyle(
                          fontSize: 14,
                          color: _showAddThread
                              ? Colors.grey
                              : Colors.grey.shade800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
