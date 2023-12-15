import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityModels.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityServices.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/activityWidgets.dart';

import '../../../Widgets/buttons.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late LatestFollowRequestModel latestFollowRequestModel;
  bool isLoading = false;
  @override
  void initState() {
    getLatestFollowRequest();
    super.initState();
  }

  getLatestFollowRequest() async {
    setState(() {
      isLoading = true;
    });
    latestFollowRequestModel = await ActivityServices().fetchLatestFolloweRequests();
    setState(() {
      isLoading = false;
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
      body: 
      isLoading
          ? const Center(
              child: SpinKitWave(
                  color: Colors.white, type: SpinKitWaveType.center),
            )
          :
      SingleChildScrollView(
        child: Padding(
         padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              latestFollowRequestModel.followRequestCount == 0
                  ? const SizedBox.shrink()
                  :
              RequestsTile(
                latestFollowRequestModel: latestFollowRequestModel,
              

              ),

              
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
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
      ),
    );
  }
}


