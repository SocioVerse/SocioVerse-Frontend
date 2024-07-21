import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/postEditingProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/inboxModel.dart';
import 'package:socioverse/Services/stories_services.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

class StoryHideSettingsPage extends StatefulWidget {
  StoryHideSettingsPage({super.key});

  @override
  State<StoryHideSettingsPage> createState() => _StoryHideSettingsPageState();
}

class _StoryHideSettingsPageState extends State<StoryHideSettingsPage> {
  Widget personListTile({
    required User user,
    required BuildContext context,
    required Function onTap,
  }) {
    return ListTile(
        onTap: () {},
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 40,
            width: 40,
            child: CircularNetworkImageWithSize(
              imageUrl: user.profilePic,
              height: 35,
              width: 35,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
        subtitle: Text(
          user.username,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12,
              ),
        ),
        trailing: InkWell(
          onTap: () {
            onTap();
          },
          child: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Story Hide Settings",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
            ),
            toolbarHeight: 60,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FutureBuilder<List<User>>(
              future: StoriesServices().fetchAllStoryHiddenUsers(),
              // initialData: const [],
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKit.ring,
                  );
                }

                if (snapshot.hasData) {
                  List<User>? data = snapshot.data;
                  log(data.toString());
                  if (data == null || data.isEmpty) {
                    return const Center(
                      child: Text("No Data Found"),
                    );
                  }

                  return StatefulBuilder(builder: (context, innerSetState) {
                    if (data.isEmpty) {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return personListTile(
                            user: data[index],
                            context: context,
                            onTap: () {
                              StoriesServices()
                                  .unhideStory(userId: data[index].id);
                              data.removeAt(index);
                              innerSetState(() {});
                            });
                      },
                    );
                  });
                }

                return const Center(
                  child: Text("No Data Found"),
                );
              },
            ),
          )),
    );
  }
}
