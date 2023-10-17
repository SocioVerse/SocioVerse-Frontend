import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CommentLayout extends StatefulWidget {
  CommentLayout({super.key, required BuildContext context});
  late BuildContext context;

  @override
  State<CommentLayout> createState() => _CommentLayoutState();
}

class _CommentLayoutState extends State<CommentLayout> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
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
            trailing: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget nunc vitae tortor aliquam aliquet. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Ionicons.heart_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1.2k",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Reply",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "6 hrs ago",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class CommentBuilder extends StatelessWidget {
  const CommentBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return CommentLayout(
          context: context,
        );
      },
    );
  }
}

class PostCaption extends StatelessWidget {
  const PostCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
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
            trailing: Icon(
              Ionicons.ellipsis_horizontal_circle_outline,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                        width: 2))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eget nunc vitae tortor aliquam aliquet. ",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "6 hrs ago",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Ionicons.heart_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1.2k",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Ionicons.chatbubble_ellipses_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "1.2k",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentFeild extends StatelessWidget {
  const CommentFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          border: Border.all(color: Color(0xff2A2B39)),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).colorScheme.background,
                blurRadius: 10,
                offset: const Offset(0, 10))
          ]),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) {},
              cursorOpacityAnimates: true,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16, color: Theme.of(context).colorScheme.surface),
              decoration: InputDecoration(
                filled: true,
                contentPadding: const EdgeInsets.all(20),
                fillColor: Theme.of(context).colorScheme.secondary,
                hintText: "Your comment...",
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
          TextButton(
            onPressed: () {},
            child: Text('Post',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
