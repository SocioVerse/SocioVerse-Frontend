import 'dart:ffi';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:recase/recase.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Models/feedModel.dart';
import 'package:socioverse/Utils/CalculatingFunctions.dart';
import 'package:latlong2/latlong.dart';
import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:ionicons/ionicons.dart';
import 'package:socioverse/Models/locationModel.dart';
import 'package:socioverse/Services/location_services.dart';
import 'package:socioverse/Views/Widgets/Global/imageLoadingWidgets.dart';
import 'package:socioverse/Views/Widgets/buttons.dart';
import 'package:socioverse/main.dart';

class LocationProfilePage extends StatefulWidget {
  LocationSearchModel locationSearchModel;

  LocationProfilePage({
    super.key,
    required this.locationSearchModel,
  });

  @override
  State<LocationProfilePage> createState() => _LocationProfilePageState();
}

class _LocationProfilePageState extends State<LocationProfilePage> {
  int __value = 1;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AppBar(
                  title: Text(
                    "Location",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                  ),
                  toolbarHeight: 100,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  elevation: 0,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Center(
                      child: Icon(
                        Ionicons.location,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.locationSearchModel.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                        ),
                        Text(
                          "${widget.locationSearchModel.type.headerCase}, ${widget.locationSearchModel.state} ${widget.locationSearchModel.country}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                        ),
                        Text(
                          widget.locationSearchModel.postCount < 100
                              ? widget.locationSearchModel.postCount <= 1
                                  ? "${widget.locationSearchModel.postCount} Post"
                                  : "${widget.locationSearchModel.postCount} Posts"
                              : "${CalculatingFunction.numberToMkConverter(widget.locationSearchModel.postCount.toDouble())} Posts",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 15,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              MyElevatedButton1(
                title: "More Information",
                ctx: context,
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 250,
                width: MyApp.width! - 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlutterMap(
                    options: MapOptions(
                      interactiveFlags: InteractiveFlag.none,
                      center: LatLng(
                          widget.locationSearchModel.geometry.coordinates[1],
                          widget.locationSearchModel.geometry.coordinates[0]),
                      zoom: 9.2,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: const LatLng(26.9156, 75.8190),
                            width: 80,
                            height: 80,
                            builder: (context) => const Icon(
                              Ionicons.location,
                              color: Colors.red,
                              size: 30,
                              shadows: [
                                Shadow(
                                  blurRadius: 10,
                                  color: Colors.black,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(
                        Ionicons.grid_outline,
                        size: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Feeds ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                    // DropdownButton(
                    //   dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    //   focusColor: Theme.of(context).scaffoldBackgroundColor,
                    //   underline: const SizedBox.shrink(),
                    //   value: __value1,
                    //   items: [
                    //     DropdownMenuItem(
                    //       value: 1,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           const Padding(
                    //             padding: EdgeInsets.all(3.0),
                    //             child: Icon(
                    //               Ionicons.grid_outline,
                    //               size: 15,
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           Text(
                    //             "Feeds ",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium!
                    //                 .copyWith(
                    //                   fontWeight: FontWeight.w500,
                    //                   fontSize: 18,
                    //                   color:
                    //                       Theme.of(context).colorScheme.onPrimary,
                    //                 ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //     DropdownMenuItem(
                    //       value: 2,
                    //       child: Row(
                    //         crossAxisAlignment: CrossAxisAlignment.end,
                    //         children: [
                    //           const Padding(
                    //             padding: EdgeInsets.all(3.0),
                    //             child: Icon(
                    //               Ionicons.text,
                    //               size: 15,
                    //             ),
                    //           ),
                    //           const SizedBox(
                    //             width: 5,
                    //           ),
                    //           Text(
                    //             "Threads",
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium!
                    //                 .copyWith(
                    //                   fontWeight: FontWeight.w500,
                    //                   fontSize: 18,
                    //                   color:
                    //                       Theme.of(context).colorScheme.onPrimary,
                    //                 ),
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    //   onChanged: (value) {
                    //     setState(() {
                    //       __value1 = value as int;
                    //     });
                    //   },
                    // ),
                    const Spacer(),
                    DropdownButton(
                      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                      value: __value,
                      items: [
                        DropdownMenuItem(
                          value: 1,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Ionicons.time_outline,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                "Recent",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  Ionicons.trending_up,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              Text(
                                "Top",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                              ),
                            ],
                          ),
                        )
                      ],
                      onChanged: (value) {
                        setState(() {
                          __value = value as int;
                        });
                      },
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKit.ring,
                    );
                  }
                  List<FeedThumbnail> feedThumbnail =
                      snapshot.data as List<FeedThumbnail>;
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: feedThumbnail.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Positioned.fill(
                              child: RoundedNetworkImageWithLoading(
                                imageUrl: feedThumbnail[index].images[0],
                              ),
                            ),
                            Positioned(
                              bottom: 5,
                              left: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: RoundedNetworkImageWithLoading(
                                    imageUrl:
                                        feedThumbnail[index].userId.profilePic,
                                    borderRadius: 5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                },
                future: LocationServices().getLocationFeed(
                    locationId: widget.locationSearchModel.id ?? "",
                    isRecent: __value == 1 ? true : false),
              ),
            ]),
      ),
    ));
  }
}
