import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/threadModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/UserProfileDetails/userProfileWidgets.dart';
import 'package:socioverse/Services/thread_services.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  bool isSavedThreadLoading = false;
  bool isSavedPostLoading = false;
  List<ThreadModel> savedThreads = [];
  Key _refreshKey = UniqueKey();
  @override
  void initState() {
    getSavedThreads();
    super.initState();
  }

  getSavedThreads() async {
    setState(() {
      isSavedThreadLoading = true;
    });
    savedThreads = await ThreadServices().getSavedThreads();
    setState(() {
      _refreshKey = UniqueKey();
      isSavedThreadLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text(
            "Saved",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
          ),
          bottom: TabBar(
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.onPrimary,
            indicatorColor: Theme.of(context).colorScheme.primary,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 3,
            dividerColor: Theme.of(context).colorScheme.onPrimary,
            onTap: (value) {
              if (value == 1) {
                getSavedThreads();
              }
            },
            tabs: const [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.text,
                      size: 20,
                    ),
                    SizedBox(width: 5), // Add spacing between icon and text
                    Text("Threads"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Ionicons.grid_outline,
                      size: 20,
                    ),
                    SizedBox(width: 5), // Add spacing between icon and text
                    Text("Posts"),
                  ],
                ),
              ),
            ],
          ),
          toolbarHeight: 70,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: AutoScaleTabBarView(
            physics: NeverScrollableScrollPhysics(),
            key: _refreshKey,
            children: [
              isSavedThreadLoading
                  ? const Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: SpinKitRing(
                          color: Colors.white,
                          lineWidth: 1,
                          duration: Duration(seconds: 1),
                        )),
                      ],
                    )
                  : ThreadViewBuilder(
                      allThreads: savedThreads,
                      shrinkWrap: true,
                    ),
              GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemCount: 100,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          image: AssetImage(
                            "assets/Country_flag/in.png",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
