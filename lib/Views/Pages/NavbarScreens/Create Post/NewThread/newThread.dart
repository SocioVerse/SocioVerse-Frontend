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
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThreadWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/helpers/FirebaseHelper/firebaseHelperFunctions.dart';
import 'package:socioverse/helpers/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Services/thread_services.dart';
import 'package:socioverse/Services/user_services.dart';
import 'package:uuid/uuid.dart';

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

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
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
          style: const TextStyle(fontSize: 15),
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
        ? Scaffold(
            body: SpinKitRing(
            color: Theme.of(context).colorScheme.tertiary,
            lineWidth: 1,
            duration: const Duration(seconds: 1),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF1a1a22),
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
                        builder: ((ctx) {
                          return CreateNewThreadAlertBox(threads: threads);
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
                                CircularNetworkImageWithSize(
                                  imageUrl: user[0].profilePic,
                                  height: 35,
                                  width: 35,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
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
                              margin: const EdgeInsets.only(left: 15),
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
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      thread.textEditingController.text.isEmpty
                                          ? const SizedBox(width: 1)
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                                    style: const TextStyle(
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
                                          const EdgeInsets.symmetric(
                                              vertical: 5),
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
                                  const SizedBox(height: 0),
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
                                                RoundedNetworkImageWithLoading(
                                                  imageUrl:
                                                      thread.images[index],
                                                  borderRadius:
                                                      5, // Set the desired border radius
                                                  fit: BoxFit.cover,
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
                                                    icon: const Icon(
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
                                          padding:
                                              const EdgeInsets.only(top: 12),
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
                                                          "${const Uuid().v4()}",
                                                          "${user[0].email}/threads",
                                                          FirebaseHelper.Image);
                                                  thread.images.add(url);
                                                }
                                              }
                                              setState(() {
                                                thread.isUploading = false;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.photo_library_rounded,
                                              color: Color.fromARGB(
                                                  137, 245, 201, 201),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(height: 0),
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
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: CircularNetworkImageWithSize(
                          imageUrl: user[0].profilePic,
                          height: 20,
                          width: 20,
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
