import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Feeds/feedWidgets.dart';
import 'package:socioverse/Views/Pages/SocioVerse/Inbox/inboxPage.dart';

import '../../../Widgets/feeds_widget.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  State<FeedsPage> createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> with TickerProviderStateMixin {
  bool _showAppbar = true;
  final ScrollController _scrollController = ScrollController();
  double _previousOffset = 0;
  @override
  void initState() {
    _showAppbar = true;
    _scrollController.addListener(() {
      _scrollListener();
    });
    super.initState();
  }

  void _scrollListener() {
    if (_scrollController.offset > _previousOffset) {
      // User is scrolling downward, hide the app bar
      if (_showAppbar) {
        setState(() {
          _showAppbar = false;
        });
      }
    } else {
      // User is scrolling upward, show the app bar
      if (!_showAppbar) {
        setState(() {
          _showAppbar = true;
        });
      }
    }
    _previousOffset = _scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              expandedHeight: 70,
              floating:
                  true, // Set this to true to make AppBar scroll with content
              pinned:
                  false, // Set this to false to allow AppBar to fully collapse
              title: Text("SocioVerse",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                      )),
              actions: [
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       _enableThread = !_enableThread;
                //     });
                //   },
                //   icon: Icon(Ionicons.link),
                // ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: ((context) {
                      return InboxPage();
                    })));
                  },
                  icon: Icon(Ionicons.chatbubble_ellipses_outline),
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  const SizedBox(
                    width: 10,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: StoriesScroller(),
                  ),
                  Divider(
                    thickness: 1,
                    height: 0,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  FeedViewBuilder(),
                  // Add more widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
