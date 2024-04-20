import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/Widget/newThreadWidgetProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewThread/newThread.dart';
import 'package:socioverse/Views/Pages/SocioVerse/MainPage.dart';
import 'package:socioverse/Services/thread_services.dart';

class CreateNewThreadAlertBox extends StatelessWidget {
  final List<ThreadData> threads;
  const CreateNewThreadAlertBox({super.key, required this.threads});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actionsPadding: const EdgeInsets.all(20),
      title: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Create thread',
                  style: TextStyle(
                    fontSize: 18.5,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
              const Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Ionicons.close,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
          Divider(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ],
      ),
      content: Row(
        children: [
          Text("Private thread",
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          const Spacer(),
          Consumer<CreateNewThreadAlertBoxProvider>(
              builder: (context, prov, child) {
            return Switch(
              value: prov.privateThread,
              onChanged: (value) {
                prov.privateThread = value;
              },
              activeTrackColor: Theme.of(context).colorScheme.onPrimary,
              activeColor: Theme.of(context).colorScheme.primary,
            );
          }),
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
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    side: BorderSide(
                        width: 1,
                        color: Theme.of(context).colorScheme.primary,
                        style: BorderStyle.solid),
                  ),
                  onPressed: () async {
                    CreateThreadModel createThreadModel = CreateThreadModel(
                      content: threads[0].textEditingController.text,
                      images: threads[0].images,
                      isPrivate: Provider.of<CreateNewThreadAlertBoxProvider>(
                              context,
                              listen: false)
                          .privateThread,
                      isBase: true,
                      comments: [],
                    );
                    for (int i = 1; i < threads.length; i++) {
                      final thread = threads[i];
                      log(thread.textEditingController.text.toString());
                      createThreadModel.comments.add(CommentModel(
                        content: thread.textEditingController.text,
                        images: thread.images,
                      ));
                    }
                    showDialog(context: context, builder: (_) => SpinKit.ring);
                    await ThreadServices()
                        .createThread(createThreadModel: createThreadModel)
                        .then((value) {
                      Provider.of<CreateNewThreadAlertBoxProvider>(context,
                              listen: false)
                          .privateThread = false;
                      Navigator.pop(context);
                      Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const MainPage()),
                        (route) => route.isFirst,
                      );
                    });
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.onPrimary,
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
