import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:socioverse/Controllers/activityPageProvider.dart';
import 'package:socioverse/Controllers/followRequestPageProvider.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/followRequestModel.dart';
import 'package:socioverse/Services/follow_request_services.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';

class FollowRequestsPage extends StatefulWidget {
  const FollowRequestsPage({super.key});

  @override
  State<FollowRequestsPage> createState() => _FollowRequestsPageState();
}

class _FollowRequestsPageState extends State<FollowRequestsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FollowRequestPageProvider>(context, listen: false)
          .getFollowRequest();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Consumer<FollowRequestPageProvider>(builder: (context, prov, child) {
        return prov.isLoading
            ? Center(child: SpinKit.ring)
            : ListView.builder(
                itemCount: prov.followRequestModel.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircularNetworkImageWithSize(
                      imageUrl: prov.followRequestModel[index].profilePic,
                      width: 45,
                      height: 45,
                    ),
                    title: Text(
                      prov.followRequestModel[index].username,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                    ),
                    subtitle: Text(
                      prov.followRequestModel[index].occupation,
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
                            padding: const EdgeInsets.all(5),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            side: BorderSide(
                                width: 1,
                                color: Theme.of(context).colorScheme.primary,
                                style: BorderStyle.solid),
                          ),
                          onPressed: () async {
                            await FollowRequestsServices().rejectFollowRequest(
                                prov.followRequestModel[index].id);

                            prov.followRequestModel.removeAt(index);
                            if (prov.followRequestModel.isEmpty) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Delete',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                          ),
                          onPressed: () async {
                            await FollowRequestsServices().acceptFollowRequest(
                                prov.followRequestModel[index].id);
                            prov.followRequestModel.removeAt(index);

                            if (prov.followRequestModel.isEmpty && mounted) {
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Accept',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 12,
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
      }),
    );
  }
}
