import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:socioverse/Controllers/pickImagePageProvider.dart';
import 'package:socioverse/Helper/ImagePickerHelper/imagePickerHelper.dart';
import 'package:socioverse/Helper/Loading/spinKitLoaders.dart';
import 'package:socioverse/Views/Pages/NavbarScreens/Create%20Post/NewFeed/postEditPage.dart';
import 'package:socioverse/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class PickImagePage extends StatefulWidget {
  const PickImagePage({super.key});

  @override
  State<PickImagePage> createState() => _PickImagePageState();
}

class _PickImagePageState extends State<PickImagePage> {
  int currentGrid = 0;
  bool? assetType;
  final ScrollController _scrollController = ScrollController();
  Future<void> _fetchAssets() async {
    List<AssetEntity> offset = await PhotoManager.getAssetListPaged(
      pageCount: 1000,
      page: currentGrid++,
      type: RequestType.image,
    );
    if (!context.mounted) return;
    Provider.of<PickImagePageProvider>(context, listen: false).addAsset(offset);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PickImagePageProvider>(context, listen: false).dispose();
      _initializePhotoManager();
      _scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      await _fetchAssets();
    }
  }

  Future<void> _initializePhotoManager() async {
    final PermissionState state = await PhotoManager.requestPermissionExtend();
    if (state.isAuth) {
      await _fetchAssets();
      if (!context.mounted) return;
      Provider.of<PickImagePageProvider>(context, listen: false).selectedAsset =
          Provider.of<PickImagePageProvider>(context, listen: false).assets[0];

      Provider.of<PickImagePageProvider>(context, listen: false)
          .singleImageIndex = 0;
      Provider.of<PickImageLoadingProvider>(context, listen: false).loading =
          false;
    }
  }

  Icon selectedIcon() {
    return Icon(
      Icons.check_circle,
      color: Theme.of(context).colorScheme.primary,
      size: 25,
    );
  }

  Widget countPickedImages(int cnt) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        cnt.toString(),
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: Theme.of(context).colorScheme.onPrimary),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<PickImagePageProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "New Post",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
        ),
        toolbarHeight: 60,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                List<File> files = [];
                if (prov.selectedIndex.isNotEmpty) {
                  // Use Future.wait to wait for all futures to complete
                  await Future.wait(
                    List<Future>.generate(prov.selectedIndex.length,
                        (int i) async {
                      log(i.toString());
                      final value =
                          await prov.assets[prov.selectedIndex[i]].file;
                      if (value != null) {
                        files.add(value);
                      }
                    }),
                  );

                  print(files.length.toString());
                } else {
                  File? value = await prov.selectedAsset.file;
                  log(value!.path);
                  files.add(value);
                }
                if (!context.mounted) return;
                ImagePickerFunctionsHelper.cropMultipleImages(
                        context, files, false)
                    .then((value) {
                  if (value != null) {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => PostEditPage(
                                images: value,
                              )),
                    );
                  }
                });
              },
              icon: Icon(
                Icons.arrow_forward,
                color: Theme.of(context).colorScheme.primary,
                size: 30,
              )),
        ],
      ),
      body:
          Consumer<PickImageLoadingProvider>(builder: (context, pprov, child) {
        return pprov.loading == true
            ? Center(
                child: SpinKit.ring,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    // FutureBuilder<File?>(
                    //   future: selectedAsset.file,
                    //   builder:
                    //       (BuildContext context, AsyncSnapshot<File?> snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.waiting) {
                    //       return Center(
                    //           child: SizedBox(
                    //               width: MyApp.width!,
                    //               height: MyApp.width! - 20,
                    //               child: const Center(
                    //                   child: CircularProgressIndicator())));
                    //     } else if (snapshot.hasError) {
                    //       return Text('Error: ${snapshot.error}');
                    //     } else if (!snapshot.hasData) {
                    //       return const Text('No data available');
                    //     }

                    //     final bytes = snapshot.data!;
                    //     log(bytes.path);

                    //     return ClipRRect(
                    //       borderRadius: BorderRadius.circular(10),
                    //       child: SizedBox(
                    //         width: MyApp.width!,
                    //         height: MyApp.width! - 20,
                    //         child: _buildAssetWidget(bytes),
                    //       ),
                    //     );
                    //   },
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // selectorWidget(context),

                    Expanded(
                      child: GridView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: prov.assets.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder<Uint8List?>(
                                future: prov.assets[index].thumbnailData,
                                builder: (_, snapshot) {
                                  final bytes = snapshot.data;
                                  if (bytes == null) {
                                    return ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Shimmer.fromColors(
                                          baseColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            color: Colors.grey,
                                          ),
                                        ));
                                  }
                                  return Consumer<PickImagePageProvider>(
                                    builder: (context, prov, child) {
                                      return GestureDetector(
                                        onTap: () {
                                          if (prov.multiSelect == true) {
                                            if (prov.selectedIndex
                                                .contains(index)) {
                                              prov.selectedIndex.remove(index);
                                              if (prov.selectedIndex.isEmpty) {
                                                prov.multiSelect = false;
                                              }
                                            } else {
                                              prov.selectedIndex.add(index);
                                            }
                                            if (prov.selectedIndex.isNotEmpty) {
                                              prov.selectedAsset = prov.assets[
                                                  prov.selectedIndex[0]];
                                            }
                                          } else {
                                            prov.singleImageIndex = index;
                                            prov.selectedAsset =
                                                prov.assets[index];
                                          }
                                        },
                                        onLongPress: () {
                                          if (prov.multiSelect == true) {
                                            if (prov.selectedIndex
                                                .contains(index)) {
                                              prov.selectedAsset = prov.assets[
                                                  prov.selectedIndex[0]];
                                              prov.selectedIndex.remove(index);
                                              if (prov.selectedIndex.isEmpty) {
                                                prov.multiSelect = false;
                                              }
                                            } else {
                                              prov.selectedIndex.add(index);
                                            }
                                          } else {
                                            prov.multiSelect = true;
                                            prov.selectedIndex.add(index);
                                            prov.selectedAsset = prov
                                                .assets[prov.selectedIndex[0]];
                                          }
                                        },
                                        child: Stack(
                                          children: [
                                            // Wrap the image in a Positioned.fill to fill the space
                                            Positioned.fill(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.memory(bytes,
                                                    fit: BoxFit.cover),
                                              ),
                                            ),

                                            Positioned(
                                              top: 5,
                                              right: 5,
                                              child: prov.multiSelect == true
                                                  ? prov.selectedIndex
                                                          .contains(index)
                                                      ? countPickedImages(prov
                                                              .selectedIndex
                                                              .indexOf(index) +
                                                          1)
                                                      : Container()
                                                  : prov.singleImageIndex ==
                                                          index
                                                      ? selectedIcon()
                                                      : Container(),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                });
                          }),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Padding selectorWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DropdownButton(
            items: [
              DropdownMenuItem(
                value: "Gallery",
                child: Text(
                  "Gallery",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ],
            value: "Gallery",
            underline: Container(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onChanged: (value) {},
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Ionicons.camera,
                color: Theme.of(context).colorScheme.onPrimary,
              ))
        ],
      ),
    );
  }
}

// class VideoPlayerWidget extends StatefulWidget {
//   const VideoPlayerWidget({super.key, required this.file});
//   final File file;
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }

// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _controller;
//   bool _isControllerInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//   }

//   @override
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }

//   Future<void> _initializeController() async {
//     File? videoFile = await widget.file;
//     log(videoFile.path);
//     if (videoFile != null) {
//       _controller = VideoPlayerController.file(videoFile)
//         ..play()
//         // Play the video again when it ends
//         ..setLooping(true)
//         // initialize the controller and notify UI when done
//         ..initialize().then((_) => setState(() {
//               _isControllerInitialized = true;
//             }));
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _isControllerInitialized
//         ? AspectRatio(
//             aspectRatio: _controller.value.aspectRatio,
//             // Use the VideoPlayer widget to display the video.
//             child: VideoPlayer(_controller),
//           )
//         : const CircularProgressIndicator();
//   }
// }
