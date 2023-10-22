import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../Widgets/buttons.dart';

class FollowSomeonePage extends StatefulWidget {
  const FollowSomeonePage({super.key});

  @override
  State<FollowSomeonePage> createState() => _FollowSomeonePageState();
}

class _FollowSomeonePageState extends State<FollowSomeonePage> {
  TextEditingController searchFriend = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 4, left: 8, right: 8, top: 0),
        child: MyElevatedButton1(
            title: "Continue", onPressed: () {}, ctx: context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          "Follow Someone",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w300,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Text(
              'Follow someone you might know or you can skip them too',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: searchFriend,
              onChanged: (value) {},
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.surface),
              decoration: InputDecoration(
                filled: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    Ionicons.search,
                    size: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Search",
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
                focusColor: Theme.of(context).colorScheme.primary,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
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
                        "Occupation",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      trailing: MyEleButtonsmall(
                        title: "Follow",
                        onPressed: () {},
                        ctx: context,
                        title2: "Following",
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
