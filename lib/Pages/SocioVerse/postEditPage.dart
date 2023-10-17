import 'package:socioverse/Widgets/textfield_widgets.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class PostEditPage extends StatefulWidget {
  const PostEditPage({super.key});

  @override
  State<PostEditPage> createState() => _PostEditPageState();
}

class _PostEditPageState extends State<PostEditPage> {
  bool autoEnhance = false;
  bool public = false;
  bool allowComments = false;
  bool allowSave = false;

  @override
  void initState() {
    autoEnhance = true;
    public = true;
    allowComments = true;
    allowSave = true;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "New Post",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.paper_plane,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              )),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image: AssetImage("assets/Country_flag/in.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFieldBuilder2(
                            tcontroller: TextEditingController(),
                            hintTexxt: "Write a caption...",
                            onChangedf: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add_a_photo,
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey[600],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.person_add,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Tag People",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.location,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Add Location",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.grey[600],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Additional Features"),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.sparkles,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Auto Enhance",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    trailing: Switch(
                      value: autoEnhance,
                      onChanged: (value) {
                        setState(() {
                          autoEnhance = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.people,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Public",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    trailing: Switch(
                      value: public,
                      onChanged: (value) {
                        setState(() {
                          public = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.chatbubble_ellipses,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Allow Comments",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    trailing: Switch(
                      value: allowComments,
                      onChanged: (value) {
                        setState(() {
                          allowComments = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: Icon(
                      Ionicons.bookmark_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    title: Text(
                      "Allow Save",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    trailing: Switch(
                      value: allowSave,
                      onChanged: (value) {
                        setState(() {
                          allowSave = value;
                        });
                      },
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ))),
    );
  }
}
