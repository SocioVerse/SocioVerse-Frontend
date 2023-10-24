import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/main.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Widget postMessage(String postId, bool sender) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MyApp.width! / 2),
          margin: EdgeInsets.symmetric(
            vertical: 7,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: !sender
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
                  child: CircleAvatar(
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
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/Country_flag/in.png",
                  fit: BoxFit.cover,
                  height: MyApp.width! / 2,
                  width: MyApp.width! / 2,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget textMessage(String text, bool sender) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          sender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: MyApp.width! / 2),
          margin: EdgeInsets.symmetric(
            vertical: 2,
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: !sender
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            maxLines: null,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Icon(
            Ionicons.checkmark_circle_outline,
            size: 15,
            color: Theme.of(context).colorScheme.primary,
          ),
        )
      ],
    );
  }

  TextEditingController message = TextEditingController();
  ScrollController scrollChat = ScrollController();
  List<Map<String, dynamic>> newMessages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage(
                    "assets/Country_flag/in.png",
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Name",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
          ],
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.call_outline,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Ionicons.videocam_outline,
              size: 25,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      body: Column(children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            controller: scrollChat,
            itemCount: newMessages.length,
            itemBuilder: (context, index) {
              return textMessage(
                  newMessages[index]['message'], newMessages[index]['sender']);
            },
          ),
        )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  controller: message,
                  onChanged: (value) {},
                  cursorOpacityAnimates: true,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.surface),
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.all(20),
                    fillColor: Theme.of(context).colorScheme.secondary,
                    hintText: "Type message...",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontSize: 16),
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
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    if (message.text.trim() != "") {
                      setState(() {
                        newMessages
                            .add({'sender': true, 'message': message.text});
                        scrollChat.jumpTo(
                          scrollChat.position.maxScrollExtent,
                        );
                        message.clear();
                      });
                    }
                  },
                  icon: Icon(
                    Ionicons.send,
                    size: 25,
                    color: Theme.of(context).colorScheme.primary,
                  ))
            ],
          ),
        ),
      ]),
    );
  }
}
