import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/feedPage.dart';
import 'package:socioverse/Views/Pages/SocioVerse/inboxPage.dart';
import 'package:socioverse/Views/Widgets/feeds_widget.dart';

class ThreadPage extends StatefulWidget {
  const ThreadPage({super.key});

  @override
  State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  bool _showAppbar = true;
  bool _isThread = false;
  final ScrollController _scrollController = ScrollController();
  double _previousOffset = 0;
  @override
  void initState() {
    _showAppbar = true;
    _isThread = false;
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
              title: Text("SocioThread",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                      )),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, 
                    CupertinoPageRoute(builder: ((context) {
                      return FeedsPage();
                    })));
                  },
                  icon: Icon(Ionicons.grid),
                ),
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                         ThreadViewBuilder(),
                      ],
                      
                    
                  ),
                  ),
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
