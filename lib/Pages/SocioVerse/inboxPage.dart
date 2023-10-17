import 'package:socioverse/Pages/SocioVerse/chatPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../Widgets/buttons.dart';
import '../../Widgets/textfield_widgets.dart';

class InboxPage extends StatefulWidget {
  const InboxPage({super.key});

  @override
  State<InboxPage> createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  TextEditingController search = TextEditingController();

  String getTimeDiff(DateTime dateTime) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);
    int hoursAgo = difference.inHours;
    String time = '';
    if (hoursAgo == 1) {
      time = '1 hour';
    } else if (hoursAgo < 24) {
      time = '$hoursAgo hours';
    } else {
      int daysAgo = difference.inDays;
      time = '$daysAgo days';
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Inbox",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldBuilder(
                tcontroller: search,
                hintTexxt: "Search",
                onChangedf: () {},
                prefixxIcon: Icon(
                  Ionicons.search,
                  size: 20,
                  color: Theme.of(context).colorScheme.surface,
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "Messages",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String time = getTimeDiff(DateTime(2023, 7, 20, 12, 0));
                return ListTile(
                  onTap: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: ((context) {
                      return ChatPage();
                    })));
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage(
                          "assets/Country_flag/in.png",
                        )),
                  ),
                  title: Text(
                    "Fatima",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                  subtitle: Text(
                    "Last message",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                  trailing: Column(
                    children: [
                      SizedBox(
                        height: 7,
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: Text(
                          "1",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        time,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 10,
                            ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      )),
    );
  }
}
