import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/FollowRequests/followRequestModel.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Activity/FollowRequests/followRequestServices.dart';

class FollowRequestsPage extends StatefulWidget {
  const FollowRequestsPage({super.key});

  @override
  State<FollowRequestsPage> createState() => _FollowRequestsPageState();
}

class _FollowRequestsPageState extends State<FollowRequestsPage> {

  late List<FollowRequestModel> followRequestModel;
  bool isLoading = false;
  @override
  void initState() {
    getFollowRequest();
    super.initState();
  }
  getFollowRequest() async {
    setState(() {
      isLoading = true;
    });
    followRequestModel = await FollowRequestsServices().fetchAllFolloweRequests();
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return 
     Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Follow Requests",
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
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          itemCount: followRequestModel.length,
          itemBuilder: (context, index) {
            return ListTile(
              
              leading: ClipOval(
                                        child: Image.network(
                                          followRequestModel[index].profilePic,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
              title: Text(
                followRequestModel[index].username,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
              ),
              subtitle: Text(
                followRequestModel[index].occupation,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              side: BorderSide(
                                  width: 1,
                                  color: Theme.of(context).colorScheme.primary,
                                  style: BorderStyle.solid),
                            ),
                            onPressed: () {
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                            onPressed: () {


                              FollowRequestsServices().acceptFollowRequest(followRequestModel[index].id);
                              setState(() {
                                followRequestModel.removeAt(index);
                              });
                            },
                            child: Text( 'Accept',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                )),
                          ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}