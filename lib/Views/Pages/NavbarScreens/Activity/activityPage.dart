import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/activityPageProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/activityModels.dart';
import 'package:socioverse/Services/activity_services.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityWidgets.dart';

import '../../../Widgets/buttons.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ActivityPageProvider>(context, listen: false)
          .getLatestFollowRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Activity",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: Consumer<ActivityPageProvider>(builder: (context, prov, child) {
        return prov.isLoading
            ? Center(
                child: SpinKit.ring,
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      prov.latestFollowRequestModel.followRequestCount == 0
                          ? const SizedBox.shrink()
                          : RequestsTile(
                              latestFollowRequestModel:
                                  prov.latestFollowRequestModel,
                              onTap: prov.getLatestFollowRequest,
                            ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return LikedTile(
                            name: "Fatima",
                            postUrl: "assets/Country_flag/in.png",
                            imgUrl: "assets/Country_flag/in.png",
                            dateTime: DateTime(2023, 7, 20, 12, 0),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
