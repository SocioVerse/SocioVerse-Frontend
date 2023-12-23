import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/SocioThread/NewThread/newThread.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/services/thread_services.dart';


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

class CreateNewThreadAlertBox extends StatefulWidget {
  List<ThreadData> threads;
  CreateNewThreadAlertBox({required this.threads});

  @override
  State<CreateNewThreadAlertBox> createState() => _CreateNewThreadAlertBoxState();
}

class _CreateNewThreadAlertBoxState extends State<CreateNewThreadAlertBox> {
  
  bool _privateThread = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                                  surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
                                  
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
                                      Text('Create thread',
                                          style: TextStyle(
                                            fontSize: 18.5,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          )),
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
                                  Text("Private thread",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )),
                                  const Spacer(),
                                  Switch(
                                    value: _privateThread,
                                    onChanged: (value) {
                                      setState(() {
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
                                              content: widget.threads[0]
                                                  .textEditingController
                                                  .text,
                                              images: widget.threads[0].images,
                                              isPrivate: _privateThread,
                                              isBase: true,
                                              comments: [],
                                            );
                                            for (int i = 1;
                                                i < widget.threads.length;
                                                i++) {
                                              final thread = widget.threads[i];
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
                                                     SpinKitRing(color: Theme.of(context).colorScheme.tertiary,lineWidth: 1,duration: const Duration(seconds: 1),));
                                            await ThreadServices().createThread(
                                                createThreadModel:
                                                    createThreadModel).then((value) {
                                            Navigator.pop(context);
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              CupertinoPageRoute(
                                                  builder: (context) =>
                                                      MainPage()),
                                              (route) => route.isFirst,
                                            );
                                            });
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
                                          child: Text('Cancel',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
  }
}