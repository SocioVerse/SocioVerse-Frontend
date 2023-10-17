import 'package:socioverse/Pages/AccountSetup/SelectCountry.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

import '../../Widgets/buttons.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  final StoryController storyController = StoryController();
  TextEditingController storyMessage = TextEditingController();
  TextEditingController search = TextEditingController();
  TextField textFieldBuilder({
    required TextEditingController tcontroller,
    required String hintTexxt,
    required Function onChangedf,
    Widget? prefixxIcon,
  }) {
    return TextField(
      controller: tcontroller,
      onChanged: (value) {
        onChangedf();
      },
      cursorOpacityAnimates: true,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, color: Theme.of(context).colorScheme.surface),
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon: prefixxIcon,
        contentPadding: EdgeInsets.all(20),
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        hintText: hintTexxt,
        hintStyle:
            Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 16),
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
        focusColor: Theme.of(context).colorScheme.primary,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Stack(
                children: [
                  StoryView(
                    storyItems: [
                      StoryItem.text(
                        title:
                            "I guess you'd love to see more of our food. That's great.",
                        backgroundColor: Colors.blue,
                      ),
                      StoryItem.text(
                        title: "Nice!\n\nTap to continue.",
                        backgroundColor: Colors.red,
                        textStyle: TextStyle(
                          fontFamily: 'Dancing',
                          fontSize: 40,
                        ),
                      ),
                    ],
                    onStoryShow: (s) {
                      print("Showing a story");
                    },
                    onComplete: () {
                      Navigator.pop(context);
                    },
                    progressPosition: ProgressPosition.top,
                    repeat: false,
                    controller: storyController,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).colorScheme.onBackground,
                        child: Icon(
                          Ionicons.person,
                          color: Theme.of(context).colorScheme.background,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        "Username",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      subtitle: Text(
                        "Occupation",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              context: context,
                              builder: (context) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Icon(
                                      Icons.horizontal_rule_rounded,
                                      size: 50,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                                    ListTile(
                                      leading: const Icon(
                                        Ionicons.warning,
                                        color: Colors.red,
                                      ),
                                      title: Text(
                                        'Report',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 16),
                                      ),
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading: Icon(Ionicons.copy_outline),
                                      title: Text(
                                        'Copy Link',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 16),
                                      ),
                                      onTap: () {},
                                    ),
                                    ListTile(
                                      leading: Icon(Ionicons.send),
                                      title: Text(
                                        'Share to...',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 16),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                                topRight: Radius.circular(20),
                                              ),
                                            ),
                                            backgroundColor: Theme.of(context)
                                                .scaffoldBackgroundColor,
                                            context: context,
                                            builder: (context) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15.0, right: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .horizontal_rule_rounded,
                                                      size: 50,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    textFieldBuilder(
                                                      tcontroller: storyMessage,
                                                      hintTexxt:
                                                          "Write a message...",
                                                      onChangedf: () {},
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                      child: Divider(
                                                        height: 10,
                                                      ),
                                                    ),
                                                    textFieldBuilder(
                                                        tcontroller: search,
                                                        hintTexxt: "Search",
                                                        onChangedf: () {},
                                                        prefixxIcon: Icon(
                                                          Ionicons.search,
                                                          size: 20,
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .surface,
                                                        )),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Expanded(
                                                      child: ListView.builder(
                                                          shrinkWrap: true,
                                                          itemCount: 10,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary,
                                                                child:
                                                                    CircleAvatar(
                                                                        radius:
                                                                            28,
                                                                        backgroundImage:
                                                                            AssetImage(
                                                                          "assets/Country_flag/in.png",
                                                                        )),
                                                              ),
                                                              title: Text(
                                                                "Fatima",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      fontSize:
                                                                          16,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .colorScheme
                                                                          .onPrimary,
                                                                    ),
                                                              ),
                                                              subtitle: Text(
                                                                "Occupation",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                    ),
                                                              ),
                                                              trailing:
                                                                  MyEleButtonsmall(
                                                                      title2:
                                                                          "Sent",
                                                                      title:
                                                                          "Send",
                                                                      onPressed:
                                                                          () {},
                                                                      ctx:
                                                                          context),
                                                            );
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                    ListTile(
                                      leading: new Icon(Ionicons.volume_mute),
                                      title: Text(
                                        'Mute',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 16),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: Icon(
                          Ionicons.ellipsis_horizontal_circle_outline,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TextField(
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.surface),
              obscureText: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Send Message...",
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 16),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Ionicons.send,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                ),
                focusColor: Theme.of(context).colorScheme.primary,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
